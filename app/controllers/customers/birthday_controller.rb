# frozen_string_literal: true

module Customers
  class BirthdayController < Customers::CustomersController
    def index
      BirthdayJob.perform_later
    end
  end
end
