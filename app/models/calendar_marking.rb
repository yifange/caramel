class CalendarMarking < ActiveRecord::Base
    has_many :calendar
    validates_presence_of :name
    validates :abbrev, :uniqueness => true
    validates :name, :uniqueness => true
end
