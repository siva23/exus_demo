class HomeController < ApplicationController

	before_filter :authenticate_user!

	def index
		if current_user.role == "Doctor"
			redirect_to doctor_path(current_user.id)
		else
			redirect_to edit_member_path(current_user.id)
		end
	end

end
