all_games = open(".\\data\\problem00401.txt")

count_inter = 0
count_inter_overlap = 0

for (index, value) in enumerate(map( x -> x, eachline(all_games)))
    x, y  = split(value, ",")
    x_min, x_max = map(s -> parse(Int32, s),split(x, "-"))
    y_min, y_max = map(s -> parse(Int32, s),split(y, "-"))
    is_x_all =  (x_min <= y_min) &  (y_max <= x_max)
    is_y_all =  (y_min <= x_min) &  (x_max <= y_max)

    is_overlap = (x_max < y_min) | (y_max < x_min)
    
    if is_x_all
        global count_inter +=1
    elseif is_y_all
        global count_inter +=1
    else
        # println("NONE  ",value)
    end

    if !is_overlap
        global count_inter_overlap +=1
    end

end

println(count_inter)
println(count_inter_overlap)