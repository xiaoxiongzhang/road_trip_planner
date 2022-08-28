class User < ApplicationRecord

  validates :name, presence: { message: "用户名不能为空" }
  validates :email, uniqueness: { message: "email已存在" }

  has_many :trips

  # attr_accessor :old_password
  attr_accessor :password
  attr_accessor :password_confirmation

  validate :validate_password, on: :create
  before_create :set_password

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user and user.valid_password?(password)
      user
    else
      nil
    end
  end

  def valid_password?(password)
    self.crypted_password == Digest::SHA256.hexdigest(password + self.salt)
  end

  private

  def validate_password
    if self.password.strip == ''
      self.errors.add(:password, "密码不能为空")
      return false
    end

    unless self.password == self.password_confirmation
      self.errors.add(:password_confirmation, "密码不一致")
      return false
    end
    return true
  end

  def set_password
    self.salt = SecureRandom.uuid
    self.crypted_password = Digest::SHA256.hexdigest(self.password + self.salt)
  end


end
