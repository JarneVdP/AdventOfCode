function PartOne(input)
    horizontal  = 0
    depth = 0
    for line in input
        inputdirection, inputdistance = split(line, " ")
        inputdistance = parse(Int64, inputdistance)
        if inputdirection == "forward"
            horizontal += inputdistance
        elseif inputdirection == "down"
            depth += inputdistance
        elseif inputdirection == "up"
            depth -= inputdistance
        end
    end
    result = horizontal * depth
    return result
end

function PartTwo(input)
    aim = 0
    horizontal  = 0
    depth = 0
    for line in input
        inputdirection, inputdistance = split(line, " ")
        inputdistance = parse(Int64, inputdistance)
        if inputdirection == "forward"
            horizontal += inputdistance
            depth += aim * inputdistance
        elseif inputdirection == "down"
            aim += inputdistance
        elseif inputdirection == "up"
            aim -= inputdistance
        end
    end
    result = horizontal * depth
    return result
end


input = readlines("2_21.txt")
println("Solution part 1: ", PartOne(input))     #correct answer
println("Solution part 2: ", PartTwo(input))     #correct answer