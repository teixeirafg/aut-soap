Quando('é enviada uma requisição para ConsultarProduto') do
  @consultar_produto = parceiros_v3.consultar_produto(@dados)
end
