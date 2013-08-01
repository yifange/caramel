class School < ActiveRecord::Base
  has_many :programs
  def teachers
    teachers = []
    programs.each do |program|
      teachers += program.teachers
    end
    teachers.uniq
  end
end
