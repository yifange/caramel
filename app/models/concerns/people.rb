module People
  extend ActiveSupport::Concern
  def name
    first_name + ' ' + last_name
  end
end
