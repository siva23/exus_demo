class Patient < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	belongs_to :user
	accepts_nested_attributes_for :user
	has_many :insurances, as: :insurable, :dependent => :destroy
	has_many :payments, as: :payable, :dependent => :destroy
	has_many :appointments
	has_many :doctors, :through => :appointments
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	attr_accessor :current_step

	def self.gen_password
		pwd = "pat" + rand(10000000..99999999).to_s
		return pwd
	end

	def steps
		%w[patient insurance payment]
	end

	def current_step
	 if(@current_step == nil)
	  steps.first
	 else
	 	@current_step
	 end
	end

	def next_step
	 if self.current_step == "patient"
	  self.current_step=(steps[steps.index(current_step)+1])
	 elsif self.current_step == "insurance"
	  self.current_step=(steps[steps.index(current_step)+2])
	 end
	end
	def first_step?
	  current_step == steps.first
	end

	def last_step?
	  current_step == steps.last
	end

	def all_valid?
	  steps.all? do |step|
	    self.current_step = step
	    valid?
	  end
	end
end
