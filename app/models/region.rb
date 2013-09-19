class Region < ActiveRecord::Base

  has_many :schools, :dependent => :restrict_with_exception
  has_many :domains
  has_many :users, through: :domains, :dependent => :restrict_with_exception
  has_many :programs, through: :schools
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_ordered
    Region.all.order("name")
  end

  def self.all_ordered_json
    all_ordered.map do |region| 
      {:id => region.id, :text => region.name}
    end
  end

  def teachers_ordered
    users.where(:type => 'Teacher').order('first_name')
  end

  def teachers_ordered_json
    teachers_ordered.map do |teacher|
      {:id => teacher.id, :text => teacher.name}
    end
  end

  def programs_json
    programs.map do |program|
      {:id => program.id, :text => program.name_with_school}
    end
  end

end
