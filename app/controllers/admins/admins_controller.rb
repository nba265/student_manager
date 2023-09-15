# frozen_string_literal: true

module Admins
  class AdminsController < ActionController::Base
    layout 'admin'
    before_action :authenticate_admin!
  end
end
