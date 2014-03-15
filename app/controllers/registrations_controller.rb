class RegistrationsController < Devise::RegistrationsController
	
  def create
  	build_resource(registration_params)
	if resource.save
		if resource.role == "Patient"
			@role = Patient.new()
			@role.user_id = resource.id
			@role.save
		else
			@role = Doctor.new
			@role.user_id = resource.id
			@role.save
		end
		redirect_to :action => 'index', :controller => 'home'
	else
		redirect_to :action => 'index', :controller => 'home'
	end
  end

  private
  def registration_params
  	params.require(:user).permit(:email, :password, :mobile, :role)
  end
end
