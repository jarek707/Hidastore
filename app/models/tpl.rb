require 'rake'

module View
  @@uc_tab = @@lc_tab = @@content = ''
  @@view   = ActionView::Base.new( File.join Rails.root, 'app', 'views', 'templates' )

  def View.set_tab tab
    @@uc_tab = ( @@lc_tab = tab.downcase ).titleize
  end

  def View.set_content tpl 
    @@content = @@view.render( :template => "#{tpl}",
                               :locals   => { 
                                   :lc_tab => @@lc_tab, 
                                   :uc_tab => @@uc_tab
                               }
                             )
  end

  def View.get_content
    @@content
  end

  def View.content( tab, template )
    set_tab tab
    set_content template
  end
end

module Disk
  @@skipWrite = false
  
  SpineRoot           =  Rails.root + 'app/assets/javascripts/app/'
  Paths = { 'mod'     => Rails.root + 'app/models/',
            'vi'      => Rails.root + 'app/views/',
            'ctrl'    => Rails.root + 'app/controllers/',
            'sp_mod'  => SpineRoot  + 'models/',
            'sp_vi'   => SpineRoot  + 'views/',
            'sp_ctrl' => SpineRoot  + 'controllers/',
            'migr'    => Rails.root + 'db/migrate/' + DateTime.now.to_s()[0,19].gsub(/[A-Z:\-+]/,'') 
            }

  def Disk.set_view_dir tab, action
    tab = tab.pluralize
    if !FileTest::directory?(Paths[action].to_s + tab )
      Dir::mkdir(Paths[action].to_s + tab )
    end
    tab
  end

  def Disk.set_file_name( tab, action, migrationType )
    case action 
      when 'ctrl'
        tab = tab.pluralize + '_controller.rb'
      when 'vi'
        tab = set_view_dir(tab, action) + '/index.html.erb'
      when 'sp_mod'
        tab += '.js.coffee'
      when 'sp_vi'
        tab = set_view_dir(tab, action) + '/index.jst.eco'
      when 'sp_ctrl'
        tab = tab.pluralize + '.js.coffee'
      when 'migr'
        tab = migrationType + tab.pluralize + '.rb' 
      else
        tab += '.rb'
    end
    Paths[action].to_s + tab 
  end

  def Disk.write_content( fileName, content )
    if  !@@skipWrite 
      file = File.new fileName ,"w"
      file.write content
      file.close
    else
      $jlog.debug "skipping write .........." + file
    end
  end
end

class Tpl
  @tab = '' # 

  def initialize params
    extend View
    extend Disk
    #include instance module
    @tab = params['tab_name'].gsub /s$/,''
    View.set_tab @tab
    #$jlog.debug View.set_content 'mod'
    #Web.set_url request
  end

  def plug_add
    return false
    Disk::Paths.each_key do |action|
      fileName = Disk.set_file_name @tab, action, '_create_'
      content  = View.set_content action
      Disk.write_content fileName, content
      $jlog.debug [ fileName , content ]
    end
  end 

  def plug_delete
    Disk::Paths.each_key do |action|
      $jlog.debug action
    end
    $jlog.debug 'plug_delete'
  end

  def plug_change
    $jlog.debug 'plug_change'
  end

  def field_add(field)
    $jlog.debug 'field_add'
  end

  def field_delete(field)
    $jlog.debug 'field_delete'
  end

  def field_change(field)
    $jlog.debug 'field_change'
  end 
end
