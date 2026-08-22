# cff_modify rejects objects that are not cff

    Code
      cff_modify(a_list, abstract = "An abstract")
    Condition
      Error in `cff_modify()`:
      ! `x` must be a <cff> object, not a list.

# cff_modify returns unchanged cff when no fields are supplied

    Code
      xend <- cff_modify(a_cff)
    Message
      i No `...` arguments supplied. Returning `x`.

# cff_modify keeps the first duplicate named field

    Code
      dup <- cff_modify(a_cff, abstract = "a", abstract = "b")
    Message
      ! Removing duplicate keys.

# cff_modify rejects multiple unnamed fields

    Code
      cff_modify(a_cff, "a", "b")
    Condition
      Error in `cff_modify()`:
      ! Elements in `...` must be named.

# cff_modify discards unnamed fields

    Code
      mod <- cff_modify(a_cff, "a", abstract = "b")
    Message
      ! Found 1 unnamed argument in position 1.
      i Removing unnamed arguments.

