class DoctorsController < ApplicationController
  #layout 'provider_layout'
  layout 'provider_index'
  before_filter :authenticate_user!
  #before_action :check_role?
  before_action :set_provider, :except => [:new, :index, :update, :create, :destroy]
  def index
    
  end

  def new
  end

  def show

  end

  def edit
    session[:doctor_params] ||= {}
    session[:provider]= @provider.id
    @provider.current_step = session[:doctor_step]
  end

  def update
     @provider = Doctor.find(session[:provider])
     if (@provider.current_step == "doctor" || @provider.current_step == "payment" || @provider.current_step == "confirm")
     session[:doctor_params].deep_merge!(params[:doctor]) if (params[:doctor])
     @provider.current_step =  session[:doctor_step] 
       if params[:continue] 
          @provider.next_step
          session[:doctor_step] = @provider.current_step          
          render 'edit'
        else
          @provider.update_attributes(session[:doctor_params])
          #render :text => session[:doctor_params].inspect
          session[:doctor_step] = session[:doctor_params] = session[:provider] = nil
          flash[:notice] = "success"
          redirect_to doctor_path
        end
      else
        @provider.next_step
        render 'edit'
      end
  end

  def add_provider_insurance
    #@provider = Doctor.find_by(:user_id => current_user.id)
    @ins = @provider.insurances.new()
    @ins.iname = params[:iname]
    @ins.memnum = params[:memnum]
    @ins.grpnum = params[:grpnum]
    @ins.save
  end

  def remove_provider_insurance
     #@provider = Doctor.find_by(:user_id => current_user.id)
     @provider.insurances.find(params[:id]).destroy
    puts params.inspect
    render :text => params.inspect
  end

  def add_provider_speciality
    @speciality = @provider.specialities.new()
    @speciality.skill = params[:skill]
    @speciality.save
    #render :text => params.inspect
  end

  def remove_provider_speciality
    @provider.specialities.find(params[:id]).destroy
    render :text => "#{@provider.inspect}"
  end

  def add_provider_certification
    @certification = @provider.certifications.new()
    @certification.name = params[:name]
    @certification.year = params[:year]
    @certification.save
  end
  def remove_provider_certification
    @provider.certifications.find(params[:id]).destroy
    render :text => params.inspect
  end

  def add_languages
    @language = @provider.languages.new()
    @language.name = params[:name]
    @language.save
  end

  def remove_language
     @provider.languages.find(params[:id]).destroy
     render :text => params.inspect
  end

  def add_provider_edudetail
    @edu = @provider.edudetails.new()
    @edu.clgname = params[:clgname]
    @edu.year = params[:year]
    @edu.save
  end

  def remove_provider_edudetail
    @provider.edudetails.find(params[:id]).destroy
    render :text => params.inspect
  end
  
  def create
  end

  def destroy
  end
end

private
def set_provider
  @provider = Doctor.find_by(:user_id => current_user.id)
end
def check_role?
  if current_user.role=="Doctor"
    true
  end
end
def doctor_params
  params.require(:doctor).permit(:fname, :lname, :dob,:clname, 
  :clstadd, :sex, :clcity, :state, :zip, :con,:image, :clnum, 
  :insurance => [:iname, :memnum, :grpnum], :payment_attributes => [:id, :cname,
  :cnum, :expd, :biladd, :bilstate, :bilzip, :bilcity])
end
