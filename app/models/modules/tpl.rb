class Tpl
  def initialize params, request 
    @tab_name = params['tab_name'].gsub /s$/,''
    Web.set_url request
  end

  def run 
    extend Web
    extend Disk
    $jlog.debug ' in run ' 
    Disk::Paths.each_key do |action|
      Disk.set_file @tab_name, action, ( Web.get_content @tab_name, action ).body
    end
  end 
end
