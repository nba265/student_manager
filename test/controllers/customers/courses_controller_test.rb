# frozen_string_literal: true

require 'test_helper'

module Customers
  class CoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @customers_course = customers_courses(:one)
    end

    test 'should get index' do
      get customers_courses_url
      assert_response :success
    end

    test 'should get new' do
      get new_customers_course_url
      assert_response :success
    end

    test 'should create customers_course' do
      assert_difference('Customers::Course.count') do
        post customers_courses_url,
             params: { customers_course: { name: @customers_course.name, teacher_id: @customers_course.teacher_id } }
      end

      assert_redirected_to customers_course_url(Customers::Course.last)
    end

    test 'should show customers_course' do
      get customers_course_url(@customers_course)
      assert_response :success
    end

    test 'should get edit' do
      get edit_customers_course_url(@customers_course)
      assert_response :success
    end

    test 'should update customers_course' do
      patch customers_course_url(@customers_course),
            params: { customers_course: { name: @customers_course.name, teacher_id: @customers_course.teacher_id } }
      assert_redirected_to customers_course_url(@customers_course)
    end

    test 'should destroy customers_course' do
      assert_difference('Customers::Course.count', -1) do
        delete customers_course_url(@customers_course)
      end

      assert_redirected_to customers_courses_url
    end
  end
end
