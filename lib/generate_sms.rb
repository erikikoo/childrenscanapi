class GenerateSms    
    
    # def initialize(acao, periodo) 
    #     @acao = acao
    #     @periodo = periodo
    # end

    def self.replace_aluno(text, aluno)
        
         
            if (aluno.sexo == 'feminino')                
                
                if (text.message_text.include? "o aluno") 
                    text.message_text.sub!('o aluno', " a #{aluno.name}")
                elsif (text.message_text.include?("a aluna"))    
                    text.message_text.sub!('a aluna', " a #{aluno.name}" )
                end

            elsif aluno.sexo == 'masculino'
                
                if (text.message_text.include?("o aluno")) 
                    text.message_text.sub!('o aluno', " o #{aluno.name}")
                elsif (text.message_text.include?("a aluna"))    
                    text.message_text.sub!('a aluna', " o #{aluno.name}")
                end            

            end
        

    end

    def self.gerar_sms(periodo, acao, aluno)
        msn = ''
        if (acao == 'entrada') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, a(o) #{aluno} está conosco em breve estará na escola!"
             elsif (periodo == 'vespetino' || periodo == 'tarde') 
              msn = "Boa Tarde, a(o) #{aluno} está conosco em breve estará na escola!"
             end
        
        elsif (acao == 'saida') 
            if(periodo == 'manha' || periodo == 'matutino') 
              msn = "Bom dia, em breve a(o) #{aluno} estará em casa!"
            elsif (periodo == 'vespetino' || periodo == 'tarde') 
              msn = "Boa Tarde, em breve a(o) #{aluno} estará em casa!"
            end
        end  
        return msn
    end

   
end