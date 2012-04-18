require "spec_helper"

describe UserMailer do
  describe "reset_password_email" do
    let(:user) { FactoryGirl.create(:user, :reset_password_token => "token") }
    let(:mail) { UserMailer.reset_password_email(user) }
    
    it "should send a password reset email with the correct subject" do
      mail.subject.should eq("Reset your password")
    end
    
    it "should send a password reset email from the correct address" do
      mail.from.should include("mailer@americanpolitics411.com")
    end
    
    it "should send a password reset email to the correct person" do
      mail.to.should include(user.email)
    end
    
    it "should send a password reset email with a url to reset password" do
      mail.body.encoded.should match("http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit")
    end
  end
end
