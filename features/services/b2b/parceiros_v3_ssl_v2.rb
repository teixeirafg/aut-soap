module SoapAPI
  class ParceirosV3SSL
    include Commons

    def initialize
      @client = get_soap_client(
        wsdl: ENDPOINTS[ENVIRONMENT]['parceiros_v3_ssl']['wsdl'],
        soap_v2: true
      )
    end

    def calcular_carrinho(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_frete_pedido_campanha(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_opcoes_parcelamento(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_pedido_parceiro(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_formas_de_pagamento_da_campanha(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_status_pedido(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_produto_por_campanha(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_tracking(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def criar_pedido(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def confirmar_pedido(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def criar_reserva(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def confirmar_reserva(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def criar_lista_pedidos(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def criar_lista_pedidos_v3(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_produto(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end

    def consultar_produtos(dados)
      file_template = "/parceiros_v3_ssl/#{__method__}.xml"
      call_service(@client, __method__, file_template, dados)
    end
  end
end
