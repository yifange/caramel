# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Assignment.delete_all
Student.delete_all
Program.delete_all
Enrollment.delete_all
Region.delete_all
Domain.delete_all
AttendanceMarking.delete_all
School.delete_all
ProgramType.delete_all
Term.delete_all
Calendar.delete_all

@adm_deng = User.create(email: 'deng.jinqiu@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Jinqiu', last_name: 'Deng', type: 'Admin', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_R1_1 = User.create(email: 'staff.R1.1@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'staff', last_name: 'R1_1', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_R1_2 = User.create(email: 'staff.R1.2@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'staff', last_name: 'R1_2', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_R2_1 = User.create(email: 'staff.R2.1@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'staff', last_name: 'R2_1', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_R2R3_1 = User.create(email: 'staff.R2R3.1@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'staff', last_name: 'R2R3_1', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_R1_1 = User.create(email: 'teacher.R1.1@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'teacher', last_name: 'R1_1', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_R1_2 = User.create(email: 'teacher.R1.2@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'teacher', last_name: 'R1_2', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_R2_1 = User.create(email: 'teacher.R2.1@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'teacher', last_name: 'R2_1', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_R2R3_1 = User.create(email: 'teacher.R2R3.1@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'teacher', last_name: 'R2R3_1', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)

@r_1  = Region.create(name: 'R1')
@r_2  = Region.create(name: 'R2')
@r_3 = Region.create(name: 'R3')

Domain.create(user_id: @stf_R1_1.id, region_id: @r_1.id)
Domain.create(user_id: @stf_R1_2.id, region_id: @r_1.id)
Domain.create(user_id: @stf_R2_1.id, region_id: @r_2.id)
Domain.create(user_id: @stf_R2R3_1.id, region_id: @r_2.id)
Domain.create(user_id: @stf_R2R3_1.id, region_id: @r_3.id)
Domain.create(user_id: @t_R1_1.id, region_id: @r_1.id)
Domain.create(user_id: @t_R1_2.id, region_id: @r_1.id)
Domain.create(user_id: @t_R2_1.id, region_id: @r_2.id)
Domain.create(user_id: @t_R2R3_1.id, region_id: @r_2.id)
Domain.create(user_id: @t_R2R3_1.id, region_id: @r_3.id)

@s_R1_1 = School.create(abbrev: 'R1_1', name: 'R1_1', region_id: @r_1.id)
@s_R1_2 = School.create(abbrev: 'R1_2', name: 'R1_2', region_id: @r_1.id)
@s_R2_1 = School.create(abbrev: 'R2_1', name: 'R2_1', region_id: @r_2.id)
@s_R2_2 = School.create(abbrev: 'R2_2', name: 'R2_2', region_id: @r_2.id)
@s_R3_1 = School.create(abbrev: 'R3_1', name: 'R3_1', region_id: @r_3.id)
@s_R3_2 = School.create(abbrev: 'R3_2', name: 'R3_2', region_id: @r_3.id)

@stu_R1_1_1 = Student.create(first_name: 'student', last_name: 'R1_1_1', school_id: @s_R1_1.id)
@stu_R1_1_2 = Student.create(first_name: 'student', last_name: 'R1_1_2', school_id: @s_R1_1.id)
@stu_R1_2_1 = Student.create(first_name: 'student', last_name: 'R1_2_1', school_id: @s_R1_2.id)
@stu_R1_2_2 = Student.create(first_name: 'student', last_name: 'R1_2_2', school_id: @s_R1_2.id)
@stu_R2_1_1 = Student.create(first_name: 'student', last_name: 'R2_1_1', school_id: @s_R2_1.id)
@stu_R2_1_2 = Student.create(first_name: 'student', last_name: 'R2_1_2', school_id: @s_R2_1.id)
@stu_R2_2_1 = Student.create(first_name: 'student', last_name: 'R2_2_1', school_id: @s_R2_2.id)
@stu_R2_2_2 = Student.create(first_name: 'student', last_name: 'R2_2_2', school_id: @s_R2_2.id)
@stu_R3_1_1 = Student.create(first_name: 'student', last_name: 'R3_1_1', school_id: @s_R3_1.id)
@stu_R3_1_2 = Student.create(first_name: 'student', last_name: 'R3_1_2', school_id: @s_R3_1.id)
@stu_R3_2_1 = Student.create(first_name: 'student', last_name: 'R3_2_1', school_id: @s_R3_2.id)
@stu_R3_2_2 = Student.create(first_name: 'student', last_name: 'R3_2_2', school_id: @s_R3_2.id)

# @stu_gre   = Student.create(first_name: 'Grant', last_name: 'Lebar', school_id: @s_jhu.id)
# @stu_bry   = Student.create(first_name: 'Brylin', last_name: 'Beard', school_id: @s_jhu.id)
# @stu_had  = Student.create(first_name: 'Hadassah', last_name: 'Sullivan', school_id: @s_ub.id)
# @stu_dan = Student.create(first_name: 'Daniah', last_name: 'Donovan', school_id: @s_ub.id)
# @stu_dor  = Student.create(first_name: 'Dorian', last_name: 'Donovan', school_id: @s_gwu.id)
# @stu_mac = Student.create(first_name: 'Macie', last_name: 'Gidney', school_id: @s_gwu.id)
# @stu_cur  = Student.create(first_name: 'Curtis', last_name: 'Brown', school_id: @s_gtu.id)
# @stu_pay = Student.create(first_name: 'Payton', last_name: 'Brown', school_id: @s_gtu.id)
# @stu_hal  = Student.create(first_name: 'Haley', last_name: 'Mansfield', school_id: @s_uc.id)
# @stu_aks = Student.create(first_name: 'Akshay', last_name: 'Kumar', school_id: @s_uc.id)
# @stu_nas   = Student.create(first_name: 'Nash', last_name: 'Akowski', school_id: @s_uic.id)
# @stu_cla   = Student.create(first_name: 'Clayton', last_name: 'Martone', school_id: @s_uic.id)
# @stu_gra  = Student.create(first_name: 'Grace', last_name: 'Stephens', school_id: @s_jhu.id)
# @stu_ela = Student.create(first_name: 'Elana', last_name: 'Stephens', school_id: @s_jhu.id)
# @stu_nik  = Student.create(first_name: 'Nikki', last_name: 'Rafferty', school_id: @s_jhu.id)
# @stu_cas = Student.create(first_name: 'Cashel', last_name: 'Rafferty', school_id: @s_jhu.id)
# @stu_lin  = Student.create(first_name: 'Lindsay', last_name: 'Sanders', school_id: @s_jhu.id)
# @stu_kay = Student.create(first_name: 'Kayla', last_name: 'Huang', school_id: @s_jhu.id)
# @stu_hen  = Student.create(first_name: 'Henry', last_name: 'Whitehouse', school_id: @s_jhu.id)
# @stu_che = Student.create(first_name: 'Cherry', last_name: 'Minto', school_id: @s_jhu.id)
# @stu_trip    = Student.create(first_name: 'Nash', last_name: 'Akowski', school_id: @s_ub.id)
# @stu_connor  = Student.create(first_name: 'Sydney', last_name: 'Hall', school_id: @s_ub.id)
# @stu_nikki   = Student.create(first_name: 'Nikki', last_name: 'Rafferty', school_id: @s_ub.id)

Instrument.create(name: "violin")
Instrument.create(name: "piano")
Instrument.create(name: "guitar")

ProgramType.create(name: "IND")
ProgramType.create(name: "POD")

@p_1 = Program.create(school_id: @s_R1_1.id,
               instrument_id: Instrument.where(name: 'piano').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 40, 
               term_id: 1)
@p_2 = Program.create(school_id: @s_R1_1.id,
               instrument_id: Instrument.where(name: 'piano').first.id,
               program_type_id: ProgramType.where(name: 'POD').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 40, 
               term_id: 1)
@p_3 = Program.create(school_id: @s_R1_2.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
               program_type_id: ProgramType.where(name: 'POD').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 30,
               term_id: 1)
@p_4 = Program.create(school_id: @s_R1_2.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 50,
               term_id: 1)
@p_5 = Program.create(school_id: @s_R2_1.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50, 
               term_id: 1)
@p_6 = Program.create(school_id: @s_R2_1.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               program_type_id: ProgramType.where(name: 'POD').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50,
               term_id: 1)
@p_7 = Program.create(school_id: @s_R2_2.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
               program_type_id: ProgramType.where(name: 'POD').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 30,
               term_id: 1)
@p_8 = Program.create(school_id: @s_R2_2.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 50,
               term_id: 1)
@p_9 = Program.create(school_id: @s_R3_1.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50, 
               term_id: 1)
@p_10 = Program.create(school_id: @s_R3_1.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               program_type_id: ProgramType.where(name: 'POD').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50,
               term_id: 1)
@p_11 = Program.create(school_id: @s_R3_2.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50, 
               term_id: 1)
@p_12 = Program.create(school_id: @s_R3_2.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               program_type_id: ProgramType.where(name: 'POD').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50,
               term_id: 1)

@t_1 = Term.create(name: "CURRENT TERM", start_date: "2013-07-01", end_date: "2013-09-01")

# Calendar.create(date: "2013-08-01", term_id: @t_1.id, start_time: "2000-01-01 08:00:00", end_time: "2000-01-01 16:00:00", day_of_week: 4, available: true, school_id: @s_jhu)
# Calendar.create(date: "2013-08-02", term_id: @t_1.id, start_time: "2000-01-01 08:00:00", end_time: "2000-01-01 16:00:00", day_of_week: 5, available: true, school_id: @s_jhu)

# @a_1 = AttendanceMarking.create(:abbrev => "CP", :full => "complete")
# @a_2 = AttendanceMarking.create(:abbrev => "SA", :full => "student absence")

# @c_1 = Course.create(program_id: @p_1.id, start_time: "2000-01-01 08:50:00", end_time: "2000-01-01 09:50:00", day_of_week: 5, course_type: "RegularCourse")
# @c_2 = Course.create(program_id: @p_2.id, start_time: "2000-01-01 08:50:00", end_time: "2000-01-01 09:50:00", date: "2013-08-01", course_type: "GroupCourse")

# @r_1 = Roster.create(student_id: @stu_cherry.id, course_id: nil, start_date: nil, end_date: nil, enrollment_id: @e_1.id)
# @r_2 = Roster.create(student_id: @stu_connor.id, course_id: nil, start_date: nil, end_date: nil, enrollment_id: @e_1.id)
# @r_3 = Roster.create(student_id: @stu_maxwell.id, course_id: nil, start_date: nil, end_date: nil, enrollment_id: @e_1.id)

# Attendance.create(roster_id: @r_1.id, date: "2013-7-29", attendance_marking_id: @a_1.id)
# Attendance.create(roster_id: @r_1.id, date: "2013-7-30", attendance_marking_id: @a_1.id)
# Attendance.create(roster_id: @r_3.id, date: "2013-7-30", attendance_marking_id: @a_2.id)
