function p1_2(file::String, second::Bool = false)
    input = readlines(file)
    data = [parse.(Int, split(line)) for line in input]
    p2 = []

    function is_valid_sequence(d::Vector{Int})
        sorted_d = sort(d)
        return (d == sorted_d || d == reverse(sorted_d)) && all(1 .<= diff(sorted_d) .<= 3)
    end

    r1 = 0
    for d in data
        if is_valid_sequence(d)
            r1 += 1
        else
            push!(p2, d)
        end
    end

    if !second
        return r1
    end

    r2 = r1
    for p in p2
        for i in eachindex(p)
            temp = copy(p)
            deleteat!(temp, i)
            if is_valid_sequence(temp)
                r2 += 1
                break
            end
        end
    end

    return r2
end

t = [2, 4]
if @show p1_2("2024/Day 2/test.txt") == t[1]
    @show p1_2("2024/Day 2/2_24.txt")
end
if @show p1_2("2024/Day 2/test.txt", true) == t[2]
    @show p1_2("2024/Day 2/2_24.txt", true)
end
