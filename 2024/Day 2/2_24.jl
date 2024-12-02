function p1_2(file::String, second::Bool=false)
    input = readlines(file)
    r1 = r2 = 0
    data = [parse.(Int, split(line)) for line in input]
    p2 = []
    for d in data
        if !(sort(d) == d || sort(d, rev=true) == d)
            push!(p2, d)
            continue
        end
        d2 = sort(d)
        if !all(diff(d2) .<= 3 .&& diff(d2) .>= 1)
            push!(p2, d)
            continue
        end
        r1 +=1
    end
    if !second
        return r1
    end

    r2 = r1
    for p in p2
        correct = 0
        for i in 1:length(p)
            temp = copy(p)
            popat!(temp, i)
            if !(sort(temp) == temp || sort(temp, rev=true) == temp)
                continue
            end
            sort!(temp)
            if !all(diff(temp) .<= 3 .&& diff(temp) .>= 1)
                continue
            end
            correct += 1
        end
        if correct > 0
            r2 += 1
        end
    end
    return r2
end

t = [2,4]
if @show p1_2("2024/Day 2/test.txt") == t[1]
    @show p1_2("2024/Day 2/2_24.txt")      
end
if @show p1_2("2024/Day 2/test.txt", true) == t[2]
    @show p1_2("2024/Day 2/2_24.txt", true)
end