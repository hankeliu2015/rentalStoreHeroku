class Tool < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals

  def rental_in_progress
    self.rentals.in_progress.first
  end

  def rental_overdued
    rentals.overdued.first
  end

  def rentals_scheduled
    rentals.scheduled
  end

  def rentals_completed
    rentals.completed
  end

  # moved the following to rental model:
  # def available_for_rent?
  #   rentals.where(return: false).empty?
  # end

end
