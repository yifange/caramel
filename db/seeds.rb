# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Teacher.create(first_name: "Albus", last_name: "Dumbledore")
Student.create(first_name: "Harry", last_name: "Potter")
Student.create(first_name: "Tom", last_name: "Riddle")
School.create(abbrev: "LHS", full: "Linton Hall School")
School.create(abbrev: "CSC", full: "Coventry Cristian Schools")
School.create(abbrev: "SMS", full: "Saint Mary School")
Instrument.create(name: "violin")
Instrument.create(name: "piano")
Instrument.create(name: "guitar")
ProgramType.create(name: "IND")
ProgramType.create(name: "POD")

Program.create(school_id: 1, term_id: 1, instrument_id: 1, program_type_id: 1)
Program.create(school_id: 1, term_id: 1, instrument_id: 2, program_type_id: 1)
Program.create(school_id: 1, term_id: 1, instrument_id: 2, program_type_id: 2)

Program.create(school_id: 2, term_id: 1, instrument_id: 2, program_type_id: 2)
Program.create(school_id: 3, term_id: 1, instrument_id: 2, program_type_id: 2)
Term.create(name: "CURRENT TERM", start_date: "2013-07-01", end_date: "2013-09-01")
Calendar.create(date: "2013-08-01", term_id: 1, start_time: "2000-01-01 08:00:00", end_time: "2000-01-01 16:00:00", day_of_week: 4, available: true, school_id: 1)
Calendar.create(date: "2013-08-02", term_id: 1, start_time: "2000-01-01 08:00:00", end_time: "2000-01-01 16:00:00", day_of_week: 5, available: true, school_id: 1)
Course.create(program_id: 1, start_time: "2000-01-01 08:50:00", end_time: "2000-01-01 09:50:00", day_of_week: 5, course_type: "RegularCourse")
Course.create(program_id: 1, start_time: "2000-01-01 08:50:00", end_time: "2000-01-01 09:50:00", date: "2013-08-01", course_type: "GroupCourse")
Enrollment.create(student_id: 1, program_id: 1)
Enrollment.create(student_id: 2, program_id: 1)
Assignment.create(teacher_id: 1, program_id: 1)
Assignment.create(teacher_id: 1, program_id: 4)
Assignment.create(teacher_id: 1, program_id: 5)
Assignment.create(teacher_id: 1, program_id: 2)
Roster.create(student_id: 1, course_id: 1)
Roster.create(student_id: 1, course_id: 2)
Roster.create(student_id: 2, course_id: 2)
Attendance.create(roster_id: 1, date: "2013-7-29", attendance_marking_id: 1)
Attendance.create(roster_id: 1, date: "2013-7-30", attendance_marking_id: 1)
Attendance.create(roster_id: 3, date: "2013-7-30", attendance_marking_id: 1)
AttendanceMarking.create(:abbrev => "CP", :full => "complete")
AttendanceMarking.create(:abbrev => "SA", :full => "student absence")




Region.delete_all
@r_wdc  = Region.create(name: 'Washington DC')
@r_bal  = Region.create(name: 'Baltimore')
@r_chgo = Region.create(name: 'Chicago')


User.delete_all
@adm_deng  = User.create(email: 'deng.jinqiu@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Jinqiu', last_name: 'Deng', type: 'Admin', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_shen  = User.create(email: 'shen.dongye@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Dongye', last_name: 'Shen', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_lu    = User.create(email: 'lu.fenghuan@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Fenghuan', last_name: 'Lu', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@stf_huang = User.create(email: 'huang.yunchi@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Yunchi', last_name: 'Huang', type: 'Staff', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_ge    = User.create(email: 'ge.yifan@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Yifan', last_name: 'Ge', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_chu   = User.create(email: 'chu.shuya@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Shuya', last_name: 'Chu', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)
@t_yue   = User.create(email: 'yue.mengchao@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Mengchao', last_name: 'Yue', type: 'Teacher', 
                       remember_me_token: nil, remember_me_token_expires_at: nil)

Domain.delete_all
Domain.create(user_id: @stf_shen.id, region_id: @r_wdc.id)
Domain.create(user_id: @stf_lu.id, region_id: @r_wdc.id)
Domain.create(user_id: @stf_huang.id, region_id: @r_wdc.id)
Domain.create(user_id: @t_ge.id, region_id: @r_wdc.id)
Domain.create(user_id: @t_chu.id, region_id: @r_wdc.id)
Domain.create(user_id: @t_yue.id, region_id: @r_bal.id)

@s_jhu = School.create(abbrev: 'JHU', full: 'Johns Hopkins University', region_id: @r_bal.id)
@s_ub  = School.create(abbrev: 'UB', full: 'University of Baltimore', region_id: @r_bal.id)
@s_gwu = School.create(abbrev: 'GWU', full: 'George Washington University', region_id: @r_wdc.id)
@s_gtu = School.create(abbrev: 'GTU', full: 'George Town University', region_id: @r_wdc.id)
@s_uc  = School.create(abbrev: 'UC', full: 'University of Chicago', region_id: @r_chgo.id)
@s_uic = School.create(abbrev: 'UIC', full: 'University of Illinois at Chicago', region_id: @r_chgo.id)

<<<<<<< HEAD
@p_1 = Program.create(school_id: @s_jhu.id,
               instrument_id: Instrument.where(name: 'piano').first.id,
               program_type_id: ProgramType.where(name: 'IND').first.id,
=======
Student.delete_all
@stu_gregg   = Student.create(first_name: 'Gregg', last_name: 'Smith', school_id: @s_jhu.id)
@stu_cherry  = Student.create(first_name: 'Cherry', last_name: 'Minto', school_id: @s_jhu.id)
@stu_maxwell = Student.create(first_name: 'Maxwell', last_name: 'MacPhaull', school_id: @s_jhu.id)
@stu_trip    = Student.create(first_name: 'Trip', last_name: 'Pate', school_id: @s_ub.id)
@stu_connor  = Student.create(first_name: 'Connor', last_name: 'Wightman', school_id: @s_ub.id)
@stu_nikki   = Student.create(first_name: 'Nikki', last_name: 'Rafferty', school_id: @s_ub.id)

Program.delete_all
@p_1 = Program.create(school_id: @s_jhu.id,
               instrument_id: Instrument.where(name: 'piano').first.id,
               program_type_id: ProgramType.where(full: 'individual').first.id,
>>>>>>> origin/Jinqiu
               regular_courses_per_year: 120,
               group_courses_per_year: 40)
@p_2 = Program.create(school_id: @s_jhu.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
<<<<<<< HEAD
               program_type_id: ProgramType.where(name: 'IND').first.id,
=======
               program_type_id: ProgramType.where(full: 'individual').first.id,
>>>>>>> origin/Jinqiu
               regular_courses_per_year: 120,
               group_courses_per_year: 30)
@p_3 = Program.create(school_id: @s_ub.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
<<<<<<< HEAD
               program_type_id: ProgramType.where(name: 'IND').first.id,
=======
               program_type_id: ProgramType.where(full: 'individual').first.id,
>>>>>>> origin/Jinqiu
               regular_courses_per_year: 120,
               group_courses_per_year: 50)
@p_4 = Program.create(school_id: @s_ub.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
<<<<<<< HEAD
               program_type_id: ProgramType.where(name: 'IND').first.id,
=======
               program_type_id: ProgramType.where(full: 'individual').first.id,
>>>>>>> origin/Jinqiu
               regular_courses_per_year: 100,
               group_courses_per_year: 50)

Assignment.delete_all
Assignment.create(program_id: @p_1.id, teacher_id: @t_ge.id)
Assignment.create(program_id: @p_2.id, teacher_id: @t_ge.id)
Assignment.create(program_id: @p_3.id, teacher_id: @t_chu.id)
Assignment.create(program_id: @p_3.id, teacher_id: @t_yue.id)
Assignment.create(program_id: @p_4.id, teacher_id: @t_yue.id)

Enrollment.delete_all
Enrollment.create(program_id:@p_1.id, student_id: @stu_gregg.id)
Enrollment.create(program_id:@p_1.id, student_id: @stu_cherry.id)
Enrollment.create(program_id:@p_2.id, student_id: @stu_gregg.id)
