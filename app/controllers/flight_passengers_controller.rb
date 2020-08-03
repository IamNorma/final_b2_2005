class FlightPassengersController < ApplicationController
  def create
    flight = Flight.where(number: params[:number]).last
    FlightPassenger.create!({passenger_id: params[:id], flight_id: flight.id})
    redirect_to "/passengers/#{params[:id]}"
  end
end
