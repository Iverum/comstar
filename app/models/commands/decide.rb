module Commands
  class Decide < Command
    def perform
      options = @args.first.split("|").map(&:strip)
      options.sample
    end
  end
end