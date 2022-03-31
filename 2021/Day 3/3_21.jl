function PartOne(lines)
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

    binarygamma, binaryepsilon = 0, 0
    for i in 1:length(numberZero)
        if numberZero[i] < numberOne[i]
            binarygamma  += 1 * 10^(length(numberZero)-i)
        else
            binaryepsilon += 1 * 10^(length(numberZero)-i)
        end
    end
    binarygamma  = parse(Int64, string("0b", string(binarygamma))) #make it binary by putting 0b in the front.. int -> string -> int
    binaryepsilon  = parse(Int64, string("0b", string(binaryepsilon))) #make it binary by putting 0b in the front.. int -> string -> int

    decimalgamma, decimalepsilon, decimal  = 0, 0, 0
    decimalgamma  = binToDec(binarygamma)
    decimalepsilon  = binToDec(binaryepsilon)
    decimal = decimalgamma * decimalepsilon
    return decimal
end

#convert binary to decimal
function binToDec(bin)
    dec = 0
    for i in 1:length(bin)
        println(bin[i])
        dec += bin[i] * 2^(length(bin)-i)
    end
    return dec
end

lines = readlines("3_21.txt")
println("Solution part 1: ", PartOne(lines))

