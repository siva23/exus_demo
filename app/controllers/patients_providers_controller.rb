class PatientsProvidersController < ApplicationController
	layout 'member_layout'
	before_filter :authenticate_user!
	def index
		@member = Patient.find_by(:user_id => current_user.id)
		@doctors = Doctor.all
	end
end
