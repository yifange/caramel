class ReportsController < ApplicationController
  def index
    # [student, school, program] -> [class_completed, classes_remaining, over/under, class -> [student absence, teacher absence, school closing, student makeup, teacher makeup, school closing makeup, total classes scheduled]]
    if current_user[:type] == "Teacher"
      @teacher = Teacher.find(current_user[:id])
    end
    if params[:selected_schools]
      @schools = @teacher.schools.includes(:students).where(:id => params[:selected_schools]).uniq
    else
      @schools = @teacher.schools.includes(:students).uniq
    end
    if params[:selected_students]
      
    end
    
    @reports = {}
    @reports[{:student => Enrollment.first.student, :school => Enrollment.first.program.school, :program => Enrollment.first.program}] = 
      {:classes_completed => 1, :classes_remaining => 2, :over_under => 3, :rows => {"Class A" => 
        {:student_absence => 1,
         :teacher_absence => 2,
         :school_closing => 3,
         :student_makeup => 3,
         :teacher_makeup => 4,
         :school_closing_makeup => 5,
         :classes_scheduled => 6
        }
    },
  :total => 
        {:student_absence => 1,
         :teacher_absence => 2,
         :school_closing => 3,
         :student_makeup => 3,
         :teacher_makeup => 4,
         :school_closing_makeup => 5,
         :classes_scheduled => 6
        }
    }
    # @schools = @teacher.schools.includes(:students)
    # @students = @schools.map(&:students).flatten.uniq 

  end
end
