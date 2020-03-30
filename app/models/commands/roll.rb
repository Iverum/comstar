module Commands
  class Roll < Command
    DICE_REGEX = /^\d+d\d+$/i

    def perform
      possible_dice = @args[:text]
      return error "I didn't recognize that command. Try including some dice to roll." unless possible_dice.present?

      possible_dice = possible_dice.split
      return error "All arguments need to be in [number]d[size] format." unless possible_dice.all?{ |arg| DICE_REGEX.match?(arg) }
      
      dice = Dice.create_dice(possible_dice)
      return error "You can only roll up to 20 dice at a time." unless dice.length <= 20

      return error "You can only roll up to a d100." if dice.any? { |d| d.size > 100 }

      ack -> do
        rolls = dice.map(&:roll)
        total = rolls.inject(0, :+)
        "<@#{@args[:sender]}> rolled #{@args[:text]}:\n #{rolls.join("+")}=#{total}"
      end
    end
  end
end