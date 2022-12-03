function rucksack(lines)
    myscore = 0	
    occurence = []
    for line in lines
        spli, ted = line[1:div(length(line),2)], line[div(length(line),2)+1:end]
        push!(occurence, only(spli ∩ ted))
    end
    #loop trough occurence
    for occ in occurence
        if islowercase(occ)
            myscore += codepoint(occ) - codepoint('a') + 1
        else
            myscore += codepoint(occ) - codepoint('A') + 27
        end
    end
    return myscore
end

function rucksack2(lines)
    myscore = 0	
    occurence = []
    lines3 = []
    #group 3 lines together
    for i in 1:3:length(lines)
        push!(lines3, lines[i:i+2])
    end
    for line in lines3
        push!(occurence, only(line[1] ∩ line[2] ∩ line[3]))
    end
    #loop trough occurence
    for occ in occurence
        if islowercase(occ)
            myscore += codepoint(occ) - codepoint('a') + 1
        else
            myscore += codepoint(occ) - codepoint('A') + 27
        end
    end
    return myscore
end

lines = readlines("2022/Day 3/3_22.txt")
println("Solution part 1: ", rucksack(lines))     #correct answer, 8039
println("Solution part 2: ", rucksack2(lines))    #correct answer, 2510