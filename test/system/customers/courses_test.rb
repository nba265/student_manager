# frozen_string_literal: true

require 'application_system_test_case'

module Customers
  class CoursesTest < ApplicationSystemTestCase
    setup do
      @customers_course = customers_courses(:one)
    end

    test 'visiting the index' do
      visit customers_courses_url
      assert_selector 'h1', text: 'Courses'
    end

    test 'should create course' do
      visit customers_courses_url
      click_on 'New course'

      fill_in 'Name', with: @customers_course.name
      fill_in 'Teacher', with: @customers_course.teacher_id
      click_on 'Create Course'

      assert_text 'Course was successfully created'
      click_on 'Back'
    end

    test 'should update Course' do
      visit customers_course_url(@customers_course)
      click_on 'Edit this course', match: :first

      fill_in 'Name', with: @customers_course.name
      fill_in 'Teacher', with: @customers_course.teacher_id
      click_on 'Update Course'

      assert_text 'Course was successfully updated'
      click_on 'Back'
    end

    test 'should destroy Course' do
      visit customers_course_url(@customers_course)
      click_on 'Destroy this course', match: :first

      assert_text 'Course was successfully destroyed'
    end
  end
end
