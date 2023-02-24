class Employee < ApplicationRecord
  validates :first_name, :email, :age, presence: true
  validates :age, :no_of_order, :salary, numericality: true
  validates :email, uniqueness: true
  validates :full_time_available, inclusion: [true, false]
  validates :full_time_available, exclusion: nil
end
