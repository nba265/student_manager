# frozen_string_literal: true

  class User::StudentsController < ApplicationController
    before_action :authenticate_admin!,except: [:index]
    before_action :set_student, only: %i[show edit update destroy]

    # GET /students or /students.json
    def index
      @students = if params[:name].present?
                    Student.where('name LIKE ?', "%#{params[:name]}%")
                  else
                    Student
                  end.order(:id).page params[:page]
    end

    # GET /students/1 or /students/1.json
    def show; end

    def media
      @media = Student.find(params[:id]).media
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
          format.html { redirect_to user_students_url(@student), notice: 'Student was successfully created.' }
          format.json { render :show, status: :created, location: @student }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end

    # GET /students/1/edit
    def edit
      @student = Student.find(params[:id])
    end

    # PATCH/PUT /students/1 or /students/1.json
    def update
      @student = Student.find(params[:id])

      respond_to do |format|
        if @student.update(student_params)
          format.html { redirect_to user_students_path, notice: 'Student was successfully updated.' }
          format.json { render :show, status: :ok, location: @student }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /students/1 or /students/1.json
    def destroy
      @student.destroy

      respond_to do |format|
        format.html { redirect_to user_students_url, notice: 'Student was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :age, :address, :avatar,
                                      grades_attributes: %i[id subject score semester comments _destroy],
                                      media_attributes: %i[id video audio avatar _destroy])
    end
  end
