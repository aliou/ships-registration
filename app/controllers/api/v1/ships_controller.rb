class Api::V1::ShipsController < Api::V1::BaseController
  before_action :load_ships, only: :index
  before_action :load_ship, only: :update

  def index
    serialized_ships = ShipSerializer.new(@ships).serializable_hash
    render json: serialized_ships
  end

  def create
    ship = Ship.create!(create_params)
    serialized_ship = ShipSerializer.new(ship).serializable_hash

    render json: serialized_ship
  end

  def update
    @ship.update!(update_params)
    serialized_ship = ShipSerializer.new(@ship).serializable_hash

    render json: serialized_ship
  end

  private

  def load_ship
    @ship = Ship.find(params[:id])
  end

  def load_ships
    @ships = Ship.all
  end

  def create_params
    params.require(:name)
    params.require(:fleet_id)

    params.permit(:name, :note, :fleet_id)
  end

  def update_params
    params.permit(:name, :note, :fleet_id)
  end
end
