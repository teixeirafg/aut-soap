Dado('que tenha um payload padrão do serviço') do |table|
  operation = table.rows_hash['servico']
  @dados = YAML.load_file("#{PATH_MASSA}/parceiros_v3/#{operation}.yml")['health_check']
end

Quando('é enviada uma requisição para ConsultarFretePedidoCampanha') do
  @consultar_frete_pedido_campanha = parceiros_v3.consultar_frete_pedido_campanha(@dados)
end
