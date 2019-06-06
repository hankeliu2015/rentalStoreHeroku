class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :rentals
  has_many :tools, through: :rentals

  # def self.overdue_tool
  #   @overdue_items =
  # end


  def self.from_omniauth(auth)
    self.where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end


  def returned_rentals_with_tool_name
    returned_rentals.map do |rental|
      [rental, rental.tool.name]
    end
  end
  # repalce with above method. need to have tool names with the rental instance. 
  # def returned_rentals
  #   self.rentals.completed
  # end
end #end of class
