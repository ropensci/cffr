# Try not writing

    Code
      write_bib(bib)
    Output
      @Misc{,
        title = {My title},
        author = {Fran Pérez},
      }

---

    Code
      write_bib(bib, ascii = TRUE)
    Output
      @Misc{,
        title = {My title},
        author = {Fran P{\'e}rez},
      }

