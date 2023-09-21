# frozen_string_literal: true

json.array! @courses, partial: 'customers/courses/partial/course', as: :course
