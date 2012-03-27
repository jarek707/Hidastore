module Web
  @@url = false 

  def Web.get_content( tab, action )
    headers = {'Content-Type' => 'text/html', 'Accept' => 'text/html'}
    query   = "?uc_tab=" + tab.downcase.titleize + '&lc_tab=' + tab.downcase
    uri     = URI.parse 'http://' + @@url + '/templates/' + action + query

    http = Net::HTTP.new uri.host, uri.port
    http.read_timeout = 5
    resp = http.request(Net::HTTP::Get.new "#{uri.path}?#{uri.query}", headers)
    return resp
  end

  def Web.set_url( request )
    @@url = request.host 
    if request.port.to_s != ''
      #@@url += ":" + request.port.to_s
      @@url += ":3001"  # for testing on Brick
    end
  end
end
