require 'test_helper'

class ResetPwdMailerTest < ActionMailer::TestCase
  test "send_pwd" do
    mail = ResetPwdMailer.send_pwd
    assert_equal "Send pwd", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
