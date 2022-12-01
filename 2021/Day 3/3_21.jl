function PartOne(lines, bit)    #gamme: most common, epsilon: least common
    counter = 0
    numberZero = zeros(Int64, 12)
    numberOne = zeros(Int64, 12)
    for line in lines
        for element in line
            counter += 1
            if element == '0'
                numberZero[counter] += 1
            else
                numberOne[counter] += 1
            end
        end
        counter = 0
    end
    println("amount of 0: ",numberZero), println("amount of 1: ", numberOne)

    binarygamma, binaryepsilon = 0, 0   
    for i in 1:length(numberZero)
        if numberZero[i] <= numberOne[i] && bit == true     #Oxygen, mostcommon
            binarygamma  += 1 * 10^(length(numberZero)-i) 
        elseif numberZero[i] > numberOne[i] && bit == true  #Oxygen, leastcommon
            binaryepsilon += 1 * 10^(length(numberZero)-i)  
        elseif numberZero[i] < numberOne[i] && bit == false  #CO2, mostcommon
            binarygamma += 1 * 10^(length(numberZero)-i)          
        elseif numberZero[i] >= numberOne[i] && bit == false #CO2, leastcommon
            binaryepsilon  += 1 * 10^(length(numberZero)-i)   
        end
    end
    mostCommon = binarygamma
    leastCommon = binaryepsilon
    println("mostCommon:  ",lpad(binarygamma, 12, "0")), println("leastCommon: ",lpad(binaryepsilon, 12, "0"))


    decimalgamma, decimalepsilon, decimal  = 0, 0, 0
    decimalgamma  = binToDec(parse(Int64, string("0b", string(binarygamma))))
    decimalepsilon  = binToDec(parse(Int64, string("0b", string(binaryepsilon))))
    decimal = decimalgamma * decimalepsilon
    return decimal, mostCommon, leastCommon
end



#convert binary to decimal
function binToDec(bin)
    dec = 0
    for i in 1:length(bin)
        dec += bin[i] * 2^(length(bin)-i)
    end
    return dec
end



# Part 2
function PartTwo(lines)
    Oxygen, CO2 = copy(lines), copy(lines)
    i = 0
    for i in 1:12     #length(digits(mostCommon))
        Oxygen = dropArray(Oxygen,true, i)
        println("Oxygen: ", Oxygen)
        if length(Oxygen) == 1
            break
        end
    end
    println("############################################# \n ############################################# \n")
    for i in 1:12     #length(digits(leastCommon)) but changed it at the markers because i didnt want to chanmge the dropArray function which gave me errors. :)
        #print("length: ", 12-i)
        CO2 = dropArray(CO2,false, i)
        println("CO2: ", CO2)
        if length(CO2) == 1
            break
        end
    end
    #println("Oxygen: ", Oxygen, " CO2: ", CO2) 

    #convert binary to decimal
    CO2_int = binToDec(parse(Int64, string("0b", CO2[1])))
    Oxygen_int = binToDec(parse(Int64, string("0b", Oxygen[1])))
    println(CO2_int," ", Oxygen_int," ", CO2_int*Oxygen_int )

    return Oxygen_int * CO2_int
end



function dropArray(array,common,  i)
    numberarray = []
    println(common)
    decimal, mostcommon, leastcommon  = PartOne(array, common)
    variable = mostcommon

    println("variable: ", variable)    
    number = 0
    Common = reverse(digits(variable))
    println("Common: ", Common)
    for line in array
        number += 1
        if parse(Int,line[i]) != Common[i]
            push!(numberarray, number)
        end
    end
    splice!(array, numberarray)
    #println("array: ", array)
    return array
end

function firstdigit(x)
    z=abs(x)
    while z >= 10
       z = div(z,10)
    end
    return z
end

lines = readlines("2021/Day 3/3_21.txt")
answer,mostCommon, leastCommon = PartOne(lines, true)
println("Solution part 1: ", answer, " ", leastCommon)  #775304
println("Solution part 2: ", PartTwo(lines))    #1370737, oxygen: 000111111101 - check, CO2: 101010000101
                                                #1362930

                                                #101010010010 mine  count_ones, count_zeros
                                                #101010000101 his