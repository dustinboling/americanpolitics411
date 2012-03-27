require 'benchmark'

@s1 = "Emanuel Cleaver II"

puts Benchmark.measure { @s1.gsub(/\d II/, '') }
puts Benchmark.measure { @s1.gsub(/\d II/, '').gsub(/\d III/, '') }
puts Benchmark.measure { @s1.gsub(/\d II/, '').gsub(/\d III/, '').gsub(/\d IV/, '') }

