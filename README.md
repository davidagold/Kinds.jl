# Kinds.jl

Kinds.jl aims to provide a Julia framework for working with non-relational data. A central objective is to support special user-defined types called *kinds* that allow the user to reason about data as she would reason naturally about the objects which the data describe. For instance, suppose one has height data for a number of people and wants to find the mean height of a subset of those observations, say the subset of people taller than 5.5". One could define a `People` type

```julia
@Natural People begin
    :height
end
```

which designates as "people" all observations that have a `:height` field. One then defines a related type

```julia
TallPeople = @KindOf People :height > 5.5
```

which designates as "tallpeople" all observations whose value for the field `:height` is greater than 5.5. One then calls

```julia
mean(height, TallPeople)
```

To find the mean height of the aforementioned subset of the data. 

For more details about this project, as well as periodic progress updates, please see the [outline at the Kinds.jl/wiki](https://github.com/davidagold/Kinds.jl/wiki).



[![Build Status](https://travis-ci.org/davidagold/Nierika.jl.svg?branch=master)](https://travis-ci.org/davidagold/Nierika.jl)
