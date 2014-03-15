class MembersController < ApplicationController

  #layout 'member_layout'
	before_filter :authenticate_user!
  #before_filter :set_member, :only => [:update]

  def index
  end

  def new
   # @patient = Patient.new
  end

  def create
    # if params[:execute]
    #   render :text => params.inspect
    # else
    #   @member = Patient.next_step
    #   render 'new'
    # end
  end

  def show
    @member = Patient.find_by(:user_id => current_user.id)
    @today = Date.today
  end

  def destroy
  end

  def edit
    @member = Patient.find_by(:user_id => current_user.id)
  end

  def update
    # render :text => params.inspect
    @member = Patient.find(params[:id])
    if params[:continue]
      @member.next_step
      render 'edit'
    else
      render :text => params.inspect
    end
  end
  
end
private

  def set_member
    @member = Patient.find_by(:user_id => params[:id])
  end
  def pat_details
    params.require(:patient).permit(:fname, :lname, :phone, :dob, :stadd, 
   :city, :state, :zip, :con, :insurance => [:iname, :memnum, :grpnum], :payment => [:cname,
    :cnum, :expd, :biladd, :bilstate, :bilzip, :bilcity])
  end