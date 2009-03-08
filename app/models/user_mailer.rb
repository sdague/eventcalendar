class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://cal.mhvlug.org/activate/#{user.activation_code}"
  
  end
  
  def reset_notification(user)
      setup_email(user)
      @subject    += 'Link to reset your password'
      @body[:url]  = "http://cal.mhvlug.org/reset/#{user.reset_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://cal.mvhlug.org/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "sean@mhvlug.org"
      @subject     = "[MHVLUG Mailer] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
