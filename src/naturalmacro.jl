################################################################
##  @Natural
################################################################

function make_essence(d::Symbol, body)

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


function tell_catalog(dname::Symbol, kindname::Symbol)

    e_actuality = Expr(:(.), :Kinds, QuoteNode(:actuality))
    e_actual = Expr(:ref, e_actuality, 1)
    e_catalog = Expr(:(.), e_actual, QuoteNode(:catalog))

    e_catalog_ref = Expr(:ref, e_catalog, symbol("$kindname"))
    e_target = Expr(:(=), e_catalog_ref, dname)

    return e_target

end


macro Natural(naming, body)

    e_target = Expr(:block)
    e_declare = Expr(:abstract)
    dname = gensym()

    if isa(naming, Symbol)
        kindname = naming
        push!(e_declare.args, Expr(:(<:), naming, symbol("NaturalKind")))
    else
        kindname = symbol( "$(naming.args[1])" )
        push!(e_declare.args, Expr(:(<:), kindname, naming.args[3]))
    end

    push!(e_target.args, e_declare)
    push!(e_target.args, make_essence(dname, body))
    push!(e_target.args, tell_catalog(dname, kindname))

    esc(e_target)

end
