# frozen_string_literal: true

require 'application_system_test_case'

module Customers
  class TeachersTest < ApplicationSystemTestCase
    setup do
      @customers_teacher = customers_teachers(:one)
    end

    test 'visiting the index' do
      visit customers_teachers_url
      assert_selector 'h1', text: 'Teachers'
    end

    test 'should create teacher' do
      visit customers_teachers_url
      click_on 'New teacher'

      click_on 'Create Teacher'

      assert_text 'Teacher was successfully created'
      click_on 'Back'
    end

    test 'should update Teacher' do
      visit customers_teacher_url(@customers_teacher)
      click_on 'Edit this teacher', match: :first

      click_on 'Update Teacher'

      assert_text 'Teacher was successfully updated'
      click_on 'Back'
    end

    test 'should destroy Teacher' do
      visit customers_teacher_url(@customers_teacher)
      click_on 'Destroy this teacher', match: :first

      assert_text 'Teacher was successfully destroyed'
    end
  end
end
