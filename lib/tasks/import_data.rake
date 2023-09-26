# frozen_string_literal: true

namespace :import do
  task data_student: :environment do
    arr = ('A'..'Z').to_a
    100.times do
      student = Student.new(
        name: "Nguyen Van #{arr.sample}",
        age: rand(7..20),
        address: %w[Hue DaNang].sample,
        grades_attributes: [
          { subject: :math, score: rand(1..9), semester: rand(1..2) },
          { subject: :science, score: rand(1..9), semester: rand(1..2) }
        ],
        media_attributes: { video: nil, audio: nil, avatar: nil }
      )
      if student.save
        puts 'Data imported successfully.'
      else
        puts "Error importing data: #{student.errors.full_messages.join(', ')}"
      end
    end
  end

  task data_teacher: :environment do
    first_name = ('A'..'Z').to_a
    last_name = %w[Nguyen Le Tran Hoang]
    20.times do
      teacher = Teacher.new(
        name: "#{last_name.sample} Van #{first_name.sample}",
        age: rand(20..80)
      )
      if teacher.save
        puts 'Data imported successfully.'
      else
        puts "Error importing data: #{teacher.errors.full_messages.join(', ')}"
      end
    end
  end

  task data_course: :environment do
    50.times do
      course = Course.new(
        name: "Course #{rand(1..100)}",
        teacher_id: rand(1..26)
      )
      if course.save
        puts 'Data imported successfully.'
      else
        puts "Error importing data: #{course.errors.full_messages.join(', ')}"
      end
    end
  end

  task data_school: :environment do
    name = ('A'..'Z').to_a
    5.times do
      school = School.new(name: "School #{name.sample}")
      if school.save
        puts 'Data imported successfully.'
      else
        puts "Error importing data: #{school.errors.full_messages.join(', ')}"
      end
    end
  end

  task data_teacher_school: :environment do
    teachers = Teacher.with_deleted.all
    teachers.each do |teacher|
      teacher.school_id = rand(1..5)
      teacher.save
    end
  end

  task data_student_school: :environment do
    students = Student.with_deleted.all
    students.each do |student|
      if student.update_column(:school_id, rand(1..5))
        puts 'Data imported successfully.'
      else
        puts "Error importing data: #{student.errors.full_messages.join(', ')}"
      end
    end
  end

  task name_student: :environment do
    arr = ('A'..'Z').to_a
    last_name = %w[Nguyen Le Tran Hoang]
    students = Student.with_deleted.all
    students.each do |student|
      if student.update_column(:first_name, arr.sample) && student.update_column(:last_name, last_name.sample)
        puts 'Data imported successfully.'
      else
        puts "Error importing data: #{student.errors.full_messages.join(', ')}"
      end
    end
  end
end
