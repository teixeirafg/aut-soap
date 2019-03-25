module Commons
  def get_soap_client(wsdl:, endpoint: nil, soap_v2: false)
    Savon.client do
      wsdl wsdl
      endpoint endpoint
      pretty_print_xml true
      use_wsa_headers true
      strip_namespaces false
      log true
      log_level SAVON_LOG
      ssl_verify_mode :none
      soap_version 2 if soap_v2.eql?(true)
      open_timeout 45
      read_timeout 45
    end
  end

  def call_service(client, operation, file_template, dados)
    evidence_folder = File.join(File.dirname(__FILE__), "/../../../#{$folder_path}")
    date_time = Time.now.strftime('%Hh%Mm%Ss%L')
    evidence_file = "#{evidence_folder}/#{date_time}_#{operation}.txt"

    dados['wsa_action'] = client.wsdl.soap_action(operation)
    dados['wsa_to'] = client.wsdl.endpoint.to_s

    request = get_request_info(client, operation, file_template, dados)
    generate_evidence_request(evidence_file, request)

    retry_call do
      @submit_time = time_now
      @response = submit_request(client, operation, file_template, dados)
      @response_time = time_now
    end
    generate_evidence_response(evidence_file, @submit_time, @response, @response_time)

    { 'request' => request, 'response' => @response }
  end

  def get_request_info(client, operation, file_template, dados)
    client.build_request(operation, xml_template(file_template, dados))
  rescue Savon::Error => e
    raise "\n\n########## Erro ao Gerar o Request ##########:\n#{e}\n\n"
  end

  def submit_request(client, operation, file_template, dados)
    response = client.call(operation, xml_template(file_template, dados))
    response.doc.remove_namespaces!
    response
  rescue Savon::Error => e
    raise "\n\n########## Erro ao Enviar a Requisição ##########:\n#{e}\n\n"
  end

  def format_xml(xml)
    Nokogiri.XML(xml).to_xml
  end

  def time_now
    Time.now.strftime('%d/%m/%Y %H:%M:%S.%L - GMT %z')
  end

  def calcular_beneficio(valor_sem_alteracao, tipo_beneficio, beneficio_em, vlr_beneficio)
    vlr_beneficio = (valor_sem_alteracao * vlr_beneficio / 100).round(2) if beneficio_em.eql?('porcentagem')

    if tipo_beneficio.eql?('desconto')
      (valor_sem_alteracao - vlr_beneficio).round(2)
    else
      (valor_sem_alteracao + vlr_beneficio).round(2)
    end
  end

  def to_boolean(var)
    case var.downcase
    when 'true'
      true
    when 'false'
      false
    else
      raise "Não é possível converter '#{var}' para boolean"
    end
  end

  private

  def xml_template(file_template, dados)
    template_path = File.read(File.join(File.dirname(__FILE__), '/../../../fixtures/request_templates', file_template))
    { xml: eval(Erubi::Engine.new(template_path).src, dados.instance_eval { binding }) }
  end

  def retry_call(tentativas = 3)
    yield
  rescue StandardError => e
    puts "Erro: #{e.message}"
    tentativas -= 1
    puts "Retentando... Restam #{tentativas} tentativas"
    retry if tentativas.positive?
    raise 'Não foi possível chamar o serviço, avalie os logs para mais informações'
  end

  def generate_evidence_request(evidence_file, request)
    File.open(evidence_file, 'w') do |f|
      f << "\n=================================================\n"
      f << "#                     REQUEST                   #\n"
      f << "=================================================\n"
      f << "\n>>>> ENDPOINT <<<<\n#{request.url}\n"
      f << "\n>>>> REQUEST HEADERS <<<<\n"
      request.headers.each { |key, value| f << "#{key}: #{value}\n" }
      f << "\n>>>> REQUEST BODY <<<<\n#{format_xml(request.body)}\n"
      f << "=================================================\n"
      f << "=================================================\n\n"
    end
  end

  def generate_evidence_response(evidence_file, submit_time, response, response_time)
    File.open(evidence_file, 'a') do |f|
      f << "\n=================================================\n"
      f << "#                   RESPONSE                    #\n"
      f << "=================================================\n"
      f << "\n>>>> ENVIO DA REQUISIÇÃO <<<<\n#{submit_time}\n"
      f << "\n>>>> STATUS CODE <<<<\n#{response.http.code}\n"
      f << "\n>>>> RESPONSE HEADERS <<<<\n"
      response.http.headers.each { |key, value| f << "#{key}: #{value}\n" }
      f << "\n>>>> RESPONSE BODY <<<<\n#{response.doc.to_xml}"
      f << "\n>>>> RESPOSTA DA REQUISIÇÃO <<<<\n#{response_time}\n\n"
      f << "=================================================\n"
      f << "=================================================\n"
    end
  end
end
