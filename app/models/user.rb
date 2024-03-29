class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :username, :password, :password_confirmation, :email, :roles_mask, :roles

  has_many :activities

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }
  
  # admin = 1
  # superadmin = 2
  # reader = 4
  ROLES = %w[admin superadmin reader]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end
  
end
