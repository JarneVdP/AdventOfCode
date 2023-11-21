cmp(l::Int, r::Int) = sign(r - l)
cmp(l::Int, r::Vector) = cmp([l], r)
cmp(l::Vector, r::Int) = cmp(l, [r])

function cmp(l::Vector, r::Vector)
    for i in 1:min(length(l), length(r))
        if l[i] != r[i]
            return cmp(l[i], r[i])
        end
    end
    return sign(length(r) - length(l))
end

function distressSignal(file::String, second::Bool)
    input = map(line -> eval(Meta.parse(line)), filter(!isempty, readlines(file)))

    sum = 0
    cnt = 0
    ind1 = 0
    ind2 = 0

    div_pack1 = [2]
    div_pack2 = [6]


    for (enum, i) in enumerate(1:2:length(input))
        lineL = input[i]
        lineR = input[i+1]
        cnt += 1
        
        #if lineL == Any[] change it to [0]
        lineL = lineL == Any[] ? [0] : lineL
        lineR = lineR == Any[] ? [0] : lineR
        if !second
            if cmp(lineL, lineR) == 1
                sum += cnt
            end
            if length(lineL) == enum && length(lineL) < length(lineR) 
                sum += cnt
            end
        elseif second
            ind1 = cmp(lineL, div_pack1) == 1 ? ind1 + 1 : ind1
            ind1 = cmp(lineR, div_pack1) == 1 ? ind1 + 1 : ind1

            ind2 = cmp(lineL, div_pack2) == 1 ? ind2 + 1 : ind2
            ind2 = cmp(lineR, div_pack2) == 1 ? ind2 + 1 : ind2
        end
    end
    if second
        return (ind1 + 1) * (ind2 + 2)
    end
    return sum
end

@show distressSignal("2022/Day 13/13_22.txt", false)
@show distressSignal("2022/Day 13/13_22.txt", true)

#5717
# 25935