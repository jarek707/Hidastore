module Disk
  SpineRoot           =  Rails.root + 'app/assets/javascript/app/'
  Paths = { 'mod'     => Rails.root + 'app/model/helper/',
            'vi'      => Rails.root + 'app/view/',
            'ctrl'    => Rails.root + 'app/controller/',
            'sp_mod'  => SpineRoot  + 'controller/',
            'sp_vi'   => SpineRoot  + 'view/',
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

    file = File.new(fName ,"w+")
    $jlog.debug file.puts( content )
    $jlog.debug ' writing '
  end
end
