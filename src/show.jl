################################################################
##  @cond
################################################################

function replace_syms(ind, e::Expr)
    # e_target is the Expr that is built to replace ":(:(field))"

    # e_worldbook = Expr(:ref, Expr(:(.), :actual, QuoteNode(:book)), indhash)
    e_target = Expr(:ref, :( $ind ))

    # Traverse the syntax tree of e
    if e.head != :quote
        return Expr(e.head, (isempty(e.args) ? e.args : map(x -> replace_syms(x), e.args))...)
    else
        push!(e_target.args, e)
        return e_target
    end
end

replace_syms(ind, e::QuoteNode) = Expr(:ref, e.value)
replace_syms(ind, e) = e

macro cond(ind, e)
    esc(replace_syms(ind, e))
end

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

function belongs(ind::Individual, taxum::Taxum)

    belongs(ind, K) ||return false

    for cond in taxum.character
        belongs(ind, cond) || return false
    end

    return true
end

belongs(ind, cond::Expr) = @cond(ind, cond) ? true : false


################################################################
##  show
################################################################

function show(k::Kind)

    actual = actuality[1]

    for ind in values(actual.book)
        belongs(ind, k) && println(ind)
    end

end
