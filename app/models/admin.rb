class Admin < User
  authenticates_with_sorcery!

  def regions
    Region.all
  end

  def schools
    School.all
  end

end
