class TemplatesController < ApplicationController

  def set_params
    @ctrl = Ctrl.new
    @ctrl.uc_tab = params[:uc_tab]
    @ctrl.lc_tab = params[:lc_tab]
  end

  def migr
  end

  def mod
    set_params
  end

  def ctrl
    set_params
  end

  def vi
  end

  def sp_ctrl
    set_params
  end

  def sp_mod
    set_params
  end

  def sp_vi
  end

  def render
    super :layout => false
  end

end
