class Dice
  def self.create_dice(dice)
    dice.flat_map do |d|
      count, size = d.split("d")
      (1..count.to_i).map{|_| Dice.new(size.to_i)}
    end
  end

  def initialize(size)
    @size = size
  end

  def roll
    Random.rand(1...@size)
  end
end
