# as_bibentry converts supported objects by default

    Code
      s <- as_bibentry(a = 1)
    Message
      x Cannot convert `x` to a <bibentry> with `utils::bibentry()`.
      i argument "bibtype" is missing, with no default
      ! Returning an empty <bibentry>.

# as_bibentry returns an empty bibentry for NULL

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

# as_bibentry reads packages and files from character input

    Code
      as_bibentry("invented_package")
    Condition
      Error in `as_bibentry()`:
      ! Cannot extract a <bibentry> from "invented_package".
      i If "invented_package" is a package, run `install.packages("invented_package")` first.

# as_bibentry extracts references from cff objects

    Code
      end <- as_bibentry(a_cff, what = "references")
    Message
      ! No entries in `x` matched `what` = "references". Returning an empty <bibentry>.

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

