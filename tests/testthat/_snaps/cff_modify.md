# Errors and messages

    Code
      cff_modify(a_list, abstract = "An abstract")
    Condition
      Error in `cff_modify()`:
      ! `x` should be a <cff> object, not <list>.

---

    Code
      xend <- cff_modify(a_cff)
    Message
      i Arguments `...` are empty. Returning `x`.

---

    Code
      dup <- cff_modify(a_cff, abstract = "a", abstract = "b")
    Message
      ! Removing duplicate keys.

---

    Code
      cff_modify(a_cff, "a", "b")
    Condition
      Error in `validate_extra_keys()`:
      ! Elements in `...` should be named.

---

    Code
      mod <- cff_modify(a_cff, "a", abstract = "b")
    Message
      ! Found 1 unnamed argument in position 1.
      i Removing unnamed arguments.

