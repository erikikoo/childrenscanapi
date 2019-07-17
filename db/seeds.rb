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
    
User.create!(name: "Erik R de Souza", password: 'HayHelena', login: 'erikikoo@hotmail.com', contato: Faker::Base.numerify('(##) #####-####'), level: 3)

a = User.create!(name: "Transporte", password: 'transporte', login: 'transporte', contato: Faker::Base.numerify('(##) #####-####'), level: 2)
puts "Criando Usuario"
b = MonitorUser.create!(name: 'Monitor de Teste', password: 'monitor', login: 'monitor', user_id: a.id)
puts "Criando Monitor"     

puts "add escola"
5.times do 
    Escola.create!(nome: Faker::Name.name, user_id: a.id)
end
#         puts 'Criando Crianças'
        # rand(1..20).times do
            
        #     c = Child.create!(name: Faker::Name.name, nascimento: Faker::Date.between(2.days.ago, Date.today), responsavel: Faker::Name.name, sexo: rand(0..1), contato: Faker::Base.numerify('(##) #####-####'), user_id: a.id, uid: GenerateUid.generate, escola_id: rand(1..5), venc: rand(1..31))
        # end
#             puts "Criando SMS"
#             rand(1..15).times do
#                 SmsMessage.create!(child_id: c.id, monitor_user_id: b.id, periodo: rand(0..3), acao: rand(0..1))
#                 puts 'Usuario SMS'
#             end
#             puts 'Crianças criadas'
#         end    
#     puts 'monitor criado '

# 5.times do    
#     a = User.create!(name: Faker::Name.name, password: '123456', login: Faker::Internet.email, contato: Faker::Base.numerify('(##) #####-####'))
    
#     puts "Criando Monitor"    
#     5.times do
#         b = MonitorUser.create!(name: Faker::Name.name, password: '123456', login: Faker::Name.name, user_id: a.id)
        
#         puts 'Criando Crianças'
#         rand(1..20).times do
            
#             c = Child.create!(name: Faker::Name.name, nascimento: Faker::Date.between(2.days.ago, Date.today), responsavel: Faker::Name.name, parentesco: rand(0..2), sexo: rand(0..1), contato: Faker::Base.numerify('(##) #####-####'), user_id: a.id)
            
#             puts "Criando SMS"
#             rand(1..15).times do
#                 SmsMessage.create!(child_id: c.id, monitor_user_id: b.id, periodo: rand(0..3), acao: rand(0..1))
#                 puts 'Usuario SMS'
#             end
#             puts 'Crianças criadas'
#         end    
#     puts 'monitor criado '
        
    
#     end  

    
# end    


# puts '==============================================='


#Child.create!(name: 'Haianny Cristina Silva Souza' , nascimento: '31/07/2012', responsavel: 'Paula Cristina', parentesco: 'mae', sexo: 'feminino', contato: '1194632-1530', user_id: 1)

