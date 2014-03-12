class Insurance < ActiveRecord::Base
	belongs_to :insurable, polymorphic: true
end
