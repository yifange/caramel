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


