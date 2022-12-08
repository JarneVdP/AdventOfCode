using DataStructures

function filedir(file, second::Bool, max::Int64)
    inputfiles = readlines(file)

    size = Dict("/" => 0)
    #declare a list
    stack = []
    for input in inputfiles[1:end]
        thisval = 0
        #if the first input is a $
        if contains(input, "\$ cd") 
            splitted = input[6:end]
            if splitted == "/"
                push!(stack, "/")
            elseif splitted == ".."
                pop!(stack)
            elseif stack[end] != "/"
                push!(stack, stack[end] * "/" * splitted)
            else
                push!(stack, splitted)
            end
        elseif input[1] ∈ ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
            thisval = parse(Int64, split(input, ' ')[1])
            for line in stack
                if haskey(size, line)
                    size[line] += thisval
                else
                    size[line] = thisval
                end
            end
        end
    end
    if second
        return minimum(maxsize for maxsize in values(size) if maxsize >= 30000000 - (70000000 - size["/"]))
    end
    return sum(maxsize for maxsize in values(size) if maxsize <= max)
end


@show filedir("2022/Day 7/7_22.txt", false, 100000) 
@show filedir("2022/Day 7/7_22.txt", true, 0)  

#did I try way to long because I forgot a 0? maybe
#did I use other's ideas? maybe. credits to the reddit people and esp. https://www.reddit.com/user/joshbduncan/
#did I learn a lot? yes
