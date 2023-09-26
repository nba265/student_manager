# frozen_string_literal: true

require 'rake'

module Customers
  module Students
    class SwapPositionsService < ApplicationService
      def initialize(element1, element2, model)
        @element1 = element1
        @element2 = element2
        @model = model
      end

      def call
        unless check_position_valid?
          assign_positions_nil
          @element1 = model.with_deleted.find(@element1.id)
          @element2 = model.with_deleted.find(@element2.id)
        end

        swap
      end

      def assign_positions_nil
        elements = @model.with_deleted.where(position: nil).order(:id)
        max_position = @model.maximum(:position)
        elements.each_with_index do |element, index|
          element.update_column(:position, max_position + index + 1)
        end
      end

      private

      def check_position_valid?
        !@element1.position.nil? && !@element2.position.nil? && @element1.position != @element2.position
      end

      def swap
        ActiveRecord::Base.transaction do
          position1 = @element1.position
          position2 = @element2.position

          @element1.update_column(:position, position2)
          @element2.update_column(:position, position1)
        end

        true
      rescue StandardError
        false
      end
    end
  end
end
