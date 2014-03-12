require 'test_helper'

class ExusmedMailerTest < ActionMailer::TestCase
  test "patient_entry_notification" do
    mail = ExusmedMailer.patient_entry_notification
    assert_equal "Patient entry notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
