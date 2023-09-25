# frozen_string_literal: true

module Customers
  class CoursesController < Customers::CustomersController
    before_action :set_course, only: %i[show edit update destroy]

    def get_teachers
      @teachers = Teacher.all.order(:id)
      respond_to do |format|
        format.json { render json: @teachers }
      end
    end

    # GET /courses or /courses.json
    def index
      @courses = Course.includes(:teacher).order(id: :desc).page(params[:page])
    end

    def load_table_data
      page = params[:page].to_i || 1

      @courses = Course.includes(:teacher).order(id: :desc).page(page)

      @courses = Course.includes(:teacher).order(id: :desc).page(page - 1) if @courses.empty? && page > 1

      respond_to(&:js)
    end

    # GET /courses/1 or /courses/1.json
    def show; end

    # GET /courses/new
    def new
      @course = Course.new
      @course.teacher = Teacher.new
    end

    # GET /courses/1/edit
    def edit
      respond_to do |format|
        format.json { render json: @course.as_json(methods: :teacher_name) }
      end
    end

    # POST /courses or /courses.json
    def create
      @course = Course.new(course_params)
      puts 'success'

      respond_to do |format|
        if @course.save
          format.json { render json: { message: 'Created course successfully!' }, status: :created }
        else
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /courses/1 or /courses/1.json
    def update
      respond_to do |format|
        if @course.update(course_params)
          format.json { render json: { message: 'Course was successfully updated' } }
        else
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /courses/1 or /courses/1.json
    def destroy
      @course.destroy
      # @courses = Course.includes(:teacher).order(id: :desc).page(params[:page])
      # render layout: false
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :teacher_id)
    end
  end
end
