using BufferedStreams

function sandFalling(file::String, second::Bool)
    input = readlines(file)
    splitted = []

    min_x::Int64 = typemax(Int64)
    max_x::Int64 = typemin(Int64)
    min_y::Int64 = typemax(Int64)
    max_y::Int64 = typemin(Int64)

    for line in input splits = split(line, "->") 
        line_points = [parse.(Int, split(s, ",")) for s in splits] 
        push!(splitted, line_points)
        for part in line_points
            x = part[1]
            y = part[2]
            
            min_x = min(min_x, x)
            max_x = max(max_x, x)
            min_y = min(min_y, y)
            max_y = max(max_y, y)
        end
    end

    width = Int(max_x - min_x + 1)
    height = max_y + 1
    # Create a 2D array filled with '.'
    if !second
        cave = fill('.', height, width)
    else
        cave = fill('.', max_y+2+1, width)
    end

    #fill the cave with rocks based of splitted
    for line_points in splitted
        for i in eachindex(line_points)[2:end]
            x, y = line_points[i]
            x_p, y_p = line_points[i-1]
    
            if y_p == y
                #draw a Horizontal line
                for j in min(x, x_p):max(x, x_p)
                    cave[y+1, j-min_x+1] = '#'
                end
            elseif x_p == x
                #draw a vertical line from y_p to y at x
                for j in min(y, y_p):max(y, y_p)
                    cave[j+1, x-min_x+1] = '#'
                end
            end
        end
    end
    if second
        x = 150 #arbitrary number
        # Add x columns of '.' at the left and right
        cave = hcat(repeat(['.'], outer=(size(cave, 1), x)), cave, repeat(['.'], outer=(size(cave, 1), x)))

        # Add a layer of '#' at the bottom
        cave[end, :] .= '#'

        sandstarting = 500 - min_x + 1 + x
        println("sandstarting: $sandstarting, width: $(width + 2*x)")
        sand_y, sand_x = 1, sandstarting
        still_sand = 0
    else
        #drop the sand from width 500 (- min_x)
        sandstarting = 500 - min_x + 1
        println("sandstarting: $sandstarting, width: $width")
        sand_y, sand_x = 1, sandstarting
        still_sand = 0
    end

    # show(stdout, "text/plain", cave)
    while true
        try
            if second && sand_y == 1 && sand_x == sandstarting && cave[1, sandstarting] ∈ ['o']
                break
            end

            if cave[sand_y, sand_x] ∈ ['o']
                if cave[sand_y+1, sand_x-1] ∈ ['#', 'o'] && cave[sand_y, sand_x-1] ∉ ['#', 'o']    #left
                    sand_y , sand_x = sand_y-1, sand_x-1
                elseif cave[sand_y, sand_x-1] ∈ ['#', 'o']  && cave[sand_y+1, sand_x+1] ∈ ['#', 'o'] && cave[sand_y, sand_x+1] ∉ ['#', 'o']  #right
                    sand_y , sand_x = sand_y-1, sand_x+1
                else
                    cave[sand_y-1, sand_x] = 'o'
                    still_sand += 1
                    sand_y, sand_x = 0, sandstarting
                end
            elseif cave[sand_y, sand_x] ∈ ['#']
                if cave[sand_y, sand_x-1] ∈ ['.']
                    sand_y , sand_x = sand_y-1, sand_x-1
                elseif cave[sand_y, sand_x-1] ∉ ['.'] && cave[sand_y, sand_x+1] ∈ ['.']
                    sand_y , sand_x = sand_y-1, sand_x+1
                else
                    cave[sand_y-1, sand_x] = 'o'    #sand has to be placed above current sand_y 
                    still_sand += 1
                    sand_y, sand_x = 0, sandstarting
                end
            end
            # println("still_sand: $still_sand")
            # show(stdout, "text/plain", cave)
            sand_y += 1
        catch e
            break
        end
    end
    # show(stdout, "text/plain", cave)  

    #write to file
    open("2022/Day 14/14_22_out.txt", "w") do f
        for i in 1:length(cave[:,1])
            for j in 1:length(cave[1,:])
                write(f, cave[i,j])
            end
            write(f, "\n")
        end
    end

    return still_sand
end

@show sandFalling("2022/Day 14/14_22.txt", false)   #843
@show sandFalling("2022/Day 14/14_22.txt", true)