module Commands
  class Whois < Command
    USER_REGEX = /^<@(U\w+)>$/

    def perform
      matches = @args[:text].match(USER_REGEX)
      return error "I did not recognize a user in that request." unless matches

      slack_id = matches.captures.first
      user = User.find_by(slack_id: slack_id)
      return error "I couldn't find a bio for <@#{slack_id}>." unless user

      private "<@#{slack_id}> describes themselves:\n'#{user.bio}'"
    end
  end
end