class GenerateSms    
    
    # def initialize(acao, periodo) 
    #     @acao = acao
    #     @periodo = periodo
    # end


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