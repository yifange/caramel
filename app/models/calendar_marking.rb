class CalendarMarking < ActiveRecord::Base
    has_many :calendar
    validates_presence_of :full
    validates :abbrev, :uniqueness => true
    validates :full, :uniqueness => true
end
