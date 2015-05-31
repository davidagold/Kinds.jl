module Kinds

using DataArrays, DataFrames, DataFramesMeta

export World, Kind, Taxum
export @Kind, @Taxum
export super, essence, kindof, character, populate!, actualize, belongs, show
export actuality, w, individuals

## Export for dev purposes
export replace_syms
export @cond
export df

################################################################
##  Types
################################################################

abstract AbstractKind

typealias Individual Dict{Symbol, Any}
typealias Book Dict{Uint, Individual}
typealias Essence Dict{Symbol, DataType}
typealias Character Array{Expr, 1}

type Kind <: AbstractKind
    super::Union(Nothing, Kind)
    essence::Essence
end

Kind() = Kind(nothing, Essence())

type Taxum <: AbstractKind
    kindof::Kind
    character::Character
end

Taxum(k) = Taxum(k, Expr[])

type World
    book::Book
end

World() = World(Book())

################################################################
##  Constants
################################################################

const actuality = [ World() ]

################################################################
##  Inclusions
################################################################

include("kind.jl")
include("taxum.jl")
include("popact.jl")
include("show.jl")

include("/Users/David/.julia/v0.3/Kinds/src/sample.jl")


end # module
