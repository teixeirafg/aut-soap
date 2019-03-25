Dado("que eu tenha um pedido") do |table|
  item = table.rows_hash['tipo']
  @dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3/criar_pedido.yml")[item]
  @dados['pedido_parceiro'] = get_pedido_disponivel(@dados['campanha'])
  puts "O Pedido Parceiro #{@dados['pedido_parceiro']} é valido para ser utilizado!."
end

Quando("é enviada uma requisição para CriarPedido") do
  @criar_pedido = parceiros_v3.criar_pedido(@dados)
end

Então("posso ver que o pedido foi gravado") do
  step 'o serviço responde com status code 200', table(%(| servico | criar_pedido |))
  response_erro = @criar_pedido['response'].xpath('//Erro').text
  response_msg_erro = @criar_pedido['response'].xpath('//MensagemDeErro').text
  expect(response_erro).not_to eql('true'), "\n\n#### Falha na Requisição #### \nMensagem de Erro: \n#{response_msg_erro}\n\n"
  expect(@criar_pedido['response'].xpath('//CodigoPedido').text).not_to eql('0')
  puts "O Pedido Parceiro #{@criar_pedido['response'].xpath('//PedidoParceiro').text} inexistente na base foi incluído!"
end

Então("posso ver que o pedido não foi gravado") do
  step 'o serviço responde com status code 200', table(%(| servico | criar_pedido |))
  expect(@criar_pedido['response'].xpath('//Erro').text).to eql('true')
  expect(@criar_pedido['response'].xpath('//PedidoParceiro').text).to eql('0')
  response_msg_erro = @criar_pedido['response'].xpath('//MensagemDeErro').text
  expect(response_msg_erro).to match('Pedido não pode ser finalizado')
  puts "Pedido #{@dados['pedido_parceiro']} nao gravado, o valor informado no produto #{@dados['codigo']} difere do correto!"
end
