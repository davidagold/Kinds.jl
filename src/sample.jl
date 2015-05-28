# df = DataFrame()
# df[:name] = ["John", "Mary", "Gunther", "Isabel", "Niamh", "Wendy"]
# df[:sex] = ["M", "F", "M", "F", "F", "F"]
# df[:groupID] = zeros(Int, 6)
# df[:height] = rand(6) .+ 5.5


export individuals, w, People, Students

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

@Natural People begin
    :name ::ASCIIString
    :sex ::ASCIIString
    :groupID ::Int64
    :height ::Float64
end
#
@Natural Students <: People begin
    :gpa ::Float64
end
