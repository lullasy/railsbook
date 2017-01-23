class User < ActiveRecord::Base
  has_one :author
  has_many :reviews
  has_many :books, through: :reviews
  validates :agreement, acceptance: { on: :create }
  validates :email, confirmation: true, presence: { unless: 'dm.blank?' }
end
