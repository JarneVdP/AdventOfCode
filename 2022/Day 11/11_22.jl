function monkeyBusiness(file, second::Bool)
    input = filter(!isempty, map(lstrip, readlines(file)))
    # println(input)
    monkeynumber = -1
    input_set = 8 # or 4
    items = [Int128[] for _ in 1:input_set]
    iterations = second == true ? 10000 : 20
    inspection = [0 for _ in 1:input_set]
    divisible = -1
    calculated = []
    monkey_business = 0

    run_once = true
    modulo = 1
    moduloTrick = []

    #calculate the modulo in advance
    for line in input
        splitted = split(line, " ")
        if splitted[1] == "Test:"
            divisible = parse(Int128, splitted[4])
            if !(divisible in moduloTrick)
                push!(moduloTrick, divisible)
            end
        end
    end
    if length(moduloTrick) == input_set && run_once
        for i in moduloTrick
            modulo *= i
        end 
        run_once = false
    end
    

    for i in 1:iterations
        divisible_numbers = []
        non_divisible_numbers = []
        for line in input
            # if line starts with "Monkey", the next part is the first value of the array
            # println(line)
            splitted = split(line, " ")
            if splitted[1] == "Monkey"
                monkeynumber = parse(Int128, splitted[2][1])
            end

            if splitted[1] == "Starting" && i == 1
                #delete the first two elements from splitted, remove the commas and parse the following elements of splitted for this line to integers
                #take the first two digits from splitted[3:end]
                numbers = parse.(Int128, map(x -> x[1:2], splitted[3:end]))
                #append the numbers to the items array at monkeynumber + 1
                if monkeynumber + 1 > length(items)
                    push!(items, numbers)  # Add a new row to items
                else
                    append!(items[monkeynumber + 1], numbers)  # Append numbers to an existing row
                end
            end
            if splitted[1] == "Operation:"
                inspection[monkeynumber + 1] += 1 * length(items[monkeynumber + 1])

                operation = splitted[5]  # "*", "+"
                all(isdigit, splitted[6]) ? operand = parse(Int, splitted[6]) : operation = "²"
                calculated = []
                if operation == "*"
                    calculated = (items[monkeynumber + 1] .* operand)
                elseif operation == "+"
                    calculated = (items[monkeynumber + 1] .+ operand)
                elseif operation == "²"
                    calculated = (abs2.(items[monkeynumber + 1]))
                end
            end

            if splitted[1] == "Test:"
                divisible = parse(Int128, splitted[4])

                if second
                    calculated = calculated .% modulo
                else
                    calculated = floor.(calculated ./ 3)
                end
            end

            if splitted[2] == "true:"
                #clean up the items array at monkeynumber + 1: delete all elements and append the divisible_numbers and non_divisible_numbers
                items[monkeynumber + 1] = []
                
                #test if the calculated array is divisible by the divisible number, store in divisible_numbers and non_divisible_numbers
                divisible_numbers = calculated[calculated .% divisible .== 0]
                non_divisible_numbers = calculated[calculated .% divisible .!= 0]
                
                #append the divisible_numbers to the items array at monkeynumber + 1
                append!(items[parse(Int128, splitted[6])+1], divisible_numbers)
                
            end
            if splitted[2] == "false:"
                append!(items[parse(Int128, splitted[6])+1], non_divisible_numbers)
            end
        end
        if i == 1 || i == 20 || i == 1000 || i == 2000 || i == 3000 || i == 4000 || i == 5000 || i == 6000 || i == 7000 || i == 8000 || i == 9000 || i == 10000
            print("\r$i / $iterations   ")
        end
    end
    monkey_business = sort(inspection, rev = true)[1] * sort(inspection, rev = true)[2]
    return monkey_business
end


@show monkeyBusiness("2022/Day 11/11_22.txt", false) #110264
@show monkeyBusiness("2022/Day 11/11_22.txt", true) #23612457316
