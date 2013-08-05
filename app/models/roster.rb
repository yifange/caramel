class Roster < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  def course_summary
    c = course
    c.id.to_s + " " + c.type
  end
  def course_type
    course.type
  end
  def date
    course.date
  end
  def day_of_week
    course.day_of_week
  end
  def self.select_by_school_and_teacher_and_term_group_by_program_and_day(teacher_id, school_id, term_id)
    programs = Teacher.find(teacher_id).programs.where(:school_id => school_id, :term_id => term_id)
    program_hash = {}
    programs.each do |program|
      enrollment_hash = {}
      enrollments = program.enrollments
      enrollments.each do |enrollment|
        rosters = enrollment.rosters
        date_hash = {}
        rosters.each do |r|
          course = r.course
          if course.type == "GroupCourse"
            if date_hash.has_key? course.date
              date_hash[course.date] << r
            else
              date_hash[course.date] = r
            end
          else
            if date_hash.has_key? course.day_of_week
              date_hash[course.day_of_week] << r
            else
              date_hash[course.day_of_week] = r
            end
          end
        end
        enrollment_hash[enrollment] = date_hash
      end
      program_hash[program] = enrollment_hash
    end
  end
end
