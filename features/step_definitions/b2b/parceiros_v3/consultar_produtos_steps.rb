Quando('é enviada uma requisição para ConsultarProdutos') do
  @consultar_produtos = parceiros_v3.consultar_produtos(@dados)
end
