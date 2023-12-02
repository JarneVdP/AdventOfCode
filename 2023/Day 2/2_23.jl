function cubebag(file::String, second::Bool)
    sum, sum_2 = 0, 0
    id = 1 
    redcubes, greencubes, bluecubes = 12, 13, 14
    max_red, max_green, max_blue = typemin(Int64), typemin(Int64), typemin(Int64)

    for line in readlines(file)
        skip = false
        for s in split(split(line, ':')[2], ';')
            for c in split(s, ',')
                number = parse(Int, filter(isdigit, c))
                if !second
                    if contains(c, "red") && number > redcubes
                        skip = true
                        break
                    elseif contains(c, "green") && number > greencubes
                        skip = true
                        break
                    elseif contains(c, "blue") && number > bluecubes
                        skip = true
                        break
                    end
                elseif second
                    if contains(c, "red")
                        max_red = max(max_red, number)
                    elseif contains(c, "green")
                        max_green = max(max_green, number)
                    elseif contains(c, "blue")
                        max_blue = max(max_blue, number)
                    end
                end
            end
            if skip
                break
            end
        end
        sum_2 += max_red * max_green * max_blue
        if !skip
            sum += id
        end
        max_red = max_green = max_blue = typemin(Int64)
        id += 1
    end
    if second
        return sum_2
    end
    return sum
end

@show cubebag("2023/Day 2/2_23.txt", false)   #2776
@show cubebag("2023/Day 2/2_23.txt", true)    #68638