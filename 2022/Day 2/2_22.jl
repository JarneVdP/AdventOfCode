function RPS(lines)
    myscore = 0	
    for line in lines
        if line[3] == 'X'   #rock: A, X
            myscore += 1
        elseif line[3] == 'Y'   #paper: B, Y
            myscore += 2
        elseif line[3] == 'Z'  #scissors: C, Z
            myscore += 3
        end
        println(myscore)
        if line[1] == 'A' && line[3] == 'Y'     #rock vs paper
            myscore += 6    
        elseif line[1] == 'A' && line[3] == 'X' #rock vs rock
            myscore += 3    
        elseif line[1] == 'A' && line[3] == 'Z' #rock vs scissors
            myscore += 0
        elseif line[1] == 'B' && line[3] == 'Z' #paper vs scissors
            myscore += 6    
        elseif line[1] == 'B' && line[3] == 'Y' #paper vs paper
            myscore += 3    
        elseif line[1] == 'B' && line[3] == 'X' #paper vs rock
            myscore += 0    
        elseif line[1] == 'C' && line[3] == 'X' #scissors vs rock
            myscore += 6
        elseif line[1] == 'C' && line[3] == 'Z' #scissors vs scissors
            myscore += 3    
        elseif line[1] == 'C' && line[3] == 'Y' #scissors vs paper
            myscore += 0
        end
    end

    return myscore
end

function RPS2(lines)
    myscore = 0	
    for line in lines
        #declare what has to be chosen based on line[3]. If line[3] is X, you need to lose. if line[3] is Y, you need to draw. If line[3] is Z, you need to win.
        #add the needed values A,B,C to the line at position 4
        if line[3] == 'X'   #lose
            if line[1] == 'A'   #rock
                line = string(line,'C')   #paper
            elseif line[1] == 'B'   #paper
                line = string(line,'A')   #scissors
            elseif line[1] == 'C'  #scissors
                line = string(line,'B')   #rock
            end

        elseif line[3] == 'Y'   #draw
            if line[1] == 'A'   #rock
                line = string(line,'A')
            elseif line[1] == 'B'   #paper
                line = string(line,'B')
            elseif line[1] == 'C'  #scissors
                line = string(line,'C')
            end

        elseif line[3] == 'Z'  #win
            if line[1] == 'A'   #rock
                line = string(line,'B')
            elseif line[1] == 'B'   #paper
                line = string(line,'C')
            elseif line[1] == 'C'  #scissors
                line = string(line,'A')
            end
        end

        if line[4] == 'A'   #rock: A, X
            myscore += 1
        elseif line[4] == 'B'   #paper: B, Y
            myscore += 2
        elseif line[4] == 'C'  #scissors: C, Z
            myscore += 3
        end

        if line[1] == 'A' && line[4] == 'B'     #rock vs paper
            myscore += 6    
        elseif line[1] == 'A' && line[4] == 'A' #rock vs rock
            myscore += 3    
        elseif line[1] == 'A' && line[4] == 'C' #rock vs scissors
            myscore += 0
        elseif line[1] == 'B' && line[4] == 'C' #paper vs scissors
            myscore += 6    
        elseif line[1] == 'B' && line[4] == 'B' #paper vs paper
            myscore += 3    
        elseif line[1] == 'B' && line[4] == 'A' #paper vs rock
            myscore += 0    
        elseif line[1] == 'C' && line[4] == 'A' #scissors vs rock
            myscore += 6
        elseif line[1] == 'C' && line[4] == 'C' #scissors vs scissors
            myscore += 3    
        elseif line[1] == 'C' && line[4] == 'B' #scissors vs paper
            myscore += 0
        end
    end

    return myscore
end

lines = readlines("2022/Day 2/2_22.txt")
println("Solution part 1: ", RPS(lines))     #correct answer, ugly but it works
println("Solution part 2: ", RPS2(lines))    #correct answer, even uglier but it works