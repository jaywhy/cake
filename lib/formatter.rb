class Formatter
  attr_reader :finder

  def output_list(list, position)
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
end
