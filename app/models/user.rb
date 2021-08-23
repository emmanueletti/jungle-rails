class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :password, length: {minimum: 10}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  def self.authenticate_with_credentials(email_input, password_input)
      user = User.find_by_email(email_input)
      # authenticate instance methods from "has_secure_password"
      if user && user.authenticate(password_input)
        return user
      else
        return nil
      end
  end
end
