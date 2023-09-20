# frozen_string_literal: true

require 'rake'

module Customers
  module Students
    class SwapPositionsService < ApplicationService
      def initialize(student1, student2)
        @student1 = student1
        @student2 = student2
      end

      def call
        swap
      end

      def assign_positions_nil
        students = Student.with_deleted.where(position: nil).order(:id)
        max_position = Student.maximum(:position)
        students.each_with_index do |student, index|
          student.update_column(:position, max_position + index + 1)
        end
      end

      private

      def swap
        ActiveRecord::Base.transaction do
          position1 = @student1.position
          position2 = @student2.position

          @student1.update_column(:position, position2)
          @student2.update_column(:position, position1)
        end

        true
      rescue StandardError
        false
      end
    end
  end
end
