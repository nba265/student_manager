# frozen_string_literal: true

require 'test_helper'

module Customers
  class TeachersControllerTest < ActionDispatch::IntegrationTest
    setup do
      @customers_teacher = customers_teachers(:one)
    end

    test 'should get index' do
      get customers_teachers_url
      assert_response :success
    end

    test 'should get new' do
      get new_customers_teacher_url
      assert_response :success
    end

    test 'should create customers_teacher' do
      assert_difference('Customers::Teacher.count') do
        post customers_teachers_url, params: { customers_teacher: {} }
      end

      assert_redirected_to customers_teacher_url(Customers::Teacher.last)
    end

    test 'should show customers_teacher' do
      get customers_teacher_url(@customers_teacher)
      assert_response :success
    end

    test 'should get edit' do
      get edit_customers_teacher_url(@customers_teacher)
      assert_response :success
    end

    test 'should update customers_teacher' do
      patch customers_teacher_url(@customers_teacher), params: { customers_teacher: {} }
      assert_redirected_to customers_teacher_url(@customers_teacher)
    end

    test 'should destroy customers_teacher' do
      assert_difference('Customers::Teacher.count', -1) do
        delete customers_teacher_url(@customers_teacher)
      end

      assert_redirected_to customers_teachers_url
    end
  end
end
