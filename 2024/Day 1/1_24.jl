function p1_2(file::String, second::Bool=false)
    input = readlines(file)
    r1 = r2 = 0
    
    left, right = Int[], Int[]
    for s in input
        l, r = parse.(Int, split(s))
        push!(left, l)
        push!(right, r)
    end
    
    r1 = sum(abs.(sort(left) .- sort(right)))
 
    for l in left
        rc = count(x -> x == l, right)
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