Quando('é enviada uma requisição para ConfirmarReserva') do
  @confirmar_reserva = parceiros_v3.confirmar_reserva(@dados)
end
