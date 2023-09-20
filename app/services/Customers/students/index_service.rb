# frozen_string_literal: true

module Customers
  module Students
    class IndexService < ApplicationService
      def initialize(params)
        @params = params
      end

      def call
        students = base_query
        students = filter_by_name(students)
        students = filter_by_subject(students)
        paginate(students)
      end

      def filter_by_name(students)
        students = students.where('students.name LIKE ?', "%#{@params[:name]}%") if @params[:name].present?
        students
      end

      def filter_by_subject(students)
        students = students.where(grades: { subject: @params[:subject] }) if @params[:subject].present?
        students
      end

      def paginate(students)
        students.page(@params[:page])
      end

      private

      def base_query
        if @params[:deleted] == 'true'
          Student.only_deleted
        else
          Student.all
        end.includes(:grades).order(Arel.sql('position IS NULL, position ASC'), :id)
      end
    end
  end
end
