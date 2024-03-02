# cff_extract_to_bibtex

    Code
      old1 <- cff_extract_to_bibtex(a_cff)
    Condition
      Warning:
      `cff_extract_to_bibtex()` was deprecated in cffr 0.5.0.
      i Function renamed, use `as_bibentry()` instead.

# cff_to_bibtex

    Code
      old1 <- cff_to_bibtex(a_cff)
    Condition
      Warning:
      `cff_extract_to_bibtex()` was deprecated in cffr 1.0.0.
      i Function renamed, use `as_bibentry()` instead.

# cff_from_bibtex

    Code
      ffile <- cff_from_bibtex(x2)
    Condition
      Warning:
      `cff_from_bibtex()` was deprecated in cffr 1.0.0.
      i Please use `cff_read_bib()` instead.

---

    Code
      flines <- cff_from_bibtex(x)
    Condition
      Warning:
      `cff_from_bibtex()` was deprecated in cffr 1.0.0.
      i Please use `cff_read_bib_text()` instead.

# write_bib

    Code
      write_bib(bib, tmp, verbose = FALSE)
    Condition
      Warning:
      `write_bib()` was deprecated in cffr 1.0.0.
      i Please use `cff_write_bib()` instead.

---

    Code
      cat(readLines(tmp), sep = "\n")
    Output
      @Misc{,
        title = {My title},
        author = {Fran Pérez},
      }

# write_citation

    Code
      write_citation(bib, tmp, verbose = FALSE)
    Condition
      Warning:
      `write_citation()` was deprecated in cffr 1.0.0.
      i Please use `cff_write_citation()` instead.

---

    Code
      cat(readLines(tmp), sep = "\n")
    Output
      
      bibentry(bibtype = "Misc",
               title = "My title",
               author = person(given = "Fran",
                               family = "Pérez"))

# cff_parse_person

    Code
      pend <- cff_parse_person(p)
    Condition
      Warning:
      `cff_parse_person()` was deprecated in cffr 1.0.0.
      i Please use `as_cff_person()` instead.

# cff_parse_person_bibtex

    Code
      pend <- cff_parse_person_bibtex(p)
    Condition
      Warning:
      `cff_parse_person_bibtex()` was deprecated in cffr 1.0.0.
      i Please use `as_cff_person()` instead.

# cff_parse_citation

    Code
      pend <- cff_parse_citation(p)
    Condition
      Warning:
      `cff_parse_citation()` was deprecated in cffr 1.0.0.
      i Please use `as_cff.bibentry()` instead.

