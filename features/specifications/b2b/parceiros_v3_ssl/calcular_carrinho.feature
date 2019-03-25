#language: pt
@parceiros_v3_ssl
@calcular_carrinho
@b2b
@FullSmoke
@BacklogB2bSquad
@ignoreStg @ignoreDev
Funcionalidade: ParceirosV3 SSL - Calcular Carrinho
  Como uma aplicação de serviço
  Quero enviar requisições para a operação CalcularCarrinho
  Para verificar se o calculo de venda do produto é feito corretamente

  @catalogo_beneficio_sem_alteracao
  Cenário: Preço Lojista Sem Alteração
    Dado que tenha uma campanha que não conceda benefícios
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor total do produto apresentado é conforme os benefícios concedidos


  @catalogo_beneficio_desconto
  Esquema do Cenário: Preço Lojista com Benefício de Desconto no Catálogo
    Dado que tenha uma campanha que conceda desconto no valor do produto
      | beneficio_em  | <beneficio_em>  |
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor total do produto apresentado é conforme os benefícios concedidos

    @ignorePrd
    Exemplos:
      | beneficio_em | aplicado_para  |
      | dinheiro     | categoria      |
      | dinheiro     | marca          |
      | dinheiro     | produto        |

    Exemplos:
      | beneficio_em | aplicado_para  |
      | porcentagem  | categoria      |
      | porcentagem  | marca          |
      | porcentagem  | produto        |



  @negativo_catalogo_beneficio_desconto
  Esquema do Cenário: Não Concessão de Benefício de Desconto no Catálogo
    Dado que tenha uma campanha que conceda desconto no valor do produto
      | beneficio_em  | <beneficio_em>  |
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_catalogo |
      | dado           | produto            |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    @ignorePrd
    Exemplos:
      | beneficio_em | aplicado_para  |
      | dinheiro     | categoria      |
      | dinheiro     | marca          |
      | dinheiro     | produto        |

    Exemplos:
      | beneficio_em | aplicado_para  |
      | porcentagem  | categoria      |
      | porcentagem  | marca          |
      | porcentagem  | produto        |


  @catalogo_beneficio_indisponibilidade
  Esquema do Cenário: Produto com Benefício de Indisponibilidade
    Dado que tenha uma campanha que gere indisponibilidade para catálogo
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então é exibida mensagem de indisponiblidade do produto

    Exemplos:
      | aplicado_para |
      | categoria     |
      | marca         |
      | produto       |


  @negativo_catalogo_beneficio_indisponibilidade
  Esquema do Cenário: Não Concessão de Benefício de Indisponibilidade
    Dado que tenha uma campanha que gere indisponibilidade para catálogo
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_catalogo |
      | dado           | produto            |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    Exemplos:
      | aplicado_para |
      | categoria     |
      | marca         |
      | produto       |


  @catalogo_beneficio_acrescimo
  Esquema do Cenário: Preço Lojista com Benefício de Acréscimo no Catálogo
    Dado que tenha uma campanha que conceda acréscimo no valor do produto
      | beneficio_em  | <beneficio_em>  |
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor total do produto apresentado é conforme os benefícios concedidos

    @ignorePrd
    Exemplos:
      | beneficio_em | aplicado_para  |
      | dinheiro     | categoria      |
      | dinheiro     | marca          |
      | dinheiro     | produto        |

    Exemplos:
      | beneficio_em | aplicado_para  |
      | porcentagem  | categoria      |
      | porcentagem  | marca          |
      | porcentagem  | produto        |



  @negativo_catalogo_beneficio_acrescimo
  Esquema do Cenário: Não Concessão de Benefício de Acréscimo no Catálogo
    Dado que tenha uma campanha que conceda acréscimo no valor do produto
      | beneficio_em  | <beneficio_em>  |
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_catalogo |
      | dado           | produto            |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    @ignorePrd
    Exemplos:
      | beneficio_em | aplicado_para  |
      | dinheiro     | categoria      |
      | dinheiro     | marca          |
      | dinheiro     | produto        |

    Exemplos:
      | beneficio_em | aplicado_para  |
      | porcentagem  | categoria      |
      | porcentagem  | marca          |
      | porcentagem  | produto        |


  @ignorePrd
  @catalogo_beneficio_preco_especifico
  Cenário: Preço Lojista com Preço Específico de Produto via Importação de Arquivo
    Dado que tenha uma campanha que conceda preço específico para um produto
      | metodo | importacao_arquivo |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do produto é igual ao preço específico cadastrado


  @ignorePrd
  @negativo_catalogo_beneficio_preco_especifico
  Cenário: Não Concessão de Preço Específico de Produto via Importação de Arquivo
    Dado que tenha uma campanha que conceda preço específico para um produto
      | metodo | importacao_arquivo |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_catalogo |
      | dado           | produto            |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido


  @catalogo_mais_de_um_beneficio
  Cenário: Preço Lojista com Mais de Um Benefício
    Dado que tenha uma campanha que conceda mais de um benefício
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor total do produto apresentado é conforme os benefícios concedidos


  @negativo_catalogo_mais_de_um_beneficio
  Cenário: Não Concessão com Mais de Um Benefício
    Dado que tenha uma campanha que conceda mais de um benefício
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_catalogo |
      | dado           | produto            |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido


  @frete_beneficio_acrescimo
  Esquema do Cenário: Benefício de Acréscimo no Valor de Frete
    Dado que tenha uma campanha que conceda acréscimo no valor do frete
      | beneficio_em  | <beneficio_em>  |
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do frete apresentado é conforme os benefícios concedidos

    Exemplos:
      | beneficio_em | aplicado_para  |
      | porcentagem  | regiao         |
      | porcentagem  | categoria      |
      | porcentagem  | marca          |
      | porcentagem  | produto        |


  @negativo_frete_beneficio_acrescimo
  Esquema do Cenário: Não Concessão de Benefício de Acréscimo no Valor de Frete
    Dado que tenha uma campanha que conceda acréscimo no valor do frete
      | beneficio_em  | <beneficio_em>  |
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_frete  |
      | dado           | <aplicado_para>  |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    Exemplos:
      | beneficio_em | aplicado_para  |
      | porcentagem  | categoria      |
      | porcentagem  | marca          |
      | porcentagem  | produto        |


  @frete_beneficio_valor_fixo
  Esquema do Cenário: Benefício de Valor Fixo no Frete
    Dado que tenha uma campanha que conceda valor fixo no frete
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do frete apresentado é igual ao valor cadastrado

    Exemplos:
      | aplicado_para |
      | regiao        |


  @frete_valor_minimo
  Esquema do Cenário: Benefício de Valor Mínimo no Frete
    Dado que tenha uma campanha que limite o valor mínimo de frete
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do frete apresentado é igual ao valor cadastrado

    Exemplos:
      | aplicado_para |
      | produto       |


  @negativo_frete_valor_minimo
  Esquema do Cenário: Não Concessão de Benefício de Valor Mínimo no Frete
    Dado que tenha uma campanha que limite o valor mínimo de frete
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_frete  |
      | dado           | <aplicado_para>  |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    Exemplos:
      | aplicado_para |
      | produto       |


  @frete_valor_maximo
  Esquema do Cenário: Benefício de Valor Máximo no Frete
    Dado que tenha uma campanha que limite o valor máximo de frete
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do frete apresentado é igual ao valor cadastrado

    Exemplos:
      | aplicado_para |
      | produto       |


  @negativo_frete_valor_maximo
  Esquema do Cenário: Não Concessão de Benefício de Valor Máximo no Frete
    Dado que tenha uma campanha que limite o valor máximo de frete
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_frete  |
      | dado           | <aplicado_para>  |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    Exemplos:
      | aplicado_para |
      | produto       |


  @frete_regra_desconto
  Esquema do Cenário: Concessão de Desconto no Frete Conforme Regras
    Dado que tenha uma campanha que conceda desconto no frete conforme regra
      | regra | <tipo_regra>  |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do frete apresentado é conforme os benefícios concedidos

    Exemplos:
      | tipo_regra        |
      | valor_maior_igual |


  @negativo_frete_regra_desconto
  Esquema do Cenário: Não Concessão de Desconto no Frete Conforme Regras
    Dado que tenha uma campanha que conceda desconto no frete conforme regra
      | regra | <tipo_regra>  |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_frete |
      | dado           | <tipo_regra>    |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    Exemplos:
      | tipo_regra        |
      | valor_maior_igual |


  @frete_gratis
  Esquema do Cenário: Benefício de Frete Grátis
    Dado que tenha uma campanha que conceda frete grátis
      | beneficio_em  | porcentagem     |
      | aplicado_para | <aplicado_para> |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o valor do frete apresentado é conforme os benefícios concedidos

    Exemplos:
      | aplicado_para |
      | categoria     |
      | cidade        |


  @negativo_frete_gratis
  Esquema do Cenário: Não Concessão de Benefício de Frete Grátis
    Dado que tenha uma campanha que conceda frete grátis
      | beneficio_em  | porcentagem     |
      | aplicado_para | <aplicado_para> |
    E que informe outros dados para que o benefício não seja concedido
      | tipo_beneficio | beneficio_frete  |
      | dado           | <aplicado_para>  |
    E que tenha o valor do produto sem benefícios aplicados
    Quando é enviada uma requisição para CalcularCarrinho
    Então o benefício não é aplicado no cálculo do valor do pedido

    Exemplos:
      | aplicado_para  |
      | categoria      |
