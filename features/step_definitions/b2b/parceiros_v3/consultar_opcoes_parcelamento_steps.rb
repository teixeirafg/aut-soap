Quando('é enviada uma requisição para ConsultarOpcoesParcelamento') do
  @consultar_opcoes_parcelamento = parceiros_v3.consultar_opcoes_parcelamento(@dados)
end
