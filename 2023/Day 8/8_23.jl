function p1_2(file::String, second::Bool=false)
    input = readlines(file)
    r1 = r2 = 0
    instruction = input[1]
    sequence = input[3:end]
    current = "AAA"
    s2d = []
    #convert sequence to 2d array
    for line in sequence
        push!(s2d, [line[1:3], line[8:10], line[13:15]])
    end
    if !second
        while current != "ZZZ"
            r1 += 1
            char = instruction[1]
            instruction = instruction[2:end]
            for chars in s2d
                if chars[1] == current
                    current = char == 'L' ? chars[2] : chars[3]
                    break
                end
            end

            if length(instruction) == 0
                instruction = input[1]
            end
        end

    elseif second
        #start array
        current_array = []
        current_length = []
        for chars in s2d
            if chars[1][3] == 'A'
                push!(current_array, chars[1])
            end
        end
        current_length = fill(0, length(current_array))
        all_last_chars_Z = false
        while !all_last_chars_Z
            char = instruction[1]
            instruction = instruction[2:end]
            
            for i in eachindex(current_array)
                for chars in s2d
                    if chars[1] == current_array[i]
                        current_array[i] = char == 'L' ? chars[2] : chars[3]
                        break
                    end
                    
                    if current_array[i][end] == 'Z' && current_length[i] == 0
                        current_length[i] = r2
                    end
                end
            end
            r2 += 1
            instruction = length(instruction) == 0 ? input[1] : instruction
            all_last_chars_Z = all(x -> x != 0, current_length)
        end
        println(current_length)
        r2 = lcm(current_length)
        println(r2)
    end

    return second ? r2 : r1
end

t = [2, 6]
if @show p1_2("2023/Day 8/test.txt") == t[1]
    @show p1_2("2023/Day 8/8_23.txt")      #16897
end
#part 2 takes a loooong time
if @show p1_2("2023/Day 8/test2.txt", true) == t[2]
    @show p1_2("2023/Day 8/8_23.txt", true)     #16563603485021
end