TO_ROMAN_CONVERSION = { 1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC", 50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I" }

TO_DECIMAL_CONVERSION = { "CM" => 900, "CD" => 400, "XC" => 90, "XL" => 40, "IX" => 9, "M" => 1000, "D" => 500, "C" => 100, "L" => 50, "X" => 10, "V" => 5, "IV" => 4, "I" => 1 }

def to_roman(decimal)
  return '' if decimal < 1
  pair = TO_ROMAN_CONVERSION.detect { |decimal_number, roman_number| decimal >= decimal_number }
  pair.last + to_roman((decimal - pair.first))
end

def to_decimal(roman)
  return 0 if roman.empty?
  pair = TO_DECIMAL_CONVERSION.detect { |roman_number, decimal_number| roman.include?(roman_number) }
  r = roman
  r.slice!(pair.first)
  pair.last + to_decimal((r))
end

input = ARGV[0].dup
puts "#{input.to_i != 0 ? to_roman(input.to_i) : to_decimal(input)}"
