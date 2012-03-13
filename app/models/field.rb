class Field < ActiveRecord::Base
  belongs_to :plug
  belongs_to :elmtype
  belongs_to :exposure
end
