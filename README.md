# AdventOfCode
My solutions to Advent Of Code in Julia. I will try learning julia this way.

1d-array
input1 = parse.(Int64, reduce(hcat, collect.(readlines(file))))
input2 = parse.(Int64, reduce(vcat, collect.(readlines(file))))
--
input = reshape(parse.(Int64, split(join(readlines(file)), "")), length(readlines(file)[1]), :)
input = transpose(input)
for i in axes(input, 2)
for j in axes(input, 1)