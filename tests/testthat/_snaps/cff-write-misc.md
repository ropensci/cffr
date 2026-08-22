# cff_write_bib rejects non-bibentry inputs

    Code
      cff_write_bib(1:4)
    Condition
      Error in `cff_write_bib()`:
      ! `x` must be a <bibentry> object, not an integer vector.

# cff_write_citation rejects non-bibentry inputs

    Code
      cff_write_citation(1:4)
    Condition
      Error in `cff_write_citation()`:
      ! `x` must be a <bibentry> object, not an integer vector.

