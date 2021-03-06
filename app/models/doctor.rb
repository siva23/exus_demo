class Doctor < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "35x35>", :thumb => "100x100>" }
	belongs_to :user
	accepts_nested_attributes_for :user
	has_many :insurances, as: :insurable, :dependent => :destroy
	has_one :payment, as: :payable, :dependent => :destroy
	has_many :appointments
	has_many :patients, :through => :appointments
	has_many :specialities
	has_many :certifications
	has_many :languages
	has_many :edudetails
	accepts_nested_attributes_for :insurances, :payment
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	attr_accessor :current_step
	

	def self.gen_password
		pwd = "doc" + rand(10000000..99999999).to_s
		return pwd
	end
	def steps
		%w[doctor insurance speciality certification language edudetail payment confirm]
	end


	def current_step
		@current_step || steps.first
	end

	def next_step
	  self.current_step = (steps[steps.index(current_step)+1])
	end

	def previous_step
  	  self.current_step = steps[steps.index(current_step)-1]
	end

	def first_step?
	  current_step == steps.first
	end

	def last_step?
	  current_step == steps.last
	end

	def all_valid?
	  
	end
end
