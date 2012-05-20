require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "email_student" do
    mail = Notifier.email_student
    assert_equal "Email student", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
