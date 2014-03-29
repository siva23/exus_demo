class AppointmentsController < ApplicationController

	before_filter :authenticate_user!
	before_action :setmember
	layout 'member_layout'

	def index
	end

end

private

def setmember
	@member = Patient.find_by(:user_id => current_user.id)
end