class Screen
  attr_reader :prompt

  def initialize(prompt = "🍰")
    @prompt = prompt
  end

  def print_screen(output)
    carriage_return
    clear
    output output
  end

  def print_prompt(str = "")
    output "#{prompt} #{str}"
  end

  def carriage_return
    puts "\r"
  end

  def output(out)
    print out
  end

  def clear
    output "\e[2J"
  end
end
