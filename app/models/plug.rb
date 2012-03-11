class Plug < ActiveRecord::Base
  has_many :fields

  def generate (arg)
    logger.debug("Generating")
    logger.debug( arg.to_json() )
    logger.debug("END")
  end 

  def info
    $jlog.debug "INFO here"
  end
end
