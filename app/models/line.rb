class Line < ActiveRecord::Base
  belongs_to :datastore, inverse_of: :lines
end
