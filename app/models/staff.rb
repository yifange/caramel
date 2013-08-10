class Staff < User

  authenticates_with_sorcery!

  def self.all_with_region_name
    User.all_with_region_name('Staff')
  end
  
end
