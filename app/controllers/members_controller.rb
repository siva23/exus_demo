class MembersController < ApplicationController
  layout 'member_layout'
	before_filter :authenticate_user!
  before_filter :set_member, :only => [:show, :edit, :index]

  def index
   
  end

  def new

  end

  def create
    
  end

  def show
    @today = Date.today
  end

  def destroy
  end

  def edit
    @member = Patient.find_by(:user_id => current_user.id)
    session[:patient_params] ||= {}
    session[:member]= @member.id
    @member.current_step = session[:patient_step]
  end

  def update
     @member = Patient.find(session[:member])
     if !(@member.current_step == "insurance")
     session[:patient_params].deep_merge!(params[:patient]) if (params[:patient])
     @member.current_step =  session[:patient_step] 
       if params[:continue] 
          @member.next_step
          session[:patient_step] = @member.current_step          
          render 'edit'
        else
          @member.update_attributes(session[:patient_params])
          #render :text => session[:patient_params].inspect
          session[:patient_step] = session[:patient_params] = session[:member] = nil
          flash[:notice] = "success"
          redirect_to member_path
        end
      else
        @member.next_step
        render 'edit'
      end
  end

  def add_insurance
    @member = Patient.find_by(:user_id => current_user.id)
    @ins = @member.insurances.new()
    @ins.iname = params[:iname]
    @ins.memnum = params[:memnum]
    @ins.grpnum = params[:grpnum]
    @ins.save
  end
  
  def remove_insurance
     @member = Patient.find_by(:user_id => current_user.id)
     @member.insurances.find(params[:id]).destroy
    puts params.inspect
    render :text => params.inspect
  end

end
private

  def set_member
    @member = Patient.find_by(:user_id => current_user.id)
  end

  def patient_params
    params.require(:patient).permit(:fname, :lname, :phone, :dob, :stadd, 
   :city, :state, :zip, :con, :image, :insurance => [:iname, :memnum, :grpnum], :payment_attributes => [:id, :cname,
    :cnum, :expd, :biladd, :bilstate, :bilzip, :bilcity])
  end