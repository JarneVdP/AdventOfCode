function p1_2(file::String, second::Bool=false)
    input = readlines(file)
    r1 = r2 = 0

    directions = Dict(
        1 => -1 + 0im,  #up
        2 => 0 + 1im,   #right
        3 => 1 + 0im,   #down
        4 => 0 - 1im,   #left
    )

    startpos_ = findfirst(contains('^'),input)
    startpos_i = findfirst('^', input[startpos_])
    pos = startpos_ + startpos_i*im
    seen = Set(pos)        

    function get_value(grid, pos)
        row, col = Int(real(pos)), Int(imag(pos))
        if row in 1:size(grid, 1) && col in 1:length(grid)
            return grid[row][col]
        else
            return '!'
        end
    end

    function move(pos, direction)
        return pos + directions[direction]
    end

    dir = 1 #up
    while get_value(input, pos+directions[dir]) != '!' #check if it's in the grid
        pos = move(pos, dir)
        if get_value(input, pos) == '#'
            pos = pos - directions[dir] #go back one step
            dir = dir % 4 + 1   #up, right, down, left, up
        end
        push!(seen, pos)
    end

    r1 = length(seen)
    if !second
        return r1
    end

    for extra in seen
        row, col = Int(real(extra)), Int(imag(extra))
        input2 = copy(input)
        input2[row] = input[row][begin:col-1] * "#" * input[row][col+1:end]

        pos = startpos_ + startpos_i*im
        dir = 1 #up
        seen2 = [(pos, dir)]
        while get_value(input2, pos+directions[dir]) != '!' #check if it's in the grid
            pos = move(pos, dir)
            if get_value(input2, pos) == '#'
                pos = pos - directions[dir] #go back one step
                dir = dir % 4 + 1   #up, right, down, left, up
            end
            if (pos,dir) ∈ seen2
                r2 += 1
                break
            else
                push!(seen2, (pos,dir))
            end
        end
    end
    @show r2

    return r2
end

t = [41,6]
if @show p1_2("2024/Day 6/test.txt") == t[1]
    @show p1_2("2024/Day 6/6_24.txt")      
end
if @show p1_2("2024/Day 6/test.txt", true) == t[2]
    @show p1_2("2024/Day 6/6_24.txt", true)
end