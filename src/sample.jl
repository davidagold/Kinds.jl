df = DataFrame()
df[:name] = ["John", "Mary", "Gunther", "Isabel", "Niamh", "Wendy", "Troy"]
df[:sex] = ["M", "F", "M", "F", "F", "F", "M"]
df[:groupID] = zeros(Int, 7)
df[:height] = [5.75, 5.63, 6.10, 5.45, 6.02, 5.72, 5.72]
df[:gpa] = @data([NA, 3.90, NA, 3.76, NA, NA, 3.44])

export individuals, w, people, students

individuals = [
    [
        :name => "John",
        :sex => "M",
        :groupID => 0,
        :height => 5.75
    ],

    [
        :name => "Mary",
        :sex => "F",
        :groupID => 0,
        :height => 5.63,
        :gpa => 3.90
    ],

    [
        :name => "Gunther",
        :sex => "M",
        :groupID => 0,
        :height => 6.10
    ],

    [
        :name => "Isabel",
        :sex => "F",
        :groupID => 0,
        :height => 5.45,
        :gpa => 3.76
    ],

    [
        :name => "Niamh",
        :sex => "F",
        :groupID => 0,
        :height => 6.02
    ],

    [
        :name => "Wendy",
        :sex => "F",
        :groupID => 0,
        :height => 5.72
    ],

    [
        :name => "Troy",
        :sex => "F",
        :groupID => 0,
        :height => 5.72,
        :gpa => 3.44
    ]
]

w = World()
populate!(w, individuals...)
actualize(w)

@Kind people begin
    :name ::ASCIIString
    :sex ::ASCIIString
    :groupID ::Int64
    :height ::Float64
end

@Kind students < people begin
    :gpa ::Float64
end
