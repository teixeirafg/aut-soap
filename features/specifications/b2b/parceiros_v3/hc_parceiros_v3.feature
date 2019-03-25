#language: pt
@health_check
@b2b
@parceiros_v3
@FullSmoke
@BacklogB2bSquad
@ignoreStg @ignoreDev
Funcionalidade: Health Check - ParceirosV3
  Como uma aplicação de serviço
  Quero enviar requisições para as operações da API ParceirosV3
  Para verificar que as mesmas estão disponíveis


  @consultar_frete_pedido_campanha
  Cenário: Validação da operação Consultar Frete Pedido Campanha
    Dado que tenha um payload padrão do serviço
      | servico | consultar_frete_pedido_campanha |
    Quando é enviada uma requisição para ConsultarFretePedidoCampanha
    Então o serviço responde com status code 200
      | servico | consultar_frete_pedido_campanha |


  @consultar_opcoes_parcelamento
  Cenário: Validação da operação Consultar Opcões Parcelamento
    Dado que tenha um payload padrão do serviço
      | servico | consultar_opcoes_parcelamento |
    Quando é enviada uma requisição para ConsultarOpcoesParcelamento
    Então o serviço responde com status code 200
      | servico | consultar_opcoes_parcelamento |


  @consultar_pedido_parceiro
  Cenário: Validação da operação Consultar Pedido Parceiro
    Dado que tenha um payload padrão do serviço
      | servico | consultar_pedido_parceiro |
    Quando é enviada uma requisição para ConsultarPedidoParceiro
    Então o serviço responde com status code 200
      | servico | consultar_pedido_parceiro |


  @consultar_status_pedido
  Cenário: Validação da operação Consultar Status Pedido
    Dado que tenha um payload padrão do serviço
      | servico | consultar_status_pedido |
    Quando é enviada uma requisição para ConsultarStatusPedido
    Então o serviço responde com status code 200
      | servico | consultar_status_pedido |


  @consultar_produto_por_campanha
  Cenário: Validação da operação Consultar Produto por Campanha
    Dado que tenha um payload padrão do serviço
      | servico | consultar_produto_por_campanha |
    Quando é enviada uma requisição para ConsultarProdutoPorCampanha
    Então o serviço responde com status code 200
      | servico | consultar_produto_por_campanha |


  @consultar_tracking
  Cenário: Validação da operação Consultar Tracking
    Dado que tenha um payload padrão do serviço
      | servico | consultar_tracking |
    Quando é enviada uma requisição para ConsultarTracking
    Então o serviço responde com status code 200
      | servico | consultar_tracking |


  @criar_pedido
  Cenário: Validação da operação Criar Pedido
    Dado que tenha um payload padrão do serviço
      | servico | criar_pedido |
    Quando é enviada uma requisição para CriarPedido
    Então o serviço responde com status code 200
      | servico | criar_pedido |


  @confirmar_pedido
  Cenário: Validação da operação Confirmar Pedido
    Dado que tenha um payload padrão do serviço
      | servico | confirmar_pedido |
    Quando é enviada uma requisição para ConfirmarPedido
    Então o serviço responde com status code 200
      | servico | confirmar_pedido |


  @criar_reserva
  Cenário: Validação da operação Criar Reserva
    Dado que tenha um payload padrão do serviço
      | servico | criar_reserva |
    Quando é enviada uma requisição para CriarReserva
    Então o serviço responde com status code 200
      | servico | criar_reserva |


  @consultar_formas_de_pagamento_da_campanha
  Cenário: Validação da operação Consultar Formas de Pagamento da Campanha
    Dado que tenha um payload padrão do serviço
      | servico | consultar_formas_de_pagamento_da_campanha |
    Quando é enviada uma requisição para ConsultarFormasDePagamentoDaCampanha
    Então o serviço responde com status code 200
      | servico | consultar_formas_de_pagamento_da_campanha |


  @confirmar_reserva
  Cenário: Validação da operação Confirmar Reserva
    Dado que tenha um payload padrão do serviço
      | servico | confirmar_reserva |
    Quando é enviada uma requisição para ConfirmarReserva
    Então o serviço responde com status code 200
      | servico | confirmar_reserva |


  @criar_lista_pedidos
  Cenário: Validação da operação Criar Lista Pedidos
    Dado que tenha um payload padrão do serviço
      | servico | criar_lista_pedidos |
    Quando é enviada uma requisição para CriarListaPedidos
    Então o serviço responde com status code 200
      | servico | criar_lista_pedidos |


  @criar_lista_pedidosV3
  Cenário: Validação da operação Criar Lista Pedidos V3
    Dado que tenha um payload padrão do serviço
      | servico | criar_lista_pedidos_v3 |
    Quando é enviada uma requisição para CriarListaPedidosV3
    Então o serviço responde com status code 200
      | servico | criar_lista_pedidos_v3 |


  @consultar_produto
  Cenário: Validação da operação Consultar Produto
    Dado que tenha um payload padrão do serviço
      | servico | consultar_produto |
    Quando é enviada uma requisição para ConsultarProduto
    Então o serviço responde com status code 200
      | servico | consultar_produto |


  @consultar_produtos
  Cenário: Validação da operação Consultar Produtos
    Dado que tenha um payload padrão do serviço
      | servico | consultar_produtos |
    Quando é enviada uma requisição para ConsultarProdutos
    Então o serviço responde com status code 200
      | servico | consultar_produtos |
