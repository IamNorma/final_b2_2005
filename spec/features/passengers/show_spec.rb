require 'rails_helper'

RSpec.describe 'Passenger Show Page' do
  it 'lists passenger name' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
    flight2 = delta.flights.create!(number: "2356", date: "12/15/2019", time: "4:30pm PST", departure_city: "Reno", arrival_city: "Los Angeles")
    flight3 = delta.flights.create!(number: "4512", date: "01/08/2020", time: "10:45am PST", departure_city: "Los Angeles", arrival_city: "Denver")

    lupita = Passenger.create!(name: "Lupita Lopez", age: 22)

    FlightPassenger.create!(flight: flight1, passenger: lupita)
    FlightPassenger.create!(flight: flight2, passenger: lupita)
    FlightPassenger.create!(flight: flight3, passenger: lupita)

    visit "/passengers/#{lupita.id}"

    expect(page).to have_content(lupita.name)
  end
end
