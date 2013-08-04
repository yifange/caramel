class AttendancesController < ApplicationController
  def index
    #XXX if params[:school_id]
    # =>  programs = School.find(school_id).programs
    # if params[:teacher_id]
      params[:teacher_id] = 1
      @teacher = Teacher.find(params[:teacher_id])
      programs = @teacher.programs
      @program_hash = {}
      # programs = Program.all
      programs.each do |program|
        enrollments = program.enrollments
        enrollment_hash = {}
        enrollments.each do |enrollment|
          date_hash = get_date_hash_for_enrollment(enrollment)
          enrollment_hash[enrollment] = date_hash
        end
        @program_hash[program] = {}
        @program_hash[program][:enrollments] = enrollment_hash
        @program_hash[program][:schedule] = rehash_courses(Course.where(:program_id => program.id))
      end
      # end
    @year = params[:year] || Date.today.year
    @month = params[:month] || Date.today.month
  end
  def new
    @attendance = Attendance.new
  end
  def create
  end
  def edit
    @attendance = Attendance.find(params[:id])
  end
  private
  def get_roster_for_enrollment(enrollment)
    student = enrollment.student
    program = enrollment.program
    courses_of_program = program.courses

    rosters_of_enrollment = []
    for course in courses_of_program
      item = Roster.where(:student_id => student.id, :course_id => course.id)
      # XXX date range??
      rosters_of_enrollment += item
    end
    rosters_of_enrollment
  end
  def get_teachers_by_school_id(school_id)
    school = School.find(school_id)
    programs_of_school = school.programs
    teachers = []
    programs_of_school.each do |program|
      teachers += program.teachers
    end
    teachers.uniq
  end
  def get_date_hash_for_enrollment(enrollment)
    rosters = get_roster_for_enrollment(enrollment)
    date_hash = {}
    for roster in rosters
      attendances_of_roster = Attendance.where(:roster_id => roster.id)
      for attendance in attendances_of_roster
        # XXX OK OK OK not going to happen!!!!!!!! not sure if this should be a array.... More than one attendance record on one day? Will that ever happen? 
        # unless date_hash.has_key? attendance.date
        #   date_hash[date] = []
        # end
        date_hash[attendance.date] = attendance
      end
    end
    date_hash
  end
  
  def rehash_courses(objs)
    r = {}
    for obj in objs
      if obj[:type] == "GroupCourse"
        r[obj[:date]] = [] unless r.has_key? obj[:date]
        r[obj[:date]] << obj
      else
        r[obj[:day_of_week]] = [] unless r.has_key? obj[:day_of_week]
        r[obj[:day_of_week]] << obj
      end
    end
    r
  end

end
