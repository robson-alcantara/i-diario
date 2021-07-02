# frozen_string_literal: true

class UnitiesSynchronizer
  DEFAULT_COUNTRY = 'Brasil'

  def self.synchronize!(params)
    synchronization = IeducarApiSynchronization.started.find_by(id: params[:synchronization_id])
    api = IeducarApi::Schools.new(synchronization.to_api, synchronization.full_synchronization)

    new(params).update_schools(
      HashDecorator.new(
        api.fetch_all['escolas']
      )
    )
  end

  def initialize(params)
    self.synchronization_id = params[:synchronization_id]
    self.worker_batch_id = params[:worker_batch_id]
    self.worker_state_id = params[:worker_state_id]
    self.entity_id = params[:entity_id]
    self.current_years = params[:current_years]
  end

  def update_schools(schools)
    worker_state = start_worker_state

    create_or_update_schools(schools)

    increment_worker_batch
    worker_state.end!

    unities_api_code = Unity.with_api_code.pluck(:api_code).uniq

    SynchronizerBuilderWorker.perform_async(
      klass: SchoolCalendarsSynchronizer.to_s,
      synchronization_id: synchronization_id,
      worker_batch_id: worker_batch_id,
      entity_id: entity_id,
      years: [],
      unities_api_code: unities_api_code,
      filtered_by_year: false,
      filtered_by_unity: true,
      current_years: current_years
    )
  rescue StandardError => error
    worker_state.mark_with_error!(error.message) if error.message != '502 Bad Gateway'

    raise error
  end

  private

  attr_accessor :synchronization_id, :worker_batch_id, :worker_state_id, :entity_id, :current_years

  def create_or_update_schools(schools)
    schools.each do |school_record|
      duplicate_unity = Unity.find_by('name = ?', school_record.nome)
      next if duplicate_unity && duplicate_unity.api_code != school_record.cod_escola

      Unity.find_or_initialize_by(
        api_code: school_record.cod_escola
      ).tap do |unity|
        unity.name = school_record.nome
        unity.email = school_record.email.try(:strip)
        unity.phone = format_phone(school_record)
        unity.responsible = school_record.nome_responsavel
        unity.unit_type = UnitTypes::SCHOOL_UNIT
        unity.api = true
        unity.author_id = author.id
        unity.active = school_record.ativo

        unity.address ||= unity.build_address
        unity.address.street = school_record.logradouro
        unity.address.zip_code = format_cep(school_record.cep)
        unity.address.number = school_record.numero
        unity.address.complement = school_record.complemento
        unity.address.neighborhood = school_record.bairro
        unity.address.city = school_record.municipio
        unity.address.state = school_record.uf.try(&:downcase)
        unity.address.country = DEFAULT_COUNTRY

        unity.save(validate: false) if unity.changed?
      end
    end
  end

  def start_worker_state
    worker_state = WorkerState.find(worker_state_id)
    worker_state.start!

    worker_state
  end

  def increment_worker_batch
    worker_batch = WorkerBatch.find(worker_batch_id)
    worker_batch.increment
  end

  def format_phone(record)
    "(#{record.ddd}) #{record.fone}" if record.fone.present?
  end

  def format_cep(value)
    return nil if value.blank? || value.strip.blank?

    value = value.strip.gsub(/[^\d+]/, '')

    return nil if value.length != 8

    pre, suf = value.match(/([0-9]{5})([0-9]{3})/).captures

    "#{pre}-#{suf}"
  end

  def author
    @author ||= User.admin.first
  end
end
