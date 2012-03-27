class TemplatesController < ApplicationController

  def set_params
    @uc_tab = params[:tab].to_s.downcase.titleize
    @lc_tab = params[:tab].to_s
  end

  def migr
    set_params
  end

  def mod
    set_params
  end

  def ctrl
    set_params
  end

  def vi
    set_params
  end

  def sp_ctrl
    set_params
  end

  def sp_mod
    set_params
  end

  def sp_vi
    set_params
  end

  def render
    super :layout => false
  end

end
