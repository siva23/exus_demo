class RegistrationsController < Devise::RegistrationsController

  def create
  	build_resource(registration_params)
	if resource.save
		if resource.role == "Patient"
			@role = Patient.new()
			@role.user_id = resource.id
			@role.save
			@role.payment = Payment.create
		else
			@role = Doctor.new
			@role.user_id = resource.id
			@role.save
			@role.payment = Payment.create
		end
		redirect_to :action => 'index', :controller => 'home'
	else
		render :text => resource.errors.inspect
	end
  end

  private
  def registration_params
  	params.require(:user).permit(:email, :password, :mobile, :role)
  end
end
