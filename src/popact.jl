
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
