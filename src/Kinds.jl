module Kinds

export World, NaturalKind, Kind
export @Natural, @KindOf
export populate!, actualize, belongs, show
export actuality, w, individuals

################################################################
##  Types
################################################################

typealias Individual Dict{Symbol, Any}
typealias Book Dict{Uint, Individual}
typealias KindEssence Dict{Symbol, DataType}
typealias Catalog Dict{DataType, KindEssence}
typealias Taxonomy Dict{DataType, Array{Expr, 1}}
abstract NaturalKind
abstract Kind{K <: NaturalKind}

type World
    book::Book
    catalog::Catalog
    taxonomy::Taxonomy
end

function World()
    World(Book(), Catalog(), Taxonomy())
end

const actuality = [ World() ]


################################################################
##  Inclusions
################################################################

include("naturalmacro.jl")
include("kindofmacro.jl")
include("popact.jl")
include("show.jl")

include("/Users/David/.julia/v0.3/Kinds/src/sample.jl")


end # module
