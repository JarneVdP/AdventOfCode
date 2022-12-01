function caloriecounting(lines)
    #declare empty array
    calories = []
    #declare temporary value
    temp = 0
    #loop trough lines, if an empty line appears, add the calories to the array
    for line in lines
        if line == ""
            push!(calories, temp)
            temp = 0
        else
            #convert string to Int
            temp += parse(Int64, line)
        end
    end
    #calculate the max value of calories
    max1 = maximum(calories)

    #sort the array from small to large
    sort!(calories)
    #calculate the last three elemts of the array
    max123 = sum(calories[end-2:end])
    return max1, max123
end


lines = readlines("2022/Day 1/1_22.txt")
answer1, answer2 = caloriecounting(lines)
println("Solution part 1: ", answer1)    #correct answer
println("Solution part 2: ", answer2)    #correct answer