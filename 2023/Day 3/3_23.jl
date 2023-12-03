function engine(file::String, second::Bool=false)
    # input = read(file, String)
    input = [collect(line) for line in readlines(file)]
    sum = 0
    gear_ratio = 0
    s_c = Set{Char}()
    for line in input
        union!(s_c, filter(is_special, line))
    end
    println(collect(s_c))
    
    if !second    
    i = 1
    while i <= length(input)
        j = 1
        while j <= length(input[i])
            if isdigit(input[i][j])
                neighbors = [input[i+k][j+l] for k in -1:1, l in -1:1 if (k != 0 || l != 0) && 1 <= i+k <= length(input) && 1 <= j+l <= length(input[i])]
                if any(x -> x in s_c, neighbors)
                    start = j
                    while start > 1 && isdigit(input[i][start-1])
                        start -= 1
                    end
                    stop = j
                    while stop < length(input[i]) && isdigit(input[i][stop+1])
                        stop += 1
                    end
                    sum += parse(Int, join(input[i][start:stop]))
                    j = stop
                end
            end
            j += 1
        end
        i += 1
    end

elseif second
    processed_stars = Set()
    for i in eachindex(input)
        for j in eachindex(input[i])
            if isdigit(input[i][j])
                neighbors = [(i+k, j+l) for k in -1:1, l in -1:1 if (k != 0 || l != 0) && 1 <= i+k <= length(input) && 1 <= j+l <= length(input[i])]
                star_neighbors = filter(x -> input[x[1]][x[2]] == '*' && !(x in processed_stars), neighbors)
                for star in star_neighbors
                    star_neighbors = [(star[1]+k, star[2]+l) for k in -1:1, l in -1:1 if (k != 0 || l != 0) && 1 <= star[1]+k <= length(input) && 1 <= star[2]+l <= length(input[star[1]+k])]
                    number_neighbors = filter(x -> isdigit(input[x[1]][x[2]]), star_neighbors)
                    number1 = parse(Int, get_number(input, (i, j)))
                    number2 = parse(Int, get_number(input, number_neighbors[1]))
                    if number1 != number2
                        push!(processed_stars, star)
                        gear_ratio += number1 * number2
                    end
                end
            end
        end
    end
end


    return second ? gear_ratio : sum 
end

function is_special(char)
    return char != '.' && char != '\n' && char != '\r' && !isdigit(char)
end

function get_number(input, start)
    stop = start
    while start[2] > 1 && isdigit(input[start[1]][start[2]-1])
        start = (start[1], start[2]-1)
    end
    while stop[2] < length(input[stop[1]]) && isdigit(input[stop[1]][stop[2]+1])
        stop = (stop[1], stop[2]+1)
    end
    return join(input[start[1]][start[2]:stop[2]])
end

@show engine("2023/Day 3/3_23.txt")         #498559
@show engine("2023/Day 3/3_23.txt", true)   #