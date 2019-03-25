module CommonsServices
  def get_pedido_disponivel(id_campanha, tentativas = 5)
    pedparc = ''
    status = false
    tentativas.times do
      pedparc = rand(9_999_000_000..9_999_910_999)
      dados = { 'id_campanha' => id_campanha, 'id_pedido_parceiro' => pedparc }
      response = parceiros_v3.consultar_pedido_parceiro(dados)
      msg_erro = response['response'].xpath('//MensagemDeErro').text
      if msg_erro.eql?('Pedido não encontrado.')
        status = true
        break
      end
    end
    raise "Após #{tentativas} tentativas, não foi localizado um pedido disponível" if status.eql?(false)
    pedparc
  end

  def expect_no_errors(response, status_code = 200)
    response.xpath('//Erro').each_with_index do |obj, i|
      response_erro = to_boolean(obj.text)
      response_msg_erro = response.xpath('//MensagemDeErro')[i].text
      expect(response_erro).not_to be(true), "\n\n#### Falha na Requisição #### \nMensagem de Erro: \n#{response_msg_erro}\n\n"
    end
    expect(response.http.code).to eql(status_code)
  end
end
