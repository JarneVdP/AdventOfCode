function p1_2(file::String, second::Bool=false)
    input = readlines(file)
    r1 = r2 = 0
    time = parse.(Int, filter(!isempty, split(input[1], ' ')[2:end]))
    distance = parse.(Int, filter(!isempty, split(input[2], ' ')[2:end]))
    
    if second
        time = parse(Int, join(time))
        distance = parse(Int, join(distance))
    end

    total_distance = []
    local_distance = []
    for r in eachindex(time)
        for speed in 1:time[r]
            time_remaining = time[r] - speed
            if time_remaining * speed > distance[r]
                push!(local_distance, speed)
            end
        end
        push!(total_distance, local_distance)
        local_distance = []
    end
    r1 = prod(map(length, total_distance))

    return r1
end

t = [288, 71503]
if @show p1_2("2023/Day 6/test.txt") == t[1]
    @show p1_2("2023/Day 6/6_23.txt")      
end
if @show p1_2("2023/Day 6/test.txt", true) == t[2]
    @show p1_2("2023/Day 6/6_23.txt", true)
end