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
end
