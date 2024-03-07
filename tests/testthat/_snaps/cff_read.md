# Test errors on cff_read

    Code
      cff_read(c("abcde", "b"))
    Condition
      Error in `cff_read()`:
      ! Use a single value, `path` has length 2

---

    Code
      cff_read("abcde")
    Condition
      Error in `file_exist_abort()`:
      ! 'abcde' doesn't exist. Check the '.' directory

# cff_read citation.cff

    Code
      cff_read_cff_citation("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

# cff_read DESCRIPTION

    Code
      cff_read_description("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

# cff_read bib

    Code
      cff_read_bib("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

---

    Code
      d
    Output
      type: article
      title: 'cffr: Generate Citation File Format Metadata for R Packages'
      authors:
      - family-names: Hernangómez
        given-names: Diego
      year: '2021'
      journal: Journal of Open Source Software
      publisher:
        name: The Open Journal
      volume: '6'
      issue: '67'
      doi: 10.21105/joss.03900
      url: https://doi.org/10.21105/joss.03900
      copyright: All rights reserved
      notes: 'Publisher: The Open Journal'
      start: '3900'

# cff_read citation messages

    Code
      cff_read_citation("a")
    Condition
      Error in `file_exist_abort()`:
      ! 'a' doesn't exist. Check the '.' directory

---

    Code
      s <- cff_read(f, meta = "aa")
    Message
      ! `meta` should be "NULL" or a <packageDescription> object not a string. Using `meta = NULL`

