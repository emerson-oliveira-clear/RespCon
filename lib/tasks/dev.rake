namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    if Rails.env.development?

      show_spinner("Apagando DB..."){%x(rails db:drop)} 
    
      show_spinner("Criando DB..."){%x(rails db:create)}
      
      show_spinner("Migrando DB..."){%x(rails db:migrate)}
      
      show_spinner("Cadastrando o administrador padrão..."){%x(rails dev:add_default_admin)}

      show_spinner("Cadastrando administrador extras..."){%x(rails dev:add_extras_admins)}

      show_spinner("Cadastrando o usuario padrão..."){%x(rails dev:add_default_user)}
      
      show_spinner("Cadastrando assuntos padrões...") { %x(rails dev:add_subjects) }

      show_spinner("Cadastrando algumas questões e respostas...") { %x(rails dev:add_answers_and_questions) }


      #%x(rails dev:add_mining_types)
      #%x(rails dev:add_coins)
     
      
    else

      puts "voce não está em ambiente de desenvolvimento!"

    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administrador extras"
    task add_extras_admins: :environment do
      10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
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


  desc "Adiciona assuntos padrões"
    task add_subjects: :environment do
      file_name = 'subjects.txt'
      file_path = File.join(DEFAULT_FILES_PATH, file_name)

      File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  
  desc "Adiciona perguntas e respostas"
    task add_answers_and_questions: :environment do
      Subject.all.each do |subject|
        rand(5..10).times do |i|
          params = {
            question: {
              description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
                subject: subject,
                  answers_attributes: []
            }
          }
          rand(2..5).times do |i|
            params[:question][:answers_attributes].push(
              {description: Faker::Lorem.sentence, correct: false}
            )
          end

          params[:question][:answers_attributes][
            rand(params[:question][:answers_attributes].size)
          ] = {description: Faker::Lorem.sentence, correct: true}

          Question.create!(params[:question])
      end
    end
  end
 
  desc "Reseta o contador dos assuntos"
    task reset_subject_counter: :environment do
      show_spinner("Resetando contador dos assuntos...") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end


  private

  def show_spinner(msg_start,msg_end = "concluido com sucesso")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin 
    yield
    spinner.success("(#{msg_end})")
  end
end
