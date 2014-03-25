class PatientsProvidersController < ApplicationController
	layout 'member_layout'
	before_filter :authenticate_user!
	before_action :setmember, :check_role?
	def index
		@doctors = Doctor.all
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
		@doctors =[]
		doctors = Doctor.all
		doctors.each do|e|
			if e.fname.match(/#{params[:id]}/i)
				@doctors << e
			end
			puts "#{@doctors.inspect}"
		end
	end

	def show_provider
		@doctor = Doctor.find(params[:id])
	end

	def join_provider
		@member.doctors << Doctor.find(params[:id])
		render :text => params.inspect
	end
	def redir_index
	end
end
private
def setmember
	@member = Patient.find_by(:user_id => current_user.id)
end
def check_role?
  if current_user.role == "Patient"
    true
  else
    render :text => "You dont have permissions to this section"
  end
end