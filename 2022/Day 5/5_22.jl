function crane(file, second::Bool)
    lines = readlines(file)
    crates = [Char[] for _ in 1:9]
    instr =  []
    #if line in file contains "move", push to instr
    [contains(line, "move") && push!(instr, line) for line in lines ]

    #now I will parse only the chars from the input
    #I will start by cutting the first 8 lines
    for line in lines[8:-1:1]
        #I will cut the line in 9 chars
        for i in 1:9
            #if the char is not a space, push it to the crates
            line[4i-2] != ' ' && push!(crates[i], line[4i-2])
        end
    end

    #we have the data that we want, now we will parse the instructions
    for line in instr
        #we will parse the line in 6 parts
        qty, from, to = parse.(Int, split(line)[2:2:6])
        #we will append the last qty elements of crates[from] to crates[to]
        if !second
            [push!(crates[to], pop!(crates[from])) for k in 1:qty]    
        else
            append!(crates[to], copy(crates[from][end-qty+1:end]))
            [pop!(crates[from]) for k in 1:qty]
        end
    end
    #we will join the last element of each crate
    crates = join(map(last, crates)) #correct for part 2 GSLCMFBRP
    return crates
end


file = open("2022/Day 5/5_22.txt", "r")	

@show crane("2022/Day 5/5_22.txt", false)  #WSFTMRHPP
@show crane("2022/Day 5/5_22.txt", true)  #WSFTMRHPP