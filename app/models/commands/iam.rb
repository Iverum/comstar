module Commands
  class Iam < Command
    def perform
      return error "Your bio must be 300 characters or less." if @args[:text].length > 300

      user = User.find_or_create_by(slack_id: @args[:sender])
      user.update(bio: @args[:text])
      private "Your bio has been saved."
    end
  end
end