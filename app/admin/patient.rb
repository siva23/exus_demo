ActiveAdmin.register Patient do
  index do 
      column :id
      column "First Name" do|f|
        f.fname
      end
      column "Last Name" do|f|
        f.lname
      end
      column :phone
      column :email do|f|
        strong{f.user.email}
      end
      column :city do|f|
        f.city
      end
    actions
  end

  form :html => { :multipart=>true } do|f|
    f.inputs 'Profile Details' do
      f.input :fname, :label => "First Name"
      f.input :lname, :label => "Last Name"
      f.input :dob, :label => "Date-Of-Birth", :as => :date_select, :start_year => Date.current.year-100, :end_year => Date.current.year
      f.input :phone, :label => "Phone", :as => :phone, :input_html => { :maxlength => 10 }
      f.input :stadd, :label => "Street Address"
      f.input :city, :label => "City"
      f.input :state, :label => "State"
      f.input :zip, :label => "Zipcode"
      f.input :con, :label => "Country", :as => :select, :include_blank => "--select--", :collection => ["United States of America", "France", "China", "India", "Srilanka"] 
      if f.object.new_record?
        f.input :image, :as => :file, :label => "Image"
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
    def edit
      @f = Patient.find params[:id]
    end
    def create
      @user = User.new()
      @user.email = params[:patient][:user_attributes][:email]
      @user.role = "Patient"
      @user.mobile = params[:patient][:user_attributes][:mobile]
      pwd = @user.password = Patient.gen_password
      respond_to do |format|
        if @user.save
          ExusmedMailer.user_entry_notification(@user.email, pwd).deliver
          @patient = Patient.new()
          @patient.fname = params[:patient][:fname]
          @patient.lname = params[:patient][:lname]
          @patient.dob = params[:patient][:dob]
          @patient.image = params[:patient][:image]
          @patient.phone = params[:patient][:phone]
          @patient.stadd = params[:patient][:stadd]
          @patient.city = params[:patient][:city]
          @patient.state = params[:patient][:state]
          @patient.zip = params[:patient][:zip]
          @patient.con = params[:patient][:con]
          @patient.user_id = @user.id
          @patient.save(:validate => false)
          @patient.role=Payment.create
           format.html { redirect_to admin_patients_path }
        else
           format.html { super }
        end
      end
    end
  end
  member_action :insurances do
       @patient = Patient.find(params[:id])
       @page_title = "#{@patient.fname.capitalize}: Insurances" # Set the page title
       # This will render app/views/admin/patients/insurances.html.erb
  end
  member_action :payment do
       @patient = Patient.find(params[:id])
       @page_title = "#{@patient.fname.capitalize}: Payment Details" # Set the page title
       # This will render app/views/admin/patients/payments.html.erb
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
      row "Phone" do
        f.phone
      end
      row "Street Address" do
        f.stadd
     end
      row "City" do 
        f.city
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
   end
    table_for f.insurances do
      column "Insurance Name", :iname
      column "Member Number", :memnum
      column "Group Number", :grpnum
    end
    table_for f.payment do
      column "Card Name", :cname
      column "Card Number", :cnum
      column "Expired Date", :expd
      column "Billing Address", :biladd
      column "Billing City", :bilcity
      column "Billing State", :bilstate 
      column "Billing Zipcode", :bilzip
    end
    table_for f.doctors.uniq do
      column "Doctors First Name", :fname
      column "Doctors Last Name", :lname
      column "Clinic Name", :clname
      column "Clinic Number", :clnum
    end
    table_for f.appointments.includes(:doctor) do
      column "Appointment Date", :aptdate
      column "Appointment Reason", :aptreason
      column "Doctor Name" do|t|
        #t.doctor.fname
      end
      column "Clinic Number" do|t|
      #  t.doctor.clnum
      end
    end
  end
 # filter :fname_or_lname, :as => :string, :label => "Patients Name"
  filter :phone, :label => "Phone"
  filter :city, :label => "Clinic City", :as => :select, :collection => proc{(Patient.all).map{|c| c.city}}
  filter :user_email, :as => :string
end
