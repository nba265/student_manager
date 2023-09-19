# frozen_string_literal: true

class BirthdayJob < ApplicationJob
  queue_as :default

  def perform(customer)
    BirthdayMailer.birthday_email(customer).deliver_later
  end
end
