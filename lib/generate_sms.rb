class GenerateSms    

    # def initialize(acao, periodo) 
    #     @acao = acao
    #     @periodo = periodo
    # end


    def self.gerar_sms(periodo, acao, aluno)
        msn = ''
        if (acao == 'Entrada') 
            if(periodo == 'Manhã' || periodo == 'Matutino') 
              msn = "Bom dia, a(o) #{aluno} está conosco em breve estará na escola!"
             elsif (periodo == 'Vespetino' || periodo == 'Tarde') 
              msn = "Boa Tarde, a(o) #{aluno} está conosco em breve estará na escola!"
             end
        
        elsif (acao == 'Saída') 
            if(periodo == 'Manhã' || periodo == 'Matutino') 
              msn = "Bom dia, em breve a(o) #{aluno} estará em casa!"
            elsif (periodo == 'Vespetino' || periodo == 'Tarde') 
              msn = "Boa Tarde, em breve a(o) #{aluno} estará em casa!"
            end
        end  
        return msn
    end

   
end