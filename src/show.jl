
################################################################
##  condition
################################################################

function condition(ind, e::Expr)

    e_ref = Expr(:ref, :($ind))

    # Traverse the syntax tree of e
    if e.head != :quote
        return Expr(e.head, (isempty(e.args) ? e.args : map(x -> condition(ind, x), e.args))...)
    else
        push!(e_target.args, Expr(:(.), QuoteNode(e)))
        return e_ref
    end
end

condition(ind, e::QuoteNode) = Expr(:ref, :( $ind ), e)
condition(ind, e) = e

################################################################
##  belongs
################################################################

function belongs(ind::Individual, k::Kind)

    actual = actuality[1]

    if super(k) == nothing
        return true
    elseif belongs(ind, super(k))
        for field in keys(essence(k))
            in(field, keys(ind)) || return false
            isa(ind[field], essence(k)[field]) || return false
        end
    else
        return false
    end

    return true
end

function belongs(ind::Individual, t::Taxum)

    belongs(ind, kindof(t)) || return false

    for cond in character(t)
        e = condition(ind, cond)
        @eval($e) == true || return false
    end

    return true
end

################################################################
##  show
################################################################

function show(k::AbstractKind)

    actual = actuality[1]

    for ind in values(actual.book)
        belongs(ind, k) && println(ind)
    end
end
