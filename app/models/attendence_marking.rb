class AttendenceMarking < ActiveRecord::Base
    has_many :attendences
    validates_presence_of :full
    validates :abbrev, :uniqueness => true
    validates :full, :uniqueness => true
end
