namespace :user do
  namespace :create do
    desc 'Create users by csv'
    task by_csv: :environment do
      user_creator = UserByCsvCreator.new(ENV)

      user_creator.create

      puts user_creator.status
    end
  end
  namespace :reset do
    desc 'Reset password'
    task reset_password: :environment do
      user_updater = ResetPasswordService.new(ENV)

      user_updater.update

      puts user_updater.status
    end
  end
end
