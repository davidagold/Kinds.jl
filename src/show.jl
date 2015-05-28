################################################################
##  belongs
################################################################

function belongs(ind::Individual, kind::DataType)

    actual = actuality[1]

    if kind == NaturalKind
        return true
    elseif belongs(ind, super(kind))
        for field in keys(actual.catalog[kind])
            haecc = symbol("$field")
            haecc_type = (actual.catalog[kind])[field]
            in(haecc, keys(ind)) || return false
            isa(ind[haecc], haecc_type) || return false
        end
    else
        return false
    end

    return true

end

function oftaxum(ind::Individual, kind::DataType)

    natural = (kind.super).parameters[1]



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
