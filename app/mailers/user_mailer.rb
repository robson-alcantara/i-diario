class UserMailer < BaseMailer
  def notify_activation(user_email, user_name, user_logged_as, domain)
    return unless user_email

    skip_domains([user_email])

    @user_name = user_name
    @user_logged_as = user_logged_as
    @domain = domain

    mail(to: @recipient, subject: 'Conta de acesso ativada') if @recipient.present?
  end

  def by_csv(login, first_name, email, password, entity)
    @login = login
    @password = password
    @recipient = email
    @name = first_name
    @entity = entity

    mail(to: @recipient, subject: 'Bem vindo ao i-Diário!') if @recipient.present?
  end
end
