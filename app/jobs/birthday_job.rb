# frozen_string_literal: true

class BirthdayJob < ApplicationJob
  queue_as :default

  def perform(student)
    BirthdayMailer.birthday_email(student).deliver_later
  end
end
