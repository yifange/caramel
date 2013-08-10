class Teacher < User

  authenticates_with_sorcery!

  def self.all_ordered
    User.all_ordered('Teacher')
  end

end
