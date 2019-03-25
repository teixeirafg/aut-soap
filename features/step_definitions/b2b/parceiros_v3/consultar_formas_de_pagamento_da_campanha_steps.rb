Quando('é enviada uma requisição para ConsultarFormasDePagamentoDaCampanha') do
  @consultar_formas_de_pagamento_da_campanha = parceiros_v3.consultar_formas_de_pagamento_da_campanha(@dados)
end
