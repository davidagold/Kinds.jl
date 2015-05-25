df = DataFrame()
df[:name] = ["John", "Mary", "Gunther", "Isabel", "Niamh", "Wendy"]
df[:sex] = ["M", "F", "M", "F", "F", "F"]
df[:groupID] = zeros(Int, 6)
df[:height] = rand(6) .+ 5.5
