# Find the Elf carrying the most Calories.

all_calories_separeted_by_newLines = open(".\\data\\problem00101.txt")

each_elf = 0
is_another_elf = false
elfs = Int[]

re = r"\d+\n{0,1}"


for line in eachline(all_calories_separeted_by_newLines, keep =true)
    if occursin(re, line)
        parsed_calories = parse(Int32,split(line)[1])
        global each_elf += parsed_calories
    else
        append!(elfs, each_elf)
        global each_elf = 0
    end
end
println(maximum(elfs))

# Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?

println(sum(sort(elfs, rev = true)[1:3]))