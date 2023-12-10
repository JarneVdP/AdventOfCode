using StatsBase
function p1_2(file::String, second::Bool=false)
    cards_bid = map(line -> split(line, ' '), readlines(file))
    strength = Dict('A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, 'T' => 10,
        '9' => 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5,
        '4' => 4, '3' => 3, '2' => 2, '*' => 1)

    if second
        cards_bid = [(replace(card, 'J' => '*'), bid) for (card, bid) in cards_bid]
    end
    cards_bid = sort(cards_bid, by=x -> hand_order(x[1], strength), rev=true)

    cards = [cb[1] for cb in cards_bid]
    bid = [parse(Int, cb[2]) for cb in cards_bid]
    rank = []

    count_to_rank = Dict([5] => 7, [4, 1] => 6, [3, 2] => 5, [3, 1, 1] => 4, [2, 2, 1] => 3, [2, 1, 1, 1] => 2)
    for card in cards
        frequency = countmap(card)
        counts = sort(collect(values(frequency)), rev=true)
        if second
            j_count = count(c -> c == '*', card)
            if j_count > 0
                if j_count == length(card)
                    # If all cards are 'J', consider them as 'A'
                    most_frequent_card = 'A'
                    # Add 'A' to the frequency dictionary if it does not exist
                    if !haskey(frequency, 'A')
                        frequency['A'] = 0
                    end
                else
                    # Find the card with the maximum frequency that is not 'J'
                    most_frequent_card = argmax(x -> x.first != '*' ? x.second : -Inf, frequency).first
                end
                frequency[most_frequent_card] += j_count
                delete!(frequency, '*')
            end
            counts = sort(collect(values(frequency)), rev=true)
        end
        
        rank_value = get(count_to_rank, counts, 1)
        push!(rank, rank_value)
    end

    sort_indices = sortperm(rank, rev=true)

    cards = cards[sort_indices]
    bid = bid[sort_indices]
    
    reverse!(cards)
    reverse!(bid)
    r1 = sum([bid[i] * i for (i, bid[i]) in enumerate(bid)])

    return r1
end

function hand_order(hand, strength)
    return [strength[c] for c in hand]
end



t = [6440, 5905]
if @show p1_2("2023/Day 7/test.txt") == t[1]
    @show p1_2("2023/Day 7/7_23.txt")      #252656917
end
if @show p1_2("2023/Day 7/test.txt", true) == t[2]
    @show p1_2("2023/Day 7/7_23.txt", true)     #253499763
end