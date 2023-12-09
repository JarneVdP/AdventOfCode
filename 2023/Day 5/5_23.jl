function p1(file::String)
    input = filter(!isempty, readlines(file))
    seeds_input = map(s -> parse(Int64, s), split(input[1], ' ')[2:end])

    overview = []
    seeds = sort(unique(seeds_input))
    updated = falses(length(seeds))  # Create a boolean array to track updates
    for line in input[2:end]
        if isdigit(line[1])
            overview = map(s -> parse(Int, s), split(line, ' '))
            range = overview[2]:overview[2]+overview[3]-1
            for i in eachindex(seeds)
                if seeds[i] in range && !updated[i]  # Check if seeds[i] has not been updated
                    seeds[i] = seeds[i] - overview[2] + overview[1]
                    updated[i] = true  # Mark seeds[i] as updated
                end
            end
        end
        if !isdigit(line[1])
            updated .= false  # Reset the updated array when a non-digit is found
        end
    end
    return minimum(seeds)
end

#going against my own morals and creating a whole new function for part 2
#s/o https://www.reddit.com/r/adventofcode/comments/18b4b0r/comment/kc2v876/?utm_source=share&utm_medium=web2x&context=3

function p2(file::String)
    lines = filter(!isempty, readlines(file))
    seeds = parse.(Int, split(lines[1])[2:end])
    maps = []
    current_map = []
    for line in lines[2:end]
        if contains(line, "map:")
            if !isempty(current_map)
                push!(maps, current_map)
                current_map = []
            end
        else
            push!(current_map, parse.(Int, split(line)))
        end
    end
    push!(maps, current_map)  # Don't forget the last map

    locations = []
    for i in 1:2:length(seeds)
        ranges = [[seeds[i], seeds[i+1] + seeds[i]]]
        results = []
        for _map in maps
            while !isempty(ranges)
                range = pop!(ranges)
                start_range, end_range = range[1], range[2]
                overlap = false
                for (dest, source, r) in _map
                    end_map = source + r
                    offset = dest - source
                    if end_map <= start_range || end_range <= source  # no overlap
                        continue
                    end
                    if start_range < source
                        push!(ranges, [start_range, source])
                        start_range = source
                    end
                    if end_map < end_range
                        push!(ranges, [end_map, end_range])
                        end_range = end_map
                    end
                    push!(results, [start_range + offset, end_range + offset])
                    overlap = true
                    break
                end
                if !overlap
                    push!(results, [start_range, end_range])
                end
            end
            ranges = results
            results = []
        end
        append!(locations, ranges)
    end

    return isempty(locations) ? nothing : minimum(loc[1] for loc in locations)
end

t = [35, 46]
if @show p1("2023/Day 5/test.txt") == t[1]
    @show p1("2023/Day 5/5_23.txt")         #424490994
end
if @show p2("2023/Day 5/test.txt") == t[2]
    @show p2("2023/Day 5/5_23.txt")   #15290096 
end