function countIncrement(lines)
    counter = 0 # first loop will increment to 0
    for line in 2:size(lines, 1)
        if lines[line] > lines[line-1]
            counter += 1
        end
    end
    return counter
end

function ThreeMeasurementSlidingWindow(lines)
    counter = 0 # first loop will increment to 0
    for line in 2:size(lines, 1)-2
        if (lines[line]+lines[line+1]+lines[line+2] > lines[line-1]+lines[line]+lines[line+1])
            counter += 1
        end
    end
    return counter
end

lines = readlines("1_21.txt")
lines = [parse(Int16, line) for line in lines]  
println("Solution part 1: ", countIncrement(lines))     #correct answer
println("Solution part 2: ", ThreeMeasurementSlidingWindow(lines))     #correct answer


