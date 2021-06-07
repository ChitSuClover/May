class User < ApplicationRecord
  before_destroy :last_admin, prepend: true
  has_many :tasks, dependent: :destroy
  validates :name ,presence: true, length: {maximum: 50}
  validates :email ,presence: true, length: {maximum: 255},format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, on: :create
  before_validation {email.downcase!}
  has_secure_password
  validates :password ,presence: true, length: {minimum: 8}, on: :create
  enum role: {
    user: 0,
    admin: 1
  }
  private
  def last_admin
    @admin = User.where(role: "admin")
    throw(:abort) if (@admin-[self]).empty?
  end
end
