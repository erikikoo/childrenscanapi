class GenerateMessage        

    def self.replace_aluno(text, aluno)        
         
            if (aluno.sexo == 'feminino')                
                
                if (text.include? "o aluno") 
                    text.sub!('o aluno', " a #{aluno.name}")
                elsif (text.include?("a aluna"))    
                    text.sub!('a aluna', " a #{aluno.name}" )
                end

            elsif aluno.sexo == 'masculino'
                
                if (text.include?("o aluno")) 
                    text.sub!('o aluno', " o #{aluno.name}")
                elsif (text.include?("a aluna"))    
                    text.sub!('a aluna', " o #{aluno.name}")
                end            

            end
        

    end

    def self.gerar(periodo, acao, aluno)
        msn = ''
        if (acao == 'entrada') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, a(o) #{aluno.name} está conosco em breve estará na escola!"
             elsif (periodo == 'vespertino' || periodo == 'tarde') 
              msn = "Boa Tarde, a(o) #{aluno} está conosco em breve estará na escola!"
              
             end
        
        elsif (acao == 'saida') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, em breve a(o) #{aluno.name} estará em casa!"
            elsif (periodo == 'vespertino' || periodo == 'tarde') 
              msn = "Boa Tarde, em breve a(o) #{aluno.name} estará em casa!"
            end
        end  
        return msn
    end

   
end