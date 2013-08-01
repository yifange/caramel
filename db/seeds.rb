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
School.create(abbrev: "HW", full: "Hogwarts")
Program.create(school_id: 1)
Course.create(program_id: 1)
Course.create(program_id: 1)
Enrollment.create(student_id: 1, program_id: 1)
Enrollment.create(student_id: 2, program_id: 1)
Assignment.create(teacher_id: 1, program_id: 1)
Roster.create(student_id: 1, course_id: 1)
Roster.create(student_id: 1, course_id: 2)
Roster.create(student_id: 2, course_id: 2)
Attendance.create(roster_id: 1, date: "2013-7-29", attendance_marking_id: 1)
Attendance.create(roster_id: 1, date: "2013-7-30", attendance_marking_id: 1)
Attendance.create(roster_id: 3, date: "2013-7-30", attendance_marking_id: 1)
AttendanceMarking.create(:abbrev => "CP", :full => "complete")
AttendanceMarking.create(:abbrev => "SA", :full => "student absence")


