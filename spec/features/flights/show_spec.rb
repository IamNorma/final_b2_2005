require 'rails_helper'

RSpec.describe 'Flight Show Page' do
  it 'lists flight information' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")

    visit "/flights/#{flight1.id}"

    expect(page).to have_content(flight1.number)
    expect(page).to have_content(flight1.date)
    expect(page).to have_content(flight1.time)
    expect(page).to have_content(flight1.departure_city)
    expect(page).to have_content(flight1.arrival_city)
  end

  it 'displays airline name' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")

    visit "/flights/#{flight1.id}"

    expect(page).to have_content(delta.name)
  end

  it 'displays name of all passengers on flight' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")

    jackie = Passenger.create!(name: "Jackie Casas", age: 25)
    lupita = Passenger.create!(name: "Lupita Lopez", age: 22)
    junior = Passenger.create!(name: "Junior Lopez", age: 14)
    erick = Passenger.create!(name: "Erick Lopez", age: 6)

    FlightPassenger.create!(flight: flight1, passenger: jackie)
    FlightPassenger.create!(flight: flight1, passenger: lupita)
    FlightPassenger.create!(flight: flight1, passenger: junior)
    FlightPassenger.create!(flight: flight1, passenger: erick)

    visit "/flights/#{flight1.id}"

    expect(page).to have_content(jackie.name)
    expect(page).to have_content(lupita.name)
    expect(page).to have_content(junior.name)
    expect(page).to have_content(erick.name)
  end
end
