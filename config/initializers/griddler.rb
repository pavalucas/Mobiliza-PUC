Griddler.configure do |config|
  config.processor_class = EmailReceiver # CommentViaEmail
  config.processor_method = :process # :create_comment (A method on CommentViaEmail)
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
  config.email_service = :mailgun # :cloudmailin, :postmark, :mandrill, :mailgun
end