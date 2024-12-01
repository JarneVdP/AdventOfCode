function p1_2(file::String, second::Bool=false)
    input = readlines(file)
    r1 = r2 = 0
    left = Int[]
    right = Int[]
    for s in input
        parts = split(s)
        push!(left, parse(Int, parts[1]))
        push!(right, parse(Int, parts[2]))
    end
    left2 = copy(left)
    right2 = copy(right)
    left = sort!(left)
    right = sort!(right)
 
    for (l,r) in zip(left, right)
        r1 += abs(l-r)
    end
    for l in left2
        rc = count(x -> x == l, right2)
        r2 += l * rc
    end

    return second ? r2 : r1
end

t = [11,31]
if @show p1_2("2024/Day 1/test.txt") == t[1]
    @show p1_2("2024/Day 1/1_24.txt")      
end
if @show p1_2("2024/Day 1/test.txt", true) == t[2]
    @show p1_2("2024/Day 1/1_24.txt", true)
end