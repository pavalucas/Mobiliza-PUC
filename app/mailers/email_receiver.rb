class EmailReceiver
  def initialize(email)
    @email = email
  end

  def process
    mobTitle = @email.subject
    downSubject = @email.subject.downcase
    # Removing first 4 characters when email is reply ('Re: ')
    if (downSubject[0] + downSubject[1] ==  're')
      for i in 0..3 do
        mobTitle[0] = ''
      end
    end
    mobilization = Mobilization.find_by_title(mobTitle)
    target = Target.find_by_email(@email.from[:email])
    mobilization.comments.create!(
      commenter_id: target.id,
      commenter_type: "Target",
      content: @email.body
    )
  end
end