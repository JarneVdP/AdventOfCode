function scratchcards(file::String, second::Bool=false)
    input = readlines(file)
    winning = []
    mine = []
    for line in input
        _, rest = split(line, ':')
        first, sec = split(rest, '|')
        push!(winning, [parse(Int64, num) for num in split(first)])
        push!(mine, [parse(Int64, num) for num in split(sec)])
    end
    total = 0
    count = 0
    copies = zeros(Int, length(mine))
    for (i, n) in enumerate(mine)
        count = 0
        for num in n
            if num in winning[i]
                count += 1
            end
        end
        total += floor(reduce(*, fill(2, count), init=1/2))
        if second
            for j in i:i+count
                copies[j] += 1
            end
            for k in 2:copies[i]
                for j in i+1:i+count
                    copies[j] += 1
                end 
            end
        end
    end
    return second ? sum(copies) : Int(total)
end

@show scratchcards("2023/Day 4/4_23.txt")   #23441
@show scratchcards("2023/Day 4/4_23.txt", true)   #5923918