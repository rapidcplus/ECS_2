class UserPassword
    include ActiveModel::Model
  
    attr_accessor :password, :password_confirmation
  
    validates :password, presence: true, length: { minimum: 3 }
    validates :password_confirmation, presence: true
    validate :password_match
  
    def password_match
      errors.add(:password_confirmation, "doesn't match Password") if password != password_confirmation
    end
  end
