class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :only => [:create, :destroy, :redir_relative_index]
  def create
    @member.relations.build(:relative_id => params[:id])
    @member.save
    puts "#{@member.relations}"
    puts "#{params.inspect}"
    render :text => params.inspect
  end

  def destroy
    @member = @member.relations.find_by(:relative_id => params[:id])
    @member.destroy
    render :text => params.inspect
  end

  def search_members
  	@members =[]
	  members = Patient.all
	  members.each do|e|
  		if e.fname.match(/#{params[:id]}/i)
  			@members << e
  		end
	  end
	   puts "#{@members.inspect}"
  end
  
  def show_member
  	@member = Patient.find(params[:id])
  end

  def redir_relative_index
  end

end
private
def set_user
  @member = Patient.find_by(:user_id => current_user.id)
end