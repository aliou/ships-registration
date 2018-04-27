class ShipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :note, :fleet_id
end
