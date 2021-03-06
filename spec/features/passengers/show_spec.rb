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

  it 'lists all flight numbers of the flights for pasenger' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
    flight2 = delta.flights.create!(number: "2356", date: "12/15/2019", time: "4:30pm PST", departure_city: "Reno", arrival_city: "Los Angeles")
    flight3 = delta.flights.create!(number: "4512", date: "01/08/2020", time: "10:45am PST", departure_city: "Los Angeles", arrival_city: "Denver")

    lupita = Passenger.create!(name: "Lupita Lopez", age: 22)

    FlightPassenger.create!(flight: flight1, passenger: lupita)
    FlightPassenger.create!(flight: flight2, passenger: lupita)
    FlightPassenger.create!(flight: flight3, passenger: lupita)

    visit "/passengers/#{lupita.id}"

    expect(page).to have_content(flight1.number)
    expect(page).to have_content(flight2.number)
    expect(page).to have_content(flight3.number)
  end

  it 'all flight numbers are links to that flight show page' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
    flight2 = delta.flights.create!(number: "2356", date: "12/15/2019", time: "4:30pm PST", departure_city: "Reno", arrival_city: "Los Angeles")
    flight3 = delta.flights.create!(number: "4512", date: "01/08/2020", time: "10:45am PST", departure_city: "Los Angeles", arrival_city: "Denver")

    lupita = Passenger.create!(name: "Lupita Lopez", age: 22)

    FlightPassenger.create!(flight: flight1, passenger: lupita)
    FlightPassenger.create!(flight: flight2, passenger: lupita)
    FlightPassenger.create!(flight: flight3, passenger: lupita)

    visit "/passengers/#{lupita.id}"

    expect(page).to have_link(flight1.number)
    expect(page).to have_link(flight2.number)
    expect(page).to have_link(flight3.number)

    click_on "5689"

    expect(current_path).to eq("/flights/#{flight1.id}")
  end

  it 'displays form to add an existing flight' do
    delta = Airline.create!(name: "Delta Airlines")
    flight1 = delta.flights.create!(number: "5689", date: "12/15/2019", time: "3:30pm MT", departure_city: "Denver", arrival_city: "Reno")
    flight2 = delta.flights.create!(number: "2356", date: "12/15/2019", time: "4:30pm PST", departure_city: "Reno", arrival_city: "Los Angeles")
    flight3 = delta.flights.create!(number: "4512", date: "01/08/2020", time: "10:45am PST", departure_city: "Los Angeles", arrival_city: "Denver")
    flight4 = delta.flights.create!(number: "7845", date: "02/02/2020", time: "12:45pm PST", departure_city: "Los Angeles", arrival_city: "Portland")

    lupita = Passenger.create!(name: "Lupita Lopez", age: 22)

    FlightPassenger.create!(flight: flight1, passenger: lupita)
    FlightPassenger.create!(flight: flight2, passenger: lupita)
    FlightPassenger.create!(flight: flight3, passenger: lupita)

    visit "/passengers/#{lupita.id}"

    expect(page).to_not have_content(flight4.number)

    fill_in :number, with: "#{flight4.number}"

    click_on "Submit"

    expect(current_path).to eq("/passengers/#{lupita.id}")
    expect(page).to have_link(flight4.number)
  end
end
