class Relation < ActiveRecord::Base
	belongs_to :patient
	belongs_to :relative, :class_name => "Patient"
end
