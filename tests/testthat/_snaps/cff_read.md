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
      Error in `cff_read()`:
      ! 'abcde' does not exist.  Check the '.' directory

---

    Code
      cff_read(f)
    Condition
      Error in `guess_type_file()`:
      ! Don't recognize the file type of '/cloud/project/inst/schema/schema.json'. Use a specific function (e.g. `cffr:cff_read_description()`

# cff read bib

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

