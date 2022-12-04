function cleanup(lines)
    #split the lines on ,
    lines2 = []
    lines3 = []
    counter = 0
    
    for line in lines
        push!(lines2, split(line, ['-',',']))
    end
    #lines2 = split.(split(line, ','), '-') and working with lines[i, j] instead of lines[i][j]

    for line in lines2
        push!(lines3, [parse(Int, line[1]), parse(Int, line[2]), parse(Int, line[3]), parse(Int, line[4])])
    end
    for line in lines3
        if line[1] >= line[3] && line[1] <= line[4] && line[2] >= line[3]  && line[2] <= line[4]    ||  line[3] >= line[1] && line[3] <= line[2] && line[4] >= line[1]  && line[4] <= line[2]  
            counter += 1
        end
    end
    return counter
end

function cleanup2(lines)
    lines2 = []
    lines3 = []
    counter = 0
    
    for line in lines
        push!(lines2, split(line, ['-',',']))
    end
    for line in lines2
        push!(lines3, [parse(Int, line[1]), parse(Int, line[2]), parse(Int, line[3]), parse(Int, line[4])])
    end
    for line in lines3
        if line[1] >= line[3] && line[1] <= line[4] || line[2] >= line[3]  && line[2] <= line[4]    ||  line[3] >= line[1] && line[3] <= line[2] || line[4] >= line[1]  && line[4] <= line[2]  
            counter += 1
        end
    end
    return counter
end


lines = readlines("2022/Day 4/4_22.txt")
println("Solution part 1: ", cleanup(lines))     #correct answer, 569
println("Solution part 2: ", cleanup2(lines))    #correct answer, 936