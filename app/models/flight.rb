class Flight < ApplicationRecord
  belongs_to :airline
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def minors
    passengers.where("age < ?", 18).count
  end

  def adults
    passengers.where("age >= ?", 18).count
  end
end
