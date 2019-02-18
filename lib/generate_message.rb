class GenerateMessage        

    def self.replace_aluno(text, aluno)        

        name = aluno.name
            if (aluno.sexo == 'feminino')                
                
                if (text.include? "o aluno") 
                    text.sub!('o aluno', " a #{name.capitalize}")
                elsif (text.include?("a aluna"))    
                    text.sub!('a aluna', " a #{name.capitalize}" )
                end

            elsif aluno.sexo == 'masculino'
                
                if (text.include?("o aluno")) 
                    text.sub!('o aluno', " o #{name.capitalize}")
                elsif (text.include?("a aluna"))    
                    text.sub!('a aluna', " o #{name.capitalize}")
                end            

            end
        

    end

    def self.gerar(periodo, acao, aluno)
        name = aluno.name
        msn = ''
        if (acao == 'entrada') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, a(o) #{name.capitalize} está conosco em breve estará na escola!"
             elsif (periodo == 'vespertino' || periodo == 'tarde') 
              msn = "Boa Tarde, a(o) #{name.capitalize} está conosco em breve estará na escola!"
              
             end
        
        elsif (acao == 'saida') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, em breve a(o) #{name.capitalize} estará em casa!"
            elsif (periodo == 'vespertino' || periodo == 'tarde') 
              msn = "Boa Tarde, em breve a(o) #{name.capitalize} estará em casa!"
            end
        end  
        return msn
    end

   
end