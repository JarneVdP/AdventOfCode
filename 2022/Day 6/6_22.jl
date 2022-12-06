function packet(file, second::Bool)
    string = readlines(file)
    #declare a vector of length 4
    #read the first 4 chars and place in charSeen
    charArray = []
    #loop trough each char of line and append to char
    [push!(charArray, char) for char in collect(string[1])]
    if !second
        for i in 1:length(charArray)
            allunique(charArray[i:i+4]) ? [return i+3] : nothing
        end
    else
        for i in 1:length(charArray)
            allunique(charArray[i:i+13]) ? [return i+13] : nothing
        end
    end
end


@show packet("2022/Day 6/6_22.txt", false)  #1198
@show packet("2022/Day 6/6_22.txt", true)  #3120