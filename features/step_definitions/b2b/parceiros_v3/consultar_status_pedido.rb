Quando('é enviada uma requisição para ConsultarStatusPedido') do
  @consultar_status_pedido = parceiros_v3.consultar_status_pedido(@dados)
end
