# Errors and messages

    Code
      cff_modify(a_list, abstract = "An abstract")
    Condition
      Error in `cff_modify()`:
      ! `x` must be a <cff> object, not <list>.

---

    Code
      xend <- cff_modify(a_cff)
    Message
      i No `...` arguments supplied. Returning `x`.

---

    Code
      dup <- cff_modify(a_cff, abstract = "a", abstract = "b")
    Message
      ! Removing 1 duplicate key.

---

    Code
      cff_modify(a_cff, "a", "b")
    Condition
      Error in `validate_extra_keys()`:
      ! Elements in `...` must be named.

---

    Code
      mod <- cff_modify(a_cff, "a", abstract = "b")
    Message
      ! Found 1 unnamed argument in position 1.
      i Removing 1 unnamed argument.

# Cleanup messages are pluralized

    Code
      cff_modify(a_cff, abstract = "a", abstract = "b")
    Message
      ! Removing 1 duplicate key.
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      abstract: a

---

    Code
      cff_modify(a_cff, abstract = "a", abstract = "b", abstract = "c")
    Message
      ! Removing 2 duplicate keys.
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      abstract: a

---

    Code
      cff_modify(a_cff, "a", abstract = "b")
    Message
      ! Found 1 unnamed argument in position 1.
      i Removing 1 unnamed argument.
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      abstract: b

---

    Code
      cff_modify(a_cff, "a", "b", abstract = "c")
    Message
      ! Found 2 unnamed arguments in positions 1 and 2.
      i Removing 2 unnamed arguments.
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it using these metadata.
      title: My Research Software
      authors:
      - family-names: Doe
        given-names: John
      abstract: c

