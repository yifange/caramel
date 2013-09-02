class AttendancesController < ApplicationController
  def index
    term_id = params[:term_id] || Term.order("start_date ASC").last.id

    if current_user[:type] == "Teacher"
      @programs = Teacher.find(current_user[:id]).programs.where(:term_id => term_id).includes(:school, :program_type, :instrument).order("school_id ASC")
    end
    @program = if params[:program_id]
                 (@programs.find_by :id => params[:program_id])
               else 
                 @program = @programs.first
               end
    if @program
      @program_id = @program[:id]
      school_id = @program.school[:id]
      @enrollments = @program.enrollments.includes(:student, :program, :rosters => [:course => :schedules, :attendances => [:attendance_marking]])
      @calendar_hash = rehash_objs(Calendar.where(:school_id => school_id))
    end
    @month = (params[:month] || Date.today.month).to_i
    @year = (params[:year] || Date.today.year).to_i
    @date = Date.new(@year, @month)
    @today = Date.today

  end
  def new
    @attendance = Attendance.new
    @rosters = Enrollment.find(params[:enrollment_id]).rosters.includes(:course)
    render :layout => false
  end
  def edit
    @attendance = Attendance.find(params[:id])
    render :layout => false
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
  def destroy
    attendance = Attendance.find(params[:id])
    attendance.destroy
    redirect_to :index
  end
  private
  def rehash_objs(objs)
    r = {}
    for obj in objs
      unless r.has_key? obj[:date]
        r[obj[:date]] = []
      end
      r[obj[:date]] << obj
    end
    r
  end
  # def rehash_rosters_and_attendances(program)
  #   # program_hash = {}
  #   enrollment_hash = {}
  #   enrollments = program.enrollments.includes(:rosters => [:course => :schedules])
  #   enrollments.each do |enrollment|
  #     rosters = enrollment.rosters
  #     roster_hash = {}
  #     attendance_hash = {:regular => {}, :group => {}}
  #     rosters.each do |r|

  #       course = r.course
  #       break unless course
  #       if course.course_type == "GroupCourse"
  #         r.attendances.each do |attendance|
  #           attendance_hash[:group][attendance.date] = attendance
  #         end
  #         course.schedules.each do |schedule|
  #           roster_hash[schedule.date] = [] unless roster_hash.has_key? schedule.date
  #           roster_hash[schedule.date] << r
  #         end
  #       else
  #         r.attendances.each do |attendance|
  #           attendance_hash[:regular][attendance.date] = attendance
  #         end
  #         course.schedules.each do |schedule|
  #           roster_hash[schedule.day_of_week] = [] unless roster_hash.has_key? schedule.day_of_week
  #           roster_hash[schedule.day_of_week] << r
  #         end
  #       end
  #     end
  #     enrollment_hash[enrollment] = [attendance_hash, roster_hash]
  #   end
  #   enrollment_hash
  #   #   program_hash[program] = enrollment_hash
  #   # program_hash
  # end
  # def rehash_rosters_and_attendances(programs)
  #   # programs = Teacher.find(teacher_id).programs.where(:school_id => school_id, :term_id => term_id)
  #   # programs = Teacher.find(teacher_id).programs.where(:term_id => term_id)
  #   program_hash = {}
  #   programs.each do |program|
  #     enrollment_hash = {}
  #     enrollments = program.enrollments
  #     enrollments.each do |enrollment|
  #       rosters = enrollment.rosters
  #       roster_hash = {}
  #       attendance_hash = {:regular => {}, :group => {}}
  #       rosters.each do |r|

  #         course = r.course
  #         if course.course_type == "GroupCourse"
  #           r.attendances.each do |attendance|
  #             attendance_hash[:group][attendance.date] = attendance
  #           end
  #           roster_hash[course.date] = [] unless roster_hash.has_key? course.date
  #           roster_hash[course.date] << r
  #         else
  #           r.attendances.each do |attendance|
  #             attendance_hash[:regular][attendance.date] = attendance
  #           end
  #           roster_hash[course.day_of_week] = [] unless roster_hash.has_key? course.day_of_week
  #           roster_hash[course.day_of_week] << r
  #         end
  #       end
  #       enrollment_hash[enrollment] = [attendance_hash, roster_hash]
  #     end
  #     program_hash[program] = enrollment_hash
  #   end
  #   program_hash
  # end
  # def get_teachers_by_school_id(school_id)
  #   school = School.find(school_id)
  #   programs_of_school = school.programs
  #   teachers = []
  #   programs_of_school.each do |program|
  #     teachers += program.teachers
  #   end
  #   teachers.uniq
  # end
  # def get_date_hash_for_enrollment(enrollment)
  #   rosters = enrollment.rosters
  #   date_hash = {}
  #   for roster in rosters
  #     attendances_of_roster = Attendance.where(:roster_id => roster.id)
  #     for attendance in attendances_of_roster
  #       # XXX OK OK OK not going to happen!!!!!!!! not sure if this should be a array.... More than one attendance record on one day? Will that ever happen? 
  #       # unless date_hash.has_key? attendance.date
  #       #   date_hash[date] = []
  #       # end
  #       date_hash[attendance.date] = attendance
  #     end
  #   end
  #   date_hash
  # end
  # 
  # def rehash_courses(objs)
  #   r = {}
  #   for obj in objs
  #     if obj[:course_type] == "GroupCourse"
  #       r[obj[:date]] = [] unless r.has_key? obj[:date]
  #       r[obj[:date]] << obj
  #     else
  #       r[obj[:day_of_week]] = [] unless r.has_key? obj[:day_of_week]
  #       r[obj[:day_of_week]] << obj
  #     end
  #   end
  #   r
  # end
  def attendance_params
    params.require(:attendance).permit(:roster_id, :date, :attendance_marking_id)
  end
end
