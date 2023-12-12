function p1_2(file::String, second::Bool=false)
    input = [[parse(Int, num) for num in split(line, " ")] for line in readlines(file)]
    r1 = r2 = 0

    last_line_zeros = false
    for line in input
        current_values = line
        if second 
            reverse!(current_values)
        end
        while !last_line_zeros
            for i in firstindex(current_values):lastindex(current_values)-1
                current_values[i] = current_values[i+1] - current_values[i]
            end
            r1 += current_values[end]
            pop!(current_values)
            last_line_zeros = all(x -> x == 0, current_values)
        end
            last_line_zeros = false
    end
    return r1
end

t = [114,2]
if @show p1_2("2023/Day 9/test.txt") == t[1]
    @show p1_2("2023/Day 9/9_23.txt")           #1953784198
end
if @show p1_2("2023/Day 9/test.txt", true) == t[2]
    @show p1_2("2023/Day 9/9_23.txt", true)     #957
end