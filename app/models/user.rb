class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me,
    :lastname, :firstname, :contact
  attr_accessor :login
  attr_accessible :login
  # attr_accessible :title, :body
  before_create :create_login
  validates :contact , :numericality => {:only_integer => true}
  has_many :products
  def create_login
    email = self.email.split(/@/)
    login_taken = User.where( :username => email[0]).first
    unless login_taken

      self.username = self.login = email[0]
    else
      self.username = self.login = self.email
    end
  end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
