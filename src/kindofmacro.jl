
################################################################
##  @KindOf
################################################################

function gen_decl(name, natkind)

    e_curly = :( Kind{$natkind} )
    e_subtype = Expr(:(<:), name, e_curly)
    e_target = Expr(:abstract, e_subtype)

    return e_target

end

function make_conds(a::Symbol, body)

    e_target = Expr(:(=), a)
    e_els = Expr(:vcat)

    if body.head == :block
        for e in body
            push!(e_els.args, Expr(:quote, e))
        end
    else
        push!(e_els.args, Expr(:quote, body))
    end

    push!(e_target.args, e_els)
    return e_target
end

function tell_taxonomy(aname::Symbol, kindname::Symbol)

    e_actuality = Expr(:(.), :Kinds, QuoteNode(:actuality))
    e_actual = Expr(:ref, e_actuality, 1)
    e_taxonomy = Expr(:(.), e_actual, QuoteNode(:taxonomy))

    e_taxonomy_ref = Expr(:ref, e_taxonomy, symbol("$kindname"))
    e_target = Expr(:(=), e_taxonomy_ref, aname)

    return e_target

end

macro KindOf(natkind, body)

    e_target = Expr(:block)

    kindname = gensym()
    a = gensym()
    # println(name)
    e_declare = gen_decl(kindname, natkind)

    push!(e_target.args, e_declare)
    push!(e_target.args, make_conds(a, body))
    push!(e_target.args, tell_taxonomy(a, kindname))
    push!(e_target.args, kindname)

    esc(e_target)

end
