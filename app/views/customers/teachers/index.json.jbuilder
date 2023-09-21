# frozen_string_literal: true

json.array! @teachers, partial: 'customers/teachers/partial/teacher', as: :teacher
