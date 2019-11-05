require 'tty-reader'

require_relative 'screen'
require_relative 'position'
require_relative 'fuzzy_finder'
require_relative 'formatter'

formatter = Formatter.new
ff = FuzzyFinder.new(Gem::Specification.all_names)
screen = Screen.new
pos = Position.new

screen.clear
screen.output formatter.format_list(ff.matches, pos.position)
screen.print_prompt

input = ""
reader = TTY::Reader.new
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

  screen.print_screen(
    formatter.output_list(ff.search(input), pos.position)
  )
end

loop do
  char = reader.read_keypress
  case reader.console.keys[char]
  when :up
    pos.increment
  when :down
    pos.decrement
  when nil
    input << char
  end

  screen.print_screen(
    formatter.output_list(ff.search(input), pos.position)
  )

  screen.print_prompt(input)
end
