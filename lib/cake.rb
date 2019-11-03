STDOUT.sync = true

def print_list(list)
  print list.reduce('') { |accum, l| accum + l.inspect + "\r\n" }
  list.reduce('') do |accum, l|
    if list.last.string == l.string
      accum + " \e[31m>\e[39m " + l.string + "\r\n"
    else
      accum + '   ' + l.string + "\r\n"
    end
  end
end

require 'io/console'
require './fuzzy_finder'

list = Gem::Specification.all_names
ff = FuzzyFinder.new(list)
str = ''
print "\e[2J"
print print_list(ff.matches)
print "🍰 "
$stdin.raw do |stdin|
  while (c = $stdin.getc)
    print "\r" # Reset to start of line
    case c
    when "\177" # Backspace
      str.chop!
    when "\r" # Return
      puts "Selected: #{ff.search(str).last.string}\r"
      break
    when /\w| /
      str << c
    else
      puts "\r"
      puts c
      break
    end

    print "\e[2J"
    if str.length.zero?
      print print_list(ff.matches)
    else
      print print_list(ff.search(str))
    end
    print "🍰 " + str
    # print search(str, list).reduce('') { |l| l + "\r" }
    # print c

  end
end
