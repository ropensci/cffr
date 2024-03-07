# as_bibentry default

    Code
      s <- as_bibentry(a = 1)
    Message
      x Can't convert to `bibentry()`: 
      i argument "bibtype" is missing, with no default
      ! Returning empty <bibentry>

# as_bibentry NULL

    Code
      toBibtex(a_bib)
    Output
      @Misc{basic,
        title = {basicdesc: A Basic Description},
        author = {Marc Basic},
        url = {https://basic.github.io/package},
        abstract = {A very basic description. Should parse without problems.},
        version = {0.1.6},
      }

# as_bibentry character

    Code
      as_bibentry("invented_package")
    Condition
      Error in `as_bibentry()`:
      ! Don't know how to extract a <bibentry> from "invented_package". If it is a package run `install.packages("invented_package")` first.

# as_bibentry cff

    Code
      end <- as_bibentry(a_cff, what = "references")
    Message
      ! In `x` didn't find anything with `what` = "references". Returning empty <bibentry>.

---

    Code
      toBibtex(as_bibentry(mod_ref))
    Output
      @Manual{bootstrapmetho:1997,
        title = {Bootstrap Methods and Their Applications},
        year = {1997},
        publisher = {Cambridge University Press (Madrid)},
        url = {http://statwww.epfl.ch/davison/BMA/},
        translator = {{Research Translators Ltd.}},
      }

