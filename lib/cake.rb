require 'tty-reader'

require_relative 'screen'
require_relative 'position'
require_relative 'fuzzy_finder'
require_relative 'formatter'

class Cake
  attr_reader :formatter, :ff, :screen, :pos, :reader, :input

  def initialize(
    list,
    formatter = Formatter.new,
    ff = FuzzyFinder.new(list),
    screen = Screen.new,
    pos = Position.new,
    reader = TTY::Reader.new(interrupt: :exit)
  )
    @formatter = formatter
    @ff = ff
    @screen = screen
    @pos = pos
    @reader = reader
    @input = ""

    setup
  end

  def bake
    loop do
      char = reader.read_keypress

      case reader.console.keys[char]
      when :up
        pos.increment
      when :down
        pos.decrement
      when nil
        if !char.nil?
          input << char
        end
      end

      search(input)
      screen.print_prompt(input)
    end
  end

  def search(input)
    screen.print_screen(
      formatter.output_list(ff.search(input), pos.position)
    )
  end

  private

  def setup
    screen.clear
    screen.output formatter.format_list(ff.matches, pos.position)
    screen.print_prompt

    reader.on(:keyctrl_x, :keyescape) do
      puts "Exiting..."
      exit
    end

    reader.on(:keyreturn) do
      screen.carriage_return
      puts ff.search(input)[-pos.position].string
      exit
    end


    reader.on(:keybackspace) do
      input.chop!
      search(input)
    end
  end
end
