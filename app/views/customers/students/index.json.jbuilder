# frozen_string_literal: true

json.array! @students, partial: 'customers/students/partial/student', as: :student
