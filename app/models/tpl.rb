module Disk
  SpineRoot           =  Rails.root + 'app/assets/javascript/app/'
  Paths = { 'mod'     => Rails.root + 'app/model/helper/',
            'vi'      => Rails.root + 'app/view/',
            'ctrl'    => Rails.root + 'app/controller/',
            'sp_mod'  => SpineRoot  + 'controller/',
            'sp_view' => SpineRoot  + 'view/',
            'sp_ctrl' => SpineRoot  + 'controller/',
            'migr'    => Rails.root + 'db/migrate/' + (DateTime.now.to_s().gsub(/[A-Z:\-+]/,'') + '_create_')
            }

  def Disk.set_file( file, action, content )
    case action 
      when 'ctrl'
        file = 'controller_' + file + 's.rb'
      when 'vi'
        file += '/index.html.erb'
      when 'sp_mod'
        file += '.js.coffee'
      when 'sp_view'
        file += '/index.jst.eco'
      when 'sp_ctrl'
        file += 's.js.coffee'
      else
        file += '.rb'
    end

    fName = Paths[action].to_s + file 
    $jlog.debug action + "--->>>" + fName + "  " + content[0,40]

    #file = File.new(fName ,"w+")
    #file.puts( content )
  end
end

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

class Tpl 
  def initialize params, request 
    @tab_name = params['tab_name'].gsub /s$/,''
    Web.set_url request
  end

  def run 
    require "disk"
    require "web"
    Disk::Paths.each_key do |action|
      Disk.set_file @tab_name, action, ( Web.get_content @tab_name, action ).body
    end
  end 
end
