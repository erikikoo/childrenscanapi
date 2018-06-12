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
    
    User.create!(name: "Erik R de Souza", password: '123456', login: 'erikikoo@hotmail.com', contato: Faker::Base.numerify('(##) #####-####'), level: 3)
    User.create!(name: "Paula Cristina", password: '123456', login: 'paula@paula.com', contato: Faker::Base.numerify('(##) #####-####'))
20.times do    
    User.create!(name: Faker::Name.name, password: '123456', login: Faker::Internet.email, contato: Faker::Base.numerify('(##) #####-####'))
end    
puts 'Usuario criado'
puts '==============================================='
puts 'Criando Crianças'
100.times do
    Child.create!(nome: Faker::Name.name, nascimento: Faker::Date.between(2.days.ago, Date.today), responsavel: Faker::Name.name, parentesco: 'pai', sexo: 'm', contato: Faker::Base.numerify('(##) #####-####'), user_id: rand(1..2))
end
puts 'Crianças criadas'
puts '==============================================='
puts "Criando Monitor"
5.times do
    MonitorUser.create!(name: Faker::Name.name, password: '123456', login: Faker::Name.name, user_id: rand(1..2))
end
puts 'Usuario monitor'

puts '==============================================='
puts "Criando SMS"
200.times do
    SmsMessage.create!(child_id: rand(1..100), monitor_user_id: rand(1..5),user_id: 2, status: rand(0..1))
end
puts 'Usuario SMS'



