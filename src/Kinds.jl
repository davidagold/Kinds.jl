module Kinds

export World, NaturalKind
export @Natural
export populate!, actualize, belongs, show
export actual, w, individuals


################################################################
################################################################
##
##  Kinds
##
################################################################
################################################################

typealias Individual Dict{Symbol, Any}
typealias Book Dict{Uint, Individual}
typealias KindEssence Dict{Symbol, DataType}
typealias Catalog Dict{DataType, KindEssence}
abstract NaturalKind
abstract Kind{K <: NaturalKind}

type World
    book::Book
    catalog::Catalog
end

function World()
    World(Book(), Catalog())
end

const actuality = [ World() ]




################################################################
##  @Natural
################################################################

function make_dict(d::Symbol, body)

    e_makedict = Expr(:(=), d)
    e_dictkeys = Expr(:(dict))

    # Push assignment expressions to arguments of e_dictkeys
    # each such assignment expression has head :(=>), first arg the field name,
    # second arg the type associated with the field name by the user in 'body'
    for arg in body.args
        if arg.head == :(::)
            _field = (arg).args[1]
            _type = (arg).args[2]
            e_key = Expr(:(=>), _field, _type)

            push!(e_dictkeys.args, e_key)
        end
    end

    push!(e_makedict.args, e_dictkeys)
    return e_makedict

end

macro Natural(naming, body)

    e_target = Expr(:block)
    e_declare = Expr(:abstract)
    d = gensym()

    if isa(naming, Symbol)
        kindname = naming
        push!(e_declare.args, Expr(:(<:), naming, symbol("NaturalKind")))
    else
        kindname = symbol( "$(naming.args[1])" )
        push!(e_declare.args, Expr(:(<:), kindname, naming.args[3]))
    end

    e_actuality = Expr(:(.), :Kinds, QuoteNode(:actuality))
    e_actual = Expr(:ref, e_actuality, 1)
    e_catalog = Expr(:(.), e_actual, QuoteNode(:catalog))
    e_catalog_ref = Expr(:ref, e_catalog, symbol("$kindname"))
    e_tellactual = Expr(:(=), e_catalog_ref, symbol("$d"))

    push!(e_target.args, e_declare)
    push!(e_target.args, make_dict(d, body))
    push!(e_target.args, e_tellactual)

    esc(e_target)

end


################################################################
##  @bookname
################################################################

macro bookname(w)

    e_wbook = Expr(:(.), w, QuoteNode(:book))

    name = gensym()
    e_callBook = Expr(:call, :Book)
    e_makebook = Expr(:(=), name, e_callBook)

    e_setbook = Expr(:(=), e_wbook, name)

    e_target = Expr(:block, e_makebook, e_setbook)

    return e_target

end


################################################################
##  populate!
################################################################

function populate!(w::World, individuals...)

    for ind in individuals
        hash_ind = hash(ind)
        w.book[hash_ind] = ind
    end

    return nothing

end


################################################################
##  actualize
################################################################

function actualize(w::World)
    actuality[1] = w
    return nothing
end


################################################################
##  belongs
################################################################

function belongs(ind::Individual, kind::DataType)

    actual = actuality[1]

    for field in keys(actual.catalog[kind])
        haecc = symbol("$field")
        haecc_type = (actual.catalog[kind])[field]
        in(haecc, keys(ind)) || return false
        isa(ind[haecc], haecc_type) || return false
    end

    return true

end


################################################################
##  show
################################################################

function show(kind::DataType)

    actual = actuality[1]

    for ind in values(actual.book)
        belongs(ind, kind) && println(ind)
    end

end





include("/Users/David/.julia/v0.3/Kinds/src/sample.jl")


end # module
