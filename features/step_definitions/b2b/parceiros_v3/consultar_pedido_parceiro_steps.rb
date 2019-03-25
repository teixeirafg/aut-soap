Quando('é enviada uma requisição para ConsultarPedidoParceiro') do
  @consultar_pedido_parceiro = parceiros_v3.consultar_pedido_parceiro(@dados)
end
