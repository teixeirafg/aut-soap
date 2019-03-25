Quando('é enviada uma requisição para ConsultarTracking') do
  @consultar_tracking = parceiros_v3.consultar_tracking(@dados)
end
