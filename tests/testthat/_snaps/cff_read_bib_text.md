# Errors and messages

    Code
      cff_read_bib_text(a_cff)
    Condition
      Error in `cff_read_bib_text()`:
      ! `x` should be a <character>, not a <cff>.

---

    Code
      cff_read_bib_text("a bad line")
    Message
      ! `x` doesn't look as a BibTeX entry. Check the results.
    Condition
      Error:
      ! Invalid bib file

# Read lines

    Code
      list
    Output
      - type: book
        title: 'Relativity: The Special and the General Theory'
        authors:
        - family-names: Einstein
          given-names: Albert
        year: '1920'
        publisher:
          name: Henry Holt and Company
          address: London, United Kingdom
        isbn: '9781587340925'
      - type: generic
        title: Handing out random pamphlets in airports
        authors:
        - family-names: Missilany
          given-names: Joe-Bob
        year: '1984'
        month: '10'
        notes: This is a full MISC entry
        medium: Handed out at O'Hare

---

    Code
      fromfile <- cff_read_bib_text(tmpbib)
    Message
      ! `x` seems to be a ".bib" file, not a BibTeX entry.
      i Reading `x` with `cffr:cff_read_bib()`

