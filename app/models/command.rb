class Command
  def initialize(*args)
    @args = args
  end

  def perform
    return "I don't understand that command."
  end
end