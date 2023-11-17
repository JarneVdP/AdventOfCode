using DelimitedFiles

function signalstrength(file, second::Bool)
    input = readlines(file)
    cycles = [20, 60, 100, 140, 180, 220]
    op = Dict("noop" => 1, "addx" => 2)
    X = 1
    sum = 0
    clockcount = 1
    sprite = "█"
    #part 2
    register = []
    cycle = 0
    
    for line in input
        operation, amount = length(split(line, ' ')) > 1 ? (split(line, ' ')[1], split(line, ' ')[2]) : (split(line, ' ')[1], '0')

        #part 1
        for n in 1:op[operation]
            push!(register, X)
            if !isempty(cycles) && cycles[1] == clockcount
                sum += X * cycles[1]
                popfirst!(cycles)
            end
            if n > 1
                X += parse(Int64, amount)
            end         
            clockcount += 1
        end
    end

    #part 2
    for r in register
        if r in cycle-1: cycle+1
            print(sprite)
        else
            print(" ")
        end
        cycle += 1
        if cycle == 40
            cycle = 0
            print('\n')
        end
    end
    
    return sum
end

@show signalstrength("2022/Day 10/10_22.txt", false) #12640
@show signalstrength("2022/Day 10/10_22.txt", true) #EHBZLRJR