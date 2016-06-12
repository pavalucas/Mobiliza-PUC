class EmailReceiver
  def initialize(email)
    @email = email
  end

  def process
    mobilization = Mobilization.find_by_title(@email.subject)
    target = Target.find_by_email(@email.from[:email])
    mobilization.comments.create!(
      commenter_id: target.id,
      commenter_type: "Target",
      content: @email.body
    )
  end
end