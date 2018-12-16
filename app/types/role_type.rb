class RoleType < ActiveRecord::Type::Value
  def type
    :string
  end

  def cast(value)
    Assignment::Role.new(value)
  end

  def deserialize(value)
    cast(value)
  end

  def serialize(value)
    value.to_s
  end
end
