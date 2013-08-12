class Staff < User

  authenticates_with_sorcery!

  def self.all_ordered
    User.all_ordered('Staff')
  end
  
end
