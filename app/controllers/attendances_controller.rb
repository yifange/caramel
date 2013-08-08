class AttendancesController < ApplicationController
  def index
    #XXX if params[:school_id]
    # =>  programs = School.find(school_id).programs
    # if params[:teacher_id]
      params[:teacher_id] = 1
      params[:school_id] = 1
      params[:term_id] = 1
      @teacher = Teacher.find(params[:teacher_id])
      # programs = @teacher.programs
      @program_hash = rehash_rosters_and_attendances(params[:term_id], params[:school_id], params[:teacher_id])
    @year = params[:year] || Date.today.year
    @month = params[:month] || Date.today.month
  end
  def new
    @attendance = Attendance.new
  end
  def edit
    @attendance = Attendance.find(params[:id])
  end
  def update
    attendance = Attendance.find(params[:id])
    if attendance.update_attributes(attendance_params)
      redirect_to attendances_path
    else
      render :edit
    end
  end
  def create
    attendance = Attendance.new(attendance_params) 
    if attendance.save
      redirect_to attendances_path
    else
      render :new
    end
  end
  private
  def rehash_rosters_and_attendances(term_id, school_id, teacher_id)
    programs = Teacher.find(teacher_id).programs.where(:school_id => school_id, :term_id => term_id)
    program_hash = {}
    programs.each do |program|
      enrollment_hash = {}
      enrollments = program.enrollments
      enrollments.each do |enrollment|
        rosters = enrollment.rosters
        roster_hash = {}
        attendance_hash = {}
        rosters.each do |r|
          attendances = r.attendances
          attendances.each do |attendance|
            attendance_hash[attendance.date] = attendance
          end

          course = r.course
          if course.course_type == "GroupCourse"
            roster_hash[course.date] = [] unless roster_hash.has_key? course.date
            roster_hash[course.date] << r
          else
            roster_hash[course.day_of_week] = [] unless roster_hash.has_key? course.day_of_week
            roster_hash[course.day_of_week] << r
          end
        end
        enrollment_hash[enrollment] = [attendance_hash, roster_hash]
      end
      program_hash[program] = enrollment_hash
    end
    program_hash
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
    rosters = enrollment.rosters
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
      if obj[:course_type] == "GroupCourse"
        r[obj[:date]] = [] unless r.has_key? obj[:date]
        r[obj[:date]] << obj
      else
        r[obj[:day_of_week]] = [] unless r.has_key? obj[:day_of_week]
        r[obj[:day_of_week]] << obj
      end
    end
    r
  end
  def attendance_params
    params.require(:attendance).permit(:roster_id, :date, :attendance_marking_id)
  end
end
