Quando('é enviada uma requisição para ConfirmarPedido') do
  @confirmar_pedido = parceiros_v3.confirmar_pedido(@dados)
end
