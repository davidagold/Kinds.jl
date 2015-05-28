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
