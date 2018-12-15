class User < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :ships, through: :assignments

  validates :name, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true
end
