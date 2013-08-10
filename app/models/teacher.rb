class Teacher < User

  authenticates_with_sorcery!

  def self.all_with_region_name
    User.all_with_region_name('Teacher')
  end

end
