import StatsBase: countmap   

all_games = open(".\\data\\problem00301.txt")

lowercase = map(s -> string(Char(s)), 97:122)
uppercase = map(s -> string(Char(s)), 65:90)

values_letter = merge(Dict(zip(lowercase, 1:26)),Dict(zip(uppercase, 27:52)))

sum_total = 0 
for line in eachline(all_games)
    n = Int(length(line) /2)
    first = line[begin:n]
    second = line[n+1:end]
    @assert length(first) == length(second) "Count error"
    first = Set(first)
    second = Set(second)
    global sum_total += sum(map(x -> values_letter[string(x)], collect(intersect!(first, second))))
end
println(sum_total)

items_group = []
key_group = Int[]
for (index, value) in enumerate(map( x -> x, eachline(all_games)))
    append!(items_group, Set(value))
    if index % 3 == 0
        unique_key = collect(keys(filter(b -> b[2] == 3, pairs(countmap(items_group)))))
        clean_key = convert(Array{Char,1}, unique_key)
        key = map(x -> string(x),clean_key)[1]
        append!(key_group, values_letter[key])
        global items_group = []
    end
  end
println(sum(key_group))