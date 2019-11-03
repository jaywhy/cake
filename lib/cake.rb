
require 'tty-reader'

require_relative 'screen'
require_relative 'fuzzy_finder'

position = 1

def format_list(list, position)
  list.reduce("") do |accum, l|
    if list[-position].string == l.string
      accum + " \e[31m>\e[39m " + l.string + "\r\n"
    else
      accum + "   " + l.string + "\r\n"
    end
  end
end

def debug(list)
  list.reduce('') { |accum, l| accum + l.inspect + "\r\n" }
end


list = Gem::Specification.all_names

ff = FuzzyFinder.new(list)
screen = Screen.new
str = ''

screen.clear
print format_list(ff.matches, position)
screen.print_prompt

input = ""
reader = TTY::Reader.new
reader.on(:keyctrl_x, :keyescape) do
  puts "Exiting..."
  exit
end

reader.on(:keyreturn) do
  print "\r"
  puts ff.search(input)[-position].string
  exit
end

reader.on(:keybackspace) do
  input.chop!
  screen.print_screen(format_list(ff.search(input), position))
end

loop do
  char = reader.read_keypress
  case reader.console.keys[char]
  when :up
    position += 1
  when :down
    position = position > 1 ? position - 1 : 1
  when nil
    input << char
  end

  screen.print_screen(format_list(ff.search(input), position))
  screen.print_prompt(input)
end
