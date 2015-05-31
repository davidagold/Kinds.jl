################################################################
##  @Kind
################################################################

function make_essence(body)

    e_target = Expr(:(dict))

    # Push assignment expressions to arguments of e_dictkeys
    # each such assignment expression has head :(=>), first arg the field name,
    # second arg the type associated with the field name by the user in 'body'
    for arg in body.args
        if arg.head == :(::)
            _field = (arg).args[1]
            _type = (arg).args[2]
            e_key = Expr(:(=>), _field, _type)

            push!(e_target.args, e_key)
        elseif arg.head == :line
        else
            error("Please provide a type annotation for the field $arg")
        end
    end

    return e_target
end

macro Kind(naming, body)

    e_call = Expr(:(=))
    e_constructor = Expr(:call, :Kind)
    e_target = Expr(:block)

    if isa(naming, Symbol)
        push!(e_call.args, naming)
        push!(e_constructor.args, :nothing)
    elseif naming.head == :comparison && naming.args[2] == :(<)
        push!(e_call.args, naming.args[1])
        push!(e_constructor.args, naming.args[3])
    end

    push!(e_constructor.args, make_essence(body))
    push!(e_call.args, e_constructor)
    push!(e_target.args, e_call)

    esc(e_target)
end

################################################################
##  Auxiliary functinos for Kind
################################################################

super(k::Kind) = k.super

essence(k::Kind) = k.essence
