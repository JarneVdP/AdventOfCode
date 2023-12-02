function calibration(file::String, second::Bool)
    input = readlines(file)
    number_dict = Dict("zero" => "zero0zero", "one" => "one1one", "two" => "two2two", "three" => "three3three", "four" => "four4four", "five" => "five5five", "six" => "six6six", "seven" => "seven7seven", "eight" => "eight8eight", "nine" => "nine9nine")
    digit = []
    for s in input
        if second
            for (k, v) in number_dict
                s = replace(s, k => v)
            end
        end
        push!(digit, filter(isdigit, s))
    end
    sum = 0
    for line in digit
        sum += parse(Int64, line[1]) * 10 + parse(Int64, line[end])
    end
    return sum
end


@show calibration("2023/Day 1/1_23.txt", false) #56042
@show calibration("2023/Day 1/1_23.txt", true)  #55358
#idea by https://github.com/fuglede/adventofcode/blob/master/2023/day01/solutions.py