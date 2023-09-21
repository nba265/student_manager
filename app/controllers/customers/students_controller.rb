# frozen_string_literal: true

module Customers
  class StudentsController < Customers::CustomersController
    # before_action :set_student, only: %i[show edit update destroy]
    # GET /students or /students.json
    def index
      @students = params[:deleted] == 'true' ? Student.only_deleted.includes(:grades) : Student.includes(:grades)
      @q = @students.ransack(params[:q])
      @students = @q.result.order(Arel.sql('position IS NULL, position ASC'), :id).page(params[:page])
    end

    def restore
      @student = Student.only_deleted.find(params[:id])
      @student.restore

      redirect_to customers_students_path(deleted: true), notice: 'Restore success!'
    end

    # GET /students/1 or /students/1.json
    def show
      @student = Student.with_deleted.includes(:grades, :media).find(params[:id])
    end

    def media
      @media = Student.with_deleted.find(params[:id]).media
    end

    # GET /students/new
    def new
      @student = Student.new
      @student.grades.build
      @student.media = Media.new
    end

    # POST /students or /students.json
    def create
      @student = Student.new(student_params)

      respond_to do |format|
        if @student.save
          Rails.application.config.create_student_logger.info "Create Student:  #{@student.to_json}"
          format.html { redirect_to customers_students_url(@student), notice: 'Student was successfully created.' }
          format.json { render :show, status: :created, location: @student }
        else
          Rails.application.config.create_student_logger
               .error "Error while create #{@student.to_json}: #{@student.errors.full_messages.to_sentence}"
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end

    # GET /students/1/edit
    def edit
      @student = Student.with_deleted.find(params[:id])
      redirect_to customers_students_path(@student) if @student.deleted?

      @student = Student.find(params[:id])
    end

    # PATCH/PUT /students/1 or /students/1.json
    def update
      @student = Student.find(params[:id])

      respond_to do |format|
        if @student.update(student_params)
          format.html { redirect_to customers_students_path, notice: 'Student was successfully updated.' }
          format.json { render :show, status: :ok, location: @student }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /students/1 or /students/1.json
    def destroy
      @student = Student.find(params[:id]).destroy

      respond_to do |format|
        format.html { redirect_to customers_students_url, notice: 'Student was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def swap_positions
      student1 = Student.with_deleted.find(params[:id])
      student2 = Student.with_deleted.find(params[:student2_id])
      if check_position_valid(student1, student2)
        Students::SwapPositionsService.new(student1, student2).assign_positions_nil
        student1 = Student.with_deleted.find(params[:id])
        student2 = Student.with_deleted.find(params[:student2_id])
      end
      Students::SwapPositionsService.call(student1, student2)

      head :no_content
    end

    def reload_student_table
      @students = if params[:deleted] == 'true'
                    Student.only_deleted.page(params[:page]).includes(:grades)
                  else
                    Student.page(params[:page]).includes(:grades)
                  end
      @q = @students.ransack(params[:q])
      @students = @q.result.order(Arel.sql('position IS NULL, position ASC'), :id)
      render partial: 'customers/students/partial/student_table', locals: { students: @students }
    end

    private

    def check_position_valid(student1, student2)
      student1.position.nil? || student2.position.nil? || student1.position == student2.position
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :age, :address, :avatar, :email, :birthday,
                                      grades_attributes: %i[id subject score semester comments _destroy],
                                      media_attributes: %i[id video audio avatar _destroy])
    end
  end
end
