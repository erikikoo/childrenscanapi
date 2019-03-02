class GenerateMessage        

    def self.replace_aluno(text, aluno)        

        name = aluno.name
        text = text.downcase.capitalize
        
            if (aluno.sexo == 'feminino')                
                
                if (text.include?("o aluno")) 
                    text.sub!('o aluno', " a #{customCapitalize(name)}")
                elsif (text.include?("a aluna"))    
                    text.sub!('a aluna', " a #{customCapitalize(name)}" )
                end

            elsif aluno.sexo == 'masculino'
                
                if (text.include?("o aluno")) 
                    text.sub!('o aluno', " o #{customCapitalize(name)}")
                elsif (text.include?("a aluna"))    
                    text.sub!('a aluna', " o #{customCapitalize(name)}")
                end            

            end
        return text

    end

    def self.gerar(periodo, acao, aluno)
        name = aluno.name
        sexo = aluno.sexo
        msn = ''
        if (acao == 'entrada') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, #{sexo == :masculino ? 'o' : 'a' } #{customCapitalize(name)} está conosco em breve estará na escola!"
             elsif (periodo == 'vespertino' || periodo == 'tarde') 
              msn = "Boa Tarde, #{sexo == :masculino ? 'o' : 'a' } #{customCapitalize(name)} está conosco em breve estará na escola!"
              
             end
        
        elsif (acao == 'saida') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, em breve #{sexo == :masculino ? 'o' : 'a' } #{customCapitalize(name)} estará em casa!"
            elsif (periodo == 'vespertino' || periodo == 'tarde') 
              msn = "Boa Tarde, em breve #{sexo == :masculino ? 'o' : 'a' } #{customCapitalize(name)} estará em casa!"
            end
        end  
        return msn
    end

    def self.customCapitalize name
        name_form = ''  
        name.split.each do |s|
            name_form << " #{s.capitalize}"
        end
        return name_form.lstrip
    end
   
end