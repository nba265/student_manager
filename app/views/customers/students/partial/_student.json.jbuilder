# frozen_string_literal: true

json.extract! student, :id, :name, :created_at, :updated_at
json.url customers_student_url(student, format: :json)
