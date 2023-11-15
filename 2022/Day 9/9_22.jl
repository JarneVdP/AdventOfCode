function ropebridge(file, second:: Int64)
    input = readlines(file)

    moves = Dict('R'=> 1, 'L'=> -1, 'U'=> 1im, 'D'=> -1im)
    
    #rope is the continuous rope at length second
    rope = fill(0.0 + 0.0im, second)

    #create a set (non-duplicate) to store unique values
    visited = [Set([x]) for x in rope]

    for line in input
        for i in 1:parse.(Int64, line[3:end])
            rope[1] += moves[line[1]]   #moves[line[1]] de actie, calculate the head
            
            for j in 2:second   #calculate the body part to the tail
                #if distance between pos and tail >= 2  move tail to last rope[j-1] position, count position + 1
                if abs(rope[j-1] - rope[j]) >= 2
                    rope[j] += sign(real(rope[j-1] - rope[j])) + sign(imag(rope[j-1] - rope[j]))*im   #this is a difficult line
                    push!(visited[j], rope[j])
                end
            end
        end
    end
    
    if second > 2
        return length(visited[10])
    end

    return length(visited[2])
end


@show ropebridge("2022/Day 9/9_22.txt", 2)  #6745 
@show ropebridge("2022/Day 9/9_22.txt", 10)  #