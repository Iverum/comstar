module Commands
  class Decide < Command
    def perform
      return [:error, "I didn't recognize that command. Try including some options to decide upon."] unless @args[:text].present?

      options = @args[:text].split("|").map(&:strip)
      [:ok, options.sample]
    end
  end
end