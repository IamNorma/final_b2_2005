require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe "relationships" do
    it {should belong_to :airline}
    it {should have_many :flight_passengers}
    it {should have_many(:passengers).through(:flight_passengers)}
  end

  describe "instance methods" do
    it '#minors' do
      delta = Airline.create!(name: "Delta Airlines")
      flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")

      jackie = Passenger.create!(name: "Jackie Casas", age: 25)
      jeanette = Passenger.create!(name: "Jeanette Medina", age: 65)
      lupita = Passenger.create!(name: "Lupita Lopez", age: 22)
      junior = Passenger.create!(name: "Junior Lopez", age: 14)
      erick = Passenger.create!(name: "Erick Lopez", age: 6)

      FlightPassenger.create!(flight: flight1, passenger: jackie)
      FlightPassenger.create!(flight: flight1, passenger: jeanette)
      FlightPassenger.create!(flight: flight1, passenger: lupita)
      FlightPassenger.create!(flight: flight1, passenger: junior)
      FlightPassenger.create!(flight: flight1, passenger: erick)

      expect(flight1.count_of_minors).to eq(2)
    end

    it '#adults' do
      delta = Airline.create!(name: "Delta Airlines")
      flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")

      jackie = Passenger.create!(name: "Jackie Casas", age: 25)
      jeanette = Passenger.create!(name: "Jeanette Medina", age: 65)
      lupita = Passenger.create!(name: "Lupita Lopez", age: 22)
      junior = Passenger.create!(name: "Junior Lopez", age: 14)
      erick = Passenger.create!(name: "Erick Lopez", age: 6)

      FlightPassenger.create!(flight: flight1, passenger: jackie)
      FlightPassenger.create!(flight: flight1, passenger: jeanette)
      FlightPassenger.create!(flight: flight1, passenger: lupita)
      FlightPassenger.create!(flight: flight1, passenger: junior)
      FlightPassenger.create!(flight: flight1, passenger: erick)

      expect(flight1.count_of_adults).to eq(3)
    end
  end
end
