#language: pt
@parceiros_v3
@criar_pedido
@b2b
@FullSmoke
@BacklogB2bSquad
@ignorePrd @ignoreStg @ignoreHlg
@ignoreHp @ignoreBarateiro @ignoreAoc @ignorePontoFrio @ignoreCasasBahia

Funcionalidade:  ParceirosV3 - Criar Pedido.
  Como uma aplicação de serviço
  Quero enviar requisições para a operação CriarPedido
  Para verificar se a criaçao do pedido é feita corretamente

  @pedido_sem_divergencia
  Cenário: Criar pedido sem divergências nos valores
    Dado que eu tenha um pedido
      | tipo | nao_permite_divergencia |
    Quando é enviada uma requisição para CriarPedido
    Então posso ver que o pedido não foi gravado


  @pedido_com_divergencia
  Cenário: Criar pedido com divergências nos valores
    Dado que eu tenha um pedido
      | tipo | permite_divergencia |
    Quando é enviada uma requisição para CriarPedido
    Então posso ver que o pedido foi gravado
