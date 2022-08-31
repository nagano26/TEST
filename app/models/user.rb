class User < ApplicationRecord
  authenticates_with_sorcery!
  before_save { self.email = email.downcase }

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, confirmation: true, on: :edit
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :orders, dependent: :destroy

  with_options presence: true do
      validates :username
      validates :username_kana
  end

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }}
    
    KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
    validates :username_kana, {presence: true, format: { with: KATAKANA_REGEXP }}
  

end
