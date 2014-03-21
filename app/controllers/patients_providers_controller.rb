class PatientsProvidersController < ApplicationController
	layout 'member_layout'
	before_filter :authenticate_user!
	before_action :setmember
	def index
	end
	
	def remove_join_doctor
		@member.doctors.delete(params[:id])
		render :text => params.inspect
	end

	def invite_provider
	end

	def email_deliver
		ExusmedMailer.invite_provider(params[:id], params[:fname]).deliver
		render :nothing => true
	end

	def search_details
		@doctors = Doctor.all
		#render :text => "write the code for searching"
	end
end
private
def setmember
	@member = Patient.find_by(:user_id => current_user.id)
end