# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Faker::Config.locale = 'pt-BR'
puts "Criando Usuario"
    
    a = User.create!(name: "Erik R de Souza", password: '123456', login: 'erikikoo@hotmail.com', contato: Faker::Base.numerify('(##) #####-####'), level: 3)
    
    puts "Criando Monitor"        
    5.times do
        MonitorUser.create!(name: Faker::Name.name, password: '123456', login: Faker::Name.name, user_id: a.id)
    end    
    puts 'monitor criado '

    puts 'Criando Crianças'        
    rand(1..8).times do
        Child.create!(nome: Faker::Name.name, nascimento: Faker::Date.between(2.days.ago, Date.today), responsavel: Faker::Name.name, parentesco: 'pai', sexo: 'm', contato: Faker::Base.numerify('(##) #####-####'), user_id: a.id)
    end    
    puts 'Crianças criadas'
    
    
5.times do    
    a = User.create!(name: Faker::Name.name, password: '123456', login: Faker::Internet.email, contato: Faker::Base.numerify('(##) #####-####'))
    
    puts "Criando Monitor"    
    5.times do
        b = MonitorUser.create!(name: Faker::Name.name, password: '123456', login: Faker::Name.name, user_id: a.id)           end
        
        puts 'Criando Crianças'
        rand(1..8).times do
            
            c = Child.create!(nome: Faker::Name.name, nascimento: Faker::Date.between(2.days.ago, Date.today), responsavel: Faker::Name.name, parentesco: 'pai', sexo: 'm', contato: Faker::Base.numerify('(##) #####-####'), user_id: a.id)
            
            #puts "Criando SMS"
            #rand(1..15).times do
            #    SmsMessage.create!(child_id: c.id, monitor_user_id: b.id)
            #    puts 'Usuario SMS'
            #end
            puts 'Crianças criadas'
        end    
    puts 'monitor criado '
        
    
    

    
end    


puts '==============================================='




