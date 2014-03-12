ActiveAdmin.register Doctor do
  index do 
      column :id
      column "First Name" do|f|
        f.fname
      end
      column "Last Name" do|f|
        f.lname
      end
      column :sex
      column :email do|f|
        strong{f.user.email}
      end
      column "Clinic City" do|f|
        f.clcity
      end
    actions
  end

  form :html => { :multipart=>true } do|f|
    f.inputs 'Profile Details' do
      f.input :fname, :label => "First Name"
      f.input :lname, :label => "Last Name"
      f.input :dob, :label => "Date-Of-Birth", :as => :date_select, :start_year => Date.current.year-100, :end_year => Date.current.year
      f.input :clname, :label => "Clinic Name"
      f.input :clstadd, :label => "Clinic Street Address"
      f.input :sex, :as => :radio, :collection => ["Male", "Female"]
      f.input :clcity, :label => "Clinic City"
      f.input :state, :label => "State"
      f.input :zip, :label => "Zipcode"
      f.input :con, :label => "Country", :as => :select, :include_blank => "--select--", :collection => ["United States of America", "France", "China", "India", "Srilanka"] 
      f.input :clnum, :label => "Clinic Number"
      if f.object.new_record?
        f.input :image, :as => :file
        f.inputs "Registration Details", :for => [:user, f.object.user || User.new] do|t|
          t.input :email, :label => "Email"
          t.input :mobile, :label => "Mobile", :input_html => {:maxlength => 10}
        end
      else
        f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.url(:thumb))
      end
    end
    f.actions
  end

  controller do
    def create
      @user = User.new()
      @user.email = params[:doctor][:user_attributes][:email]
      @user.role = "Doctor"
      @user.mobile = params[:doctor][:user_attributes][:mobile]
      pwd = @user.password = Doctor.gen_password
      respond_to do |format|
        if @user.save
          ExusmedMailer.user_entry_notification(@user.email, pwd).deliver
          @doctor = Doctor.new()
          @doctor.fname = params[:doctor][:fname]
          @doctor.lname = params[:doctor][:lname]
          @doctor.dob = params[:doctor][:dob]
          @doctor.image = params[:doctor][:image]
          @doctor.clname = params[:doctor][:clname]
          @doctor.clstadd = params[:doctor][:clstadd]
          @doctor.sex = params[:doctor][:sex]
          @doctor.clcity = params[:doctor][:clcity]
          @doctor.state = params[:doctor][:state]
          @doctor.zip = params[:doctor][:zip]
          @doctor.con = params[:doctor][:con]
          @doctor.user_id = @user.id
          @doctor.save(:validate => false)
            
           format.html { redirect_to admin_doctors_path }
        else
           format.html { super }
        end
      end
    end
  end
  member_action :insurances do
       @doctor = doctor.find(params[:id])
       @page_title = "#{@doctor.fname.capitalize}: Insurances" # Set the page title
       # This will render app/views/admin/doctors/insurances.html.erb
  end
  member_action :payments do
       @doctor = doctor.find(params[:id])
       @page_title = "#{@doctor.fname.capitalize}: Payment Details" # Set the page title
       # This will render app/views/admin/doctors/payments.html.erb
  end
 
 permit_params :fname, :lname, :dob, :phone, :stadd, :city, :state, :zip, :con,:image,
    user_attributes: [:email, :mobile]
 
  show do|f|
    attributes_table do
      row :id
      row "Email" do
        f.user.email
      end
      row "First Name" do
        f.fname
      end
      row "Last Name" do
        f.lname
      end
      row "Date-Of-Birth" do
        f.dob
      end
      row :image do
          image_tag(f.image.url(:thumb))
      end
      row "Clinic Name" do
        f.clname
      end
      row "Clinic Street Address" do
        f.clstadd
     end
      row "Clinic City" do 
        f.clcity
      end
      row "State" do 
        f.state
      end
      row "Zipcode" do
        f.zip
      end
      row "Country" do
       f.con
      end
      row "Clinic Number" do
       f.clnum
      end
   end
    table_for f.insurances do
      column "Insurance Name", :iname
      column "Member Number", :memnum
      column "Group Number", :grpnum
    end
    table_for f.payments do
      column "Card Name", :cname
      column "Card Number", :cnum
      column "Expired Date", :expd
      column "Billing Address", :biladd
      column "Billing City", :bilcity
      column "Billing State", :bilstate 
      column "Billing Zipcode", :bilzip
    end
    table_for f.patients.uniq do
      column "Patients First Name", :fname
      column "Patients Last Name", :lname
      column "Patients City", :city
      column "Patients Phone Number", :phone
    end
    table_for f.appointments.includes(:patient) do
      column "Appointment Date", :aptdate
      column "Appointment Reason", :aptreason
      column "Patient Name" do|t|
        t.patient.fname
      end
    end
  end
  filter :sex_contains, :as => :select, :collection => ["Male", "Female"]
  filter :clnum, :label => "Clinic Number"
  filter :fname_or_lname, :as => :string, :label => "Doctors Name"
  filter :clcity, :label => "Clinic City", :as => :select, :collection => proc{(Doctor.all).map{|c| c.clcity}}
  filter :user_email, :as => :string
end
