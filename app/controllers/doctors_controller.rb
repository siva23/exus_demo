class DoctorsController < ApplicationController
  #layout 'provider_layout'
  layout 'provider_index'
  before_filter :authenticate_user!
  before_action :check_role?
  def index
    
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
  end

  def destroy
  end

  def update
  end
end
private
def check_role?
  if current_user.role=="Doctor"
    true
  else
    render :text => "You dont have permissions to this section"
  end
end