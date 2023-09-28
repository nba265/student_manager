# frozen_string_literal: true

json.extract! course, :id, :name, :teacher_id, :created_at, :updated_at
json.url customers_course_url(course, format: :json)
