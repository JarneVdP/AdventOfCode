function p1_2(file::String, second::Bool=false)
    input = read(file, String)
    r1 = r2 = 0
    for match_obj in eachmatch(r"mul\((\d{1,3}),(\d{1,3})\)", input)
        num1, num2 = parse.(Int, match_obj.captures)
        r1 += num1 * num2
    end

    if !second
        return r1
    end

    pattern2 = r"(do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\))"
    enabled = true

    for matched in eachmatch(pattern2, input)
        if matched.match == "do()"
            enabled = true
        elseif matched.match == "don't()"
            enabled = false
        end

        if enabled && occursin(r"mul\(\d{1,3},\d{1,3}\)", matched.match)
            num1, num2 = parse.(Int, split(matched.match[5:end-1], ","))
            r2 += num1 * num2
        end
    end

    return r2
end

t = [161,48]
if @show p1_2("2024/Day 3/test.txt") == t[1]
    @show p1_2("2024/Day 3/3_24.txt")      
end
if @show p1_2("2024/Day 3/test.txt", true) == t[2]
    @show p1_2("2024/Day 3/3_24.txt", true)
end