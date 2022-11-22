namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "config dev"
  task setup: :environment do
    if Rails.env.development?
    show_spinner("Apagando bd") {%x(rails db:drop:_unsafe)}
    show_spinner("Criando bd..."){%x(rails db:create)}
    show_spinner("Migrando bd..."){%x(rails db:migrate)}
    show_spinner("Povoando bd..."){%x(rails db:seed)}
    show_spinner("Adicionando administradores extras..."){ %x(rails dev:add_extra_admins)}
    show_spinner("Criando user..."){%x(rails dev:add_default_user)}
      else
    puts "Not in development"
    end
  
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
  end 
  desc "Adiciona o Admin padrão"
  task add_default_admin: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: 123456
    )
  end

desc "Adiciona outros administradores extras"
task add_extra_admins: :environment do
    10.times do |i|
    Admin.create!(
    email: Faker::Internet.email,
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
end
end

  private
  def show_spinner(msg_start, msg_end = 'Concluido.')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :dots)
    spinner.auto_spin # Automatic animation with default interval
     yield
     spinner.success("(#{msg_end})")
  end
end