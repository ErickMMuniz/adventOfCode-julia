# What would your total score be if everything goes exactly according to your strategy guide?

all_games = open(".\\data\\problem00201.txt")

each_elf = 0
is_another_elf = false
elfs = Int[]

re = r"[ABC] [XYZ]+\n{0,1}"

# 1 for Rock, 2 for Paper, and 3 for Scissors
general_values = Dict{String,Integer}("A" => 1, "B" => 2, "C" => 3)

# outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
general_score = Dict{Integer,Integer}(0 => 3, -1 => 0, 1 => 6)

struct Game
    left::String
    right::String

    function Game(decrypted, encrypted, is_new_format = true)
        if is_new_format
            new(decrypted, encryp_to_decryp(encrypted))
        else
            new(decrypted, encrypted)
        end
        return new(decrypted, encryp_to_decryp(encrypted))
    end

    function encryp_to_decryp(to_decrypt::String)
        if to_decrypt == "X"
            return "A"
        elseif to_decrypt == "Y"
            return "B"
        elseif to_decrypt == "Z"
            return "C"
        else
            return to_decrypt
        end
    end
end


function get_result(game::Game)
    if game.left == "A"
        if game.right == "A"
            return general_score[0]
        elseif game.right == "B"
            return general_score[1]
        else
            return general_score[-1]
        end
    elseif game.left == "B"
        if game.right == "A"
            return general_score[-1]
        elseif game.right == "B"
            return general_score[0]
        else
            return general_score[1]
        end
    else 
        if game.right == "A"
            return general_score[1]
        elseif game.right == "B"
            return general_score[-1]
        else
            return general_score[0]
        end
    end 
end

stream_results = Int[]

for line in eachline(all_games, keep=true)
    if occursin(re, line)
        splitted = split(line)
        decrypted = String(splitted[1])
        encrypted = String(splitted[2])
        game = Game(decrypted, encrypted)
        expected_result = get_result(game) + general_values[game.right]
        append!(stream_results, expected_result)
    end
end

# println(sum(stream_results))


general_result = Dict{String, Integer}("X" => -1, "Y" =>  0 , "Z" => 1)
dict_to_win = Dict{String, String}("A" => "B", "B" =>  "C" , "C" => "A")
dict_to_lose = Dict{String, String}("A" => "C", "B" =>  "A" , "C" => "B")
dict_to_draw = Dict{String, String}("A" => "A", "B" =>  "B" , "C" => "C")

dict_state = Dict{Integer, Dict}(-1 => dict_to_lose, 0 => dict_to_draw, 1 => dict_to_win)

stream_results_new = Int[]

for line in eachline(all_games, keep=true)
    if occursin(re, line)
        splitted = split(line)
        decrypted = String(splitted[1])
        result = String(splitted[2])
        change_state = dict_state[general_result[result]]
        game = Game(decrypted, change_state[decrypted], false)
        expected_result = get_result(game) + general_values[game.right]
        append!(stream_results_new, expected_result)
    end
end

# Following the Elf's instructions for the second column, what would your total score be if everything goes exactly according to your strategy guide?
# println(sum(stream_results_new))