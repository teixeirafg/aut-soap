module SoapAPI
  def parceiros_v3
    SoapAPI::ParceirosV3.new
  end

  def parceiros_v3_ssl
    SoapAPI::ParceirosV3SSL.new
  end
end
