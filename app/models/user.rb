class User < ApplicationRecord

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    has_secure_password

    has_many :bills

    has_many :debts, :foreign_key => "debtor_id"


    before_save { self.email = email.downcase }

    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :name, :password, presence: :true
    validates :name, uniqueness: :true, allow_blank: :false

    def self.new_guest
        new { |u| u.guest = true }
    end
end
