class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :items
  has_many :bids
  has_many :bidded_items, through: :bids, source: :items

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
