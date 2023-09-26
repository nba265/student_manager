# frozen_string_literal: true

namespace :assign_positions do
  task students: :environment do
    students = Student.with_deleted.all.order(:position, :id)
    students.each_with_index do |student, index|
      student.update_column(:position, index + 1)
    end
  end

  task teachers: :environment do
    teachers = Teacher.with_deleted.all.order(:position, :id)
    teachers.each_with_index do |teacher, index|
      teacher.update_column(:position, index + 1)
    end
  end
end
