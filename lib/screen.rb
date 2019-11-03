class Screen
  attr_reader :prompt

  def initialize(prompt = "🍰")
    @prompt = prompt
  end

  def print_screen(output)
    carriage_return
    clear
    print output
  end

  def print_prompt(str = "")
    print "#{prompt} #{str}"
  end

  def carriage_return
    puts "\r"
  end

  def clear
    print "\e[2J"
  end
end
