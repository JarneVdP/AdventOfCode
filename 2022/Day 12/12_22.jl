using Graphs

function HillClimb(file::String, second::Bool)
    input = [collect(line) for line in readlines(file)]
    startChar = second == false ? 'S' : 'a'
    endChar = 'E'

    # Find the start and end positions
    starts = [] 
    ending = (0, 0)
    for (i, row) in enumerate(input)
        for (j, cell) in enumerate(row)
            if cell == startChar
                push!(starts, (i, j))
            elseif cell == endChar
                ending = (i, j)
            end
        end
    end

    # BFS
    shortest_path_length = Inf
    path = []
    for start in starts

        queue = [(start, [start], startChar)]
        visited = Set()
        while !isempty(queue)
            (pos, path, last_char) = popfirst!(queue)
            for d in [(-1, 0), (1, 0), (0, -1), (0, 1)]  # Up, down, left, right
                next_pos = (pos[1] + d[1], pos[2] + d[2])
                if next_pos[1] < 1 || next_pos[1] > length(input) || next_pos[2] < 1 || next_pos[2] > length(input[1])
                    continue  # Out of bounds
                end
                next_char = input[next_pos[1]][next_pos[2]]
                if next_char == endChar && last_char == 'z'
                    shortest_path_length = min(shortest_path_length, length(path))
                    if !second
                        return length(path)  # Reached the end, return distance
                    end
                elseif (last_char == 'S' && next_char == 'a') || next_char == Char(last_char + 1) || (last_char != 'S' && next_char == last_char) || (last_char != 'S' && next_char < last_char)  # Next character in sequence, same character, or lower character
                    if (next_pos, next_char) in visited
                        continue  # Already visited this position with this character
                    end
                    push!(visited, (next_pos, next_char))
                    new_path = copy(path)
                    push!(new_path, next_pos)
                    push!(queue, (next_pos, new_path, next_char))
                end
            end
        end
    end
    return shortest_path_length # Return shortest path length
end


#made using copilot chat
@show HillClimb("2022/Day 12/12_22.txt", false) #437
@show HillClimb("2022/Day 12/12_22.txt", true) #430