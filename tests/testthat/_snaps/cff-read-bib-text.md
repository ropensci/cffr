# cff_read_bib_text validates malformed input

    Code
      cff_read_bib_text(a_cff)
    Condition
      Error in `cff_read_bib_text()`:
      ! `x` must be a character vector, not a <cff> object.

---

    Code
      cff_read_bib_text("a bad line")
    Message
      ! `x` does not look like a BibTeX entry. Check the results.
    Condition
      Error:
      ! Invalid bib file

# cff_read_bib_text rejects file paths mixed with entries

    Code
      cff_read_bib_text(c("first.bib", "@misc{second, title={Second}}"))
    Condition
      Error in `cff_read_bib_text()`:
      ! `x` must contain BibTeX entries or one `*.bib` file path.
      x Found 1 file-like value at position 1.
      i Read each file separately with `cffr::cff_read_bib()`.

---

    Code
      cff_read_bib_text(c("first.bib", "second.bib"))
    Condition
      Error in `cff_read_bib_text()`:
      ! `x` must contain BibTeX entries or one `*.bib` file path.
      x Found 2 file-like values at positions 1 and 2.
      i Read each file separately with `cffr::cff_read_bib()`.

# cff_read_bib_text reads entries and bib files

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
      ! `x` seems to be a `*.bib` file, not a BibTeX entry.
      i Reading `x` with `cffr::cff_read_bib()`.

