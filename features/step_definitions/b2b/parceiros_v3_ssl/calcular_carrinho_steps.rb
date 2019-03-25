Dado('que tenha o valor do produto sem benefícios aplicados') do
  calcular_carrinho = parceiros_v3_ssl.calcular_carrinho(@dados_padrao)
  expect_no_errors(calcular_carrinho['response'])

  @produto = {
    'valor_unitario' => calcular_carrinho['response'].xpath('//ValorTotal').first.text.to_f,
    'valor_frete' => calcular_carrinho['response'].xpath('//ValorTotalFrete').first.text.to_f
  }
end

Dado('que informe outros dados para que o benefício não seja concedido') do |table|
  tipo_beneficio = table.rows_hash['tipo_beneficio']
  dado_nao_concede = table.rows_hash['dado']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  cod_produto = massa_dados[tipo_beneficio]['nao_concede_beneficios'][dado_nao_concede]
  @dados_padrao.merge!(cod_produto)
  @dados.merge!(cod_produto)
end

Dado('que tenha uma campanha que não conceda benefícios') do
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_catalogo']['sem_alteracao_preco']
  @dados_padrao = @dados.merge(massa_dados['beneficio_catalogo']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda desconto no valor do produto') do |table|
  beneficio_em = table.rows_hash['beneficio_em']
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_catalogo']['desconto'][item][beneficio_em]
  @dados_padrao = @dados.merge(massa_dados['beneficio_catalogo']['dados_padrao'])
end

Dado('que tenha uma campanha que gere indisponibilidade para catálogo') do |table|
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_catalogo']['indisponibilidade'][item]
  @dados_padrao = @dados.merge(massa_dados['beneficio_catalogo']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda acréscimo no valor do produto') do |table|
  beneficio_em = table.rows_hash['beneficio_em']
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_catalogo']['acrescimo'][item][beneficio_em]
  @dados_padrao = @dados.merge(massa_dados['beneficio_catalogo']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda preço específico para um produto') do |table|
  item = table.rows_hash['metodo']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_catalogo']['preco_especifico'][item]
  @dados_padrao = @dados.merge(massa_dados['beneficio_catalogo']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda mais de um benefício') do
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_catalogo']['mais_de_um_beneficio']
  @dados_padrao = @dados.merge(massa_dados['beneficio_catalogo']['dados_padrao'])
end

Quando('é enviada uma requisição para CalcularCarrinho') do
  @calcular_carrinho = parceiros_v3_ssl.calcular_carrinho(@dados)
end

Então('o serviço responde com status code {int}') do |status_code, table|
  var = table.rows_hash['servico']
  servico = instance_variable_get("@#{var}")
  expect(servico['response'].http.code).to eql(status_code)
end

Então('é exibida mensagem de indisponiblidade do produto') do
  step 'o serviço responde com status code 200', table(%(| servico | calcular_carrinho |))

  msg_erro_sku = "sku:[#{@dados['lista_produtos'].first['produto']['codigo_produto']}]- Erro: Produto Indisponivel."
  expect(@calcular_carrinho['response'].xpath('//CodigoDoErro').first.text).to eql('ProdutoIndisponivel')
  expect(to_boolean(@calcular_carrinho['response'].xpath('//Erro').first.text)).to be true
  expect(@calcular_carrinho['response'].xpath('//MensagemDeErro').first.text.strip).to eql(msg_erro_sku)

  expect(@calcular_carrinho['response'].xpath('//ListaProdutoCarrinhoDTO//CodigoDoErro').text).to eql('ProdutoIndisponivel')
  expect(@calcular_carrinho['response'].xpath('//ListaProdutoCarrinhoDTO//MensagemDeErro').text).to eql('Produto Indisponivel.')
  expect(@calcular_carrinho['response'].xpath('//ListaProdutoCarrinhoDTO//ValorTotal').text.to_f).to eql(0.0)
  puts "Mensagem de Retorno do serviço: #{msg_erro_sku}"

  expect(@calcular_carrinho['response'].xpath('//ValorFrete').text.to_f).to eql(0.0)
  expect(@calcular_carrinho['response'].xpath('//ValorTotaldoPedido').text.to_f).to eql(0.0)
  expect(@calcular_carrinho['response'].xpath('//ValorTotaldosProdutos').text.to_f).to eql(0.0)
end

Então('o valor do produto é igual ao preço específico cadastrado') do
  expect_no_errors(@calcular_carrinho['response'])

  vlr_produto_response = @calcular_carrinho['response'].xpath('//ValorTotal').first.text.to_f
  puts "Valor do Produto Sem Benefícios Aplicados: R$#{@produto['valor_unitario']}"
  puts "Valor Cadastrado Durante a Importação do Arquivo: R$#{@dados['valor_cadastrado']}"
  puts "Valor do Produto (Resposta da API): R$#{vlr_produto_response} (preço específico)"
  expect(@dados['valor_cadastrado']).to eql(vlr_produto_response)
  expect(@produto['valor_unitario']).not_to eql(vlr_produto_response)
end

Então('o valor total do produto apresentado é conforme os benefícios concedidos') do
  expect_no_errors(@calcular_carrinho['response'])

  vlr_produto_com_beneficio = @produto['valor_unitario']
  puts "Valor do Produto Sem Benefícios Aplicados: R$#{@produto['valor_unitario']}"

  puts '======================================================'
  @dados['lista_beneficios'].each do |item|
    tipo_beneficio = item['beneficio']['tipo_beneficio']
    beneficio_em = item['beneficio']['beneficio_em']
    valor = item['beneficio']['valor']
    beneficio_aplicado = beneficio_em.eql?('porcentagem') ? "#{valor}%" : "R$#{valor}"
    puts "#{tipo_beneficio.capitalize} no valor do produto (a ser aplicado): #{beneficio_aplicado}"

    vlr_produto_com_beneficio = calcular_beneficio(vlr_produto_com_beneficio, tipo_beneficio, beneficio_em, valor)
    puts "Valor do Produto após concessão do benefício: R$#{vlr_produto_com_beneficio}"
  end
  vlr_produto_response = @calcular_carrinho['response'].xpath('//ValorTotal').first.text.to_f
  puts '======================================================'

  puts "Valor do Produto com os benefícios aplicados: R$#{vlr_produto_com_beneficio}"
  puts "Valor do Produto (resposta da API): R$#{vlr_produto_response}"
  expect(vlr_produto_com_beneficio).to eql(vlr_produto_response)
end

Então('o benefício não é aplicado no cálculo do valor do pedido') do
  expect_no_errors(@calcular_carrinho['response'])

  vlr_produto = @produto['valor_unitario']
  vlr_produto_response = @calcular_carrinho['response'].xpath('//ValorTotal').first.text.to_f
  puts "Valor do Produto Sem Benefícios Aplicados: R$#{vlr_produto}"
  puts "Valor do Produto (resposta da API): R$#{vlr_produto_response}"
  expect(vlr_produto_response).to eql(vlr_produto)

  vlr_frete = @produto['valor_frete']
  vlr_frete_response = @calcular_carrinho['response'].xpath('//ValorFrete').text.to_f
  puts "Valor do Frete Sem Benefícios Aplicados: R$#{vlr_frete}"
  puts "Valor do Frete (resposta da API): R$#{vlr_frete_response}"
  expect(vlr_frete_response).to eql(vlr_frete)

  vlr_pedido = (vlr_produto + vlr_frete).round(2)
  vlr_pedido_response = @calcular_carrinho['response'].xpath('//ValorTotaldoPedido').text.to_f
  puts "Valor do Pedido (Produto + Frete): R$#{vlr_pedido_response}"
  expect(vlr_pedido_response).to eql(vlr_pedido)
end

Então('o valor do frete apresentado é conforme os benefícios concedidos') do
  expect_no_errors(@calcular_carrinho['response'])

  vlr_frete = @produto['valor_frete']
  puts "Valor do Frete Sem Benefícios Aplicados: R$#{@produto['valor_frete']}"

  puts '======================================================'
  @dados['lista_beneficios'].each do |item|
    tipo_beneficio = item['beneficio']['tipo_beneficio']
    beneficio_em = item['beneficio']['beneficio_em']
    valor = item['beneficio']['valor']
    beneficio_aplicado = beneficio_em.eql?('porcentagem') ? "#{valor}%" : "R$#{valor}"
    puts "#{tipo_beneficio.capitalize} no valor do Frete (a ser aplicado): #{beneficio_aplicado}"

    vlr_frete = calcular_beneficio(vlr_frete, tipo_beneficio, beneficio_em, valor)
    puts "Valor de Frete após concessão do benefício: R$#{vlr_frete}"
  end
  vlr_frete_response = @calcular_carrinho['response'].xpath('//ValorFrete').text.to_f
  puts '======================================================'

  puts "Valor do Frete com os benefícios aplicados: R$#{vlr_frete}"
  puts "Valor do Frete (resposta da API)): R$#{vlr_frete_response}"
  expect(vlr_frete).to eql(vlr_frete_response)

  vlr_pedido = (vlr_frete + @produto['valor_unitario']).round(2)
  vlr_pedido_response = @calcular_carrinho['response'].xpath('//ValorTotaldoPedido').text.to_f
  puts "Valor do Pedido (Produto + Frete): R$#{vlr_pedido_response}"
  expect(vlr_pedido).to eql(vlr_pedido_response)
end

Dado('que tenha uma campanha que conceda acréscimo no valor do frete') do |table|
  beneficio_em = table.rows_hash['beneficio_em']
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_frete']['acrescimo'][item][beneficio_em]
  @dados_padrao = @dados.merge(massa_dados['beneficio_frete']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda valor fixo no frete') do |table|
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_frete']['valor_fixo'][item]
  @dados_padrao = @dados.merge(massa_dados['beneficio_frete']['dados_padrao'])
end

Então('o valor do frete apresentado é igual ao valor cadastrado') do
  expect_no_errors(@calcular_carrinho['response'])

  vlr_frete_response = @calcular_carrinho['response'].xpath('//ValorFrete').text.to_f
  puts "Valor do Frete Sem Benefícios Aplicados: R$#{@produto['valor_frete']}"
  puts "Valor #{@dados['tipo_beneficio'].capitalize} de Frete que foi cadastrado: R$#{vlr_frete_response}"
  expect(@dados['valor_cadastrado']).to eql(vlr_frete_response)
  expect(@produto['valor_frete']).not_to eql(vlr_frete_response)

  vlr_pedido = (@dados['valor_cadastrado'] + @produto['valor_unitario']).round(2)
  vlr_pedido_response = @calcular_carrinho['response'].xpath('//ValorTotaldoPedido').text.to_f
  puts "Valor do Pedido (Produto + Frete): R$#{vlr_pedido_response}"
  expect(vlr_pedido).to eql(vlr_pedido_response)
end

Dado('que tenha uma campanha que limite o valor mínimo de frete') do |table|
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_frete']['valor_minimo'][item]
  @dados_padrao = @dados.merge(massa_dados['beneficio_frete']['dados_padrao'])
end

Dado('que tenha uma campanha que limite o valor máximo de frete') do |table|
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_frete']['valor_maximo'][item]
  @dados_padrao = @dados.merge(massa_dados['beneficio_frete']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda desconto no frete conforme regra') do |table|
  regra = table.rows_hash['regra']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_frete']['regra'][regra]['desconto']
  @dados_padrao = @dados.merge(massa_dados['beneficio_frete']['dados_padrao'])
end

Dado('que tenha uma campanha que conceda frete grátis') do |table|
  beneficio_em = table.rows_hash['beneficio_em']
  item = table.rows_hash['aplicado_para']
  massa_dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3_ssl/calcular_carrinho.yml")
  @dados = massa_dados['beneficio_frete']['frete_gratis'][item][beneficio_em]
  @dados_padrao = @dados.merge(massa_dados['beneficio_frete']['dados_padrao'])
end
