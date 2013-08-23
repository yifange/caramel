module VerifyUserHelper

  def verify_user(roles)
    flag = false
    if current_user
      roles.each do |role|
        if current_user.type == role
          flag = true
          break
        end
      end
    end
    flag
  end

end
