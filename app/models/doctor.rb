class Doctor < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	belongs_to :user
	accepts_nested_attributes_for :user
	has_many :insurances, as: :insurable, :dependent => :destroy
	has_one :payment, as: :payable, :dependent => :destroy
	has_many :appointments
	has_many :patients, :through => :appointments
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	def self.gen_password
		pwd = "doc" + rand(10000000..99999999).to_s
		return pwd
	end
end
