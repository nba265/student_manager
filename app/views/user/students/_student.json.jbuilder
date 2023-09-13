# frozen_string_literal: true

json.extract! student, :id, :name, :created_at, :updated_at
json.url user_student_url(student, format: :json)
