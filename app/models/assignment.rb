class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :ship

  validates :user_id, uniqueness: { scope: :ship_id }
end
