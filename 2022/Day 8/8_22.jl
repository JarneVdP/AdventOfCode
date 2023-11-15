function treehouse(file, second::Bool)
    input = reshape(parse.(Int64, split(join(readlines(file)), "")), length(readlines(file)[1]), :)
    input = transpose(input)
    # println(input)
    #count the amount of inside trees
    c = 0
    best_distance = -1
    for i in axes(input, 2)
        for j in axes(input, 1)
            max_value = [maximum(input[begin:i-1, j], init=-1),
                maximum(input[i+1:end, j], init=-1),
                maximum(input[i, begin:j-1], init=-1),
                maximum(input[i, j+1:end], init=-1)]

            if input[i, j] .> minimum(max_value)
                c += 1
            end

            #part 2
            #To measure the viewing distance from a given tree, look up, down, left, and right from that tree; stop if you reach an edge or at the first tree that is the same height or taller than the tree under consideration. (If a tree is right on the edge, at least one of its viewing distances will be zero.)
            #start by looking up, down, left, and right from that tree
            if i == 1 || j == 1 || i == size(input)[1] || j == size(input)[2]
                continue
            end
            
            viewing_distance = Dict("up" => 1, "down" => 1, "left" => 1, "right" => 1)
            
            for k in i:-1:1
                k -= 1
                if k != 0 && input[k, j] >= input[i, j]
                    viewing_distance["up"] = i - k
                    break
                end
                viewing_distance["up"] = i - k - 1
            end
            for k in i:size(input)[1]
                k += 1
                if k < size(input)[1] && input[k, j] >= input[i, j]
                    viewing_distance["down"] = k - i
                    break
                end
                viewing_distance["down"] = k - i - 1
            end
            for k in j:-1:1
                k -= 1
                if k != 0 && input[i, k] >= input[i, j]
                    viewing_distance["left"] = j - k
                    break
                end
                viewing_distance["left"] = j - k - 1
            end
            for k in j:size(input)[2]
                k += 1
                if k < size(input)[2] && input[i, k] >= input[i, j]
                    viewing_distance["right"] = k - j
                    break
                end
                viewing_distance["right"] = k - j - 1
            end
        

            # Calculate scenic score
            scenic_score = prod(values(viewing_distance))
            best_distance = max(best_distance, scenic_score)
            # println("viewing_distance: $viewing_distance, scenic_score: $scenic_score, best_distance: $best_distance")

            # println("Max value in row $i: $max_value ,input: $(input[i, j]) at $i,$j")
        end
    end

    if second
        return best_distance
    end
    return c
end



@show treehouse("2022/Day 8/8_22.txt", false)  #1803
@show treehouse("2022/Day 8/8_22.txt", true)  #268912