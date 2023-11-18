using Plots
function HillClimb(file::String, second::Bool)
    input = [collect(line) for line in readlines(file)]
    startChar = 'a'
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

    shortest_path_length = Inf
    shortest_path = []
    for start in starts
        # BFS
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
                if (next_pos, next_char) in visited
                    continue  # Already visited this position with this character
                elseif next_pos == ending && next_char == endChar
                    shortest_path = length(path) < shortest_path_length ? path : shortest_path
                    shortest_path_length = min(shortest_path_length, length(path))
                    if !second
                        return path  # Reached the end, return path
                    end
                elseif (last_char == 'S' && next_char == 'a') || next_char == Char(last_char + 1) || (last_char != 'S' && next_char == last_char) || (last_char != 'S' && next_char < last_char)  # Next character in sequence, same character, or lower character
                    push!(visited, (next_pos, next_char))
                    new_path = copy(path)
                    push!(new_path, next_pos)
                    push!(queue, (next_pos, new_path, next_char))
                end
            end
        end
    end

    return shortest_path  # Return shortest path
end

# Call your function
path = HillClimb("2022/Day 12/12_22.txt", false)

# Extract the x and y coordinates from the path
x_coords = [pos[2] for pos in path]
y_coords = [pos[1] for pos in path]

#create a 3d video where the z axis is the height (S is the lowest, E is the highest)
#get z coordinates by taking x and y and looking at 
input = [collect(line) for line in readlines("2022/Day 12/12_22.txt")]
z_coords = []
for i in 1:length(x_coords)
    char = input[y_coords[i]][x_coords[i]]
    if char == 'S'
        push!(z_coords, 0)
    else
        push!(z_coords, Int(char - Int('a') + 1))
    end
end

#create a 3d animation where x is x, y is y z is z = height
#dont show the axes and make the line change colour over time from green to red depending on the height
xmin, xmax = extrema(x_coords)
ymin, ymax = extrema(y_coords)
zmin, zmax = extrema(z_coords)

# Create a custom color gradient
cmap = cgrad([:green, :orange, :red])

anim = @animate for i in 1:length(x_coords)
    plot(x_coords[1:i], y_coords[1:i], z_coords[1:i], color = z_coords[1:i], colorbar = true, colorbar_title = "AoC 12 - 2022", c = cmap, axis=false, camera=(30, 40), xlims=(xmin, xmax), ylims=(ymin, ymax), zlims=(zmin, zmax), title="AoC 12 - 2022", legend=false)
end

gif(anim, "2022/Day 12/12_22.gif", fps = 10)