class Position
  attr_reader :position

  def initialize(position = 1)
    @position = position
  end

  def increment
    @position += 1
  end

  def decrement
    @position = @position > 1 ? @position - 1 : 1
  end
end
