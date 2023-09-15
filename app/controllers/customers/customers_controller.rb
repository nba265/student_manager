# frozen_string_literal: true

module Customers
  class CustomersController < ApplicationController
    layout 'customer'
    before_action :authenticate_customer!
  end
end
