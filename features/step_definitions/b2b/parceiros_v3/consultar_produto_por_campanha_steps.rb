Quando('é enviada uma requisição para ConsultarProdutoPorCampanha') do
  @consultar_produto_por_campanha = parceiros_v3.consultar_produto_por_campanha(@dados)
end
