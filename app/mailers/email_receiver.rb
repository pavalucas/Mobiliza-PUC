class EmailReceiver
  def initialize(email)
    @email = email
  end

  def process
    mobTitle = @email.subject
    #downSubject = @email.subject.downcase
    #if (downSubject[0] + downSubject[1] ==  're')
     # removeCharsFrom mobTitle, 4
    #end
    mobilization = Mobilization.find_by_title(mobTitle)
    target = Target.find_by_email(@email.from[:email])
    mobilization.comments.create!(
      commenter_id: target.id,
      commenter_type: "Target",
      content: @email.body
    )
  end

  #private
   # def removeCharsFrom(str, numberOfChars)
    #  for i in 0..(numberOfChars-1) do
     #   str[0] = ''
      #end
    #end
end