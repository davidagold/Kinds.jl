
################################################################
##  @Taxum
################################################################



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

function pushconds!(args, body)

    if body.head == :block
        println(body)
        println(body.args)
        for cond in body.args
            # cond.head == :line || push!(args, cond)
        end
    else
        println( body )
        println(typeof(body))
        # push!(args, body)
    end

end

macro Taxum(naming, body)

    e_target = Expr(:(=))
    e_character = Expr(:ref, :Expr)
    e_constructor = Expr(:call, :Taxum)

    if naming.head == :comparison && naming.args[2] == :(<)
        push!(e_target.args, naming.args[1])
        push!(e_constructor.args, naming.args[3])
    else
        error("Error")
    end

    pushconds!(e_character.args, body)

    push!(e_constructor.args, e_character)
    push!(e_target.args, e_constructor)

    esc(e_target)

end
