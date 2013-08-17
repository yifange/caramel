class Attendance < ActiveRecord::Base
  belongs_to :roster
  belongs_to :attendance_marking
end
