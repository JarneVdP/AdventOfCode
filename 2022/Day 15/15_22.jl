function Beacon(file::String, second::Bool)
    input = readlines(file)
    regex = r"-?\d+"
    data = [[parse(Int64, m.match) for m in eachmatch(regex, line)] for line in input]
    sensor = [d[1] + d[2]*im for d in data]
    beacon = [d[3] + d[4]*im for d in data]
    
    println("starting calculation")

    dist = calculate_distance.(sensor, beacon)

    max_value_b = sensor .+ dist*im
    max_value_t = sensor .- dist*im

    if !second
        y = 10
        covered = Set{Complex{Int}}()
        real_s = real.(sensor)
        imag_s = imag.(sensor)

        for x in -Int(1e7):Int(1e7)
            for (t, b, d, rs, is) in zip(max_value_t, max_value_b, dist, real_s, imag_s)
                dxy = abs(x-rs) + abs(y-is)
                if imag(t) <= y && imag(b) >= y && dxy <= d && x+y*im ∉ b
                    push!(covered, x+y*im)
                end
            end
        end
        # covered = unique(covered)
        count_y = count(x -> imag(x) == y, covered) - 1

        println(count_y)
        return count_y

    elseif second
        d_1 = dist .+ 1
        unique_coords = find_diamond_edge_coordinates(sensor, d_1)
        
        x_min = y_min = 0
        # x_max = y_max = 20
        x_max = y_max = 4000000
        
        #filter out of bounds
        filter!(e -> !(real(e) < x_min || real(e) > x_max || imag(e) < y_min || imag(e) > y_max), unique_coords)
    
        for (s, d) in zip(sensor, dist)
            for c in unique_coords
                dxy = calculate_distance(s, c)
                if dxy <= d
                    delete!(unique_coords, c)
                end
            end
        end
        t_f = real(collect(unique_coords)[1]) * 4000000 + imag(collect(unique_coords)[1])
        return t_f
    end
    return "$second was not recognised"
end


function calculate_distance(sensor::Complex{Int}, beacon::Complex{Int})
    return abs(real(sensor) - real(beacon)) + abs(imag(sensor) - imag(beacon))
end

function find_diamond_edge_coordinates(sensors::Vector{Complex{Int}}, distances::Vector{Int})
    edge_coordinates = Set{Complex{Int}}()

    for (i, sensor) in enumerate(sensors)
        x, y = real(sensor), imag(sensor)
        distance = distances[i]

        for d in 0:distance
            push!(edge_coordinates, (x+d) + (y+distance-d)*im)  # Right edge
            push!(edge_coordinates, (x+d) + (y-distance+d)*im)  # Bottom edge
            push!(edge_coordinates, (x-d) + (y+distance-d)*im)  # Top edge
            push!(edge_coordinates, (x-d) + (y-distance+d)*im)  # Left edge
        end
    end

    return edge_coordinates
end

@showtime Beacon("2022/Day 15/15_22.txt", false)    #5688618
@showtime Beacon("2022/Day 15/15_22.txt", true)     #12625383204261