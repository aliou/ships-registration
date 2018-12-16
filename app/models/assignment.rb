class Assignment < ApplicationRecord
  # Custom type. See `Assigment::RoleType`.
  attribute :role, :assignment_role

  belongs_to :user
  belongs_to :ship

  validates :user_id, uniqueness: { scope: :ship_id }
end
