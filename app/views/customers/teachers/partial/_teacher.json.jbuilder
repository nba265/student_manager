# frozen_string_literal: true

json.extract! teacher, :id, :name, :age, :created_at, :updated_at
json.url customers_teacher_url(teacher, format: :json)
