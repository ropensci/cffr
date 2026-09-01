# as.cff remains compatible with as_cff

    Code
      l2
    Output
      cff-version: 1.2.0
      title: Manipulating files

# as_cff converts person objects

    Code
      as_cff(pers)
    Output
      - family-names: person
        given-names: A
        email: fake@gmail.com
        orcid: https://orcid.org/0000-0001-8457-4658
        affiliation: Real Madrid
        website: https://www.google.com/

---

    Code
      single_cff
    Output
      family-names: person
      given-names: A
      email: fake@gmail.com
      orcid: https://orcid.org/0000-0001-8457-4658
      affiliation: Real Madrid
      website: https://www.google.com/

# bibentries round-trip through as_cff and toBibtex

    Code
      bbb
    Output
      - type: generic
        title: title
        authors:
        - name: Author
        editors:
        - name: Editor

---

    Code
      b_single_cff
    Output
      type: generic
      title: title
      authors:
      - name: Author
      editors:
      - name: Editor

# Bibtex conversion removes its temporary file after errors

    Code
      as_cff(bib)
    Condition
      Error:
      ! Unable to parse temporary BibTeX

# as_cff converts named lists by default

    Code
      as_cff(b)
    Output
      a: '1'

# as_cff handles supported auxiliary input types

    Code
      noadd <- cff(chocolate = "New York", version = 5)
    Message
      i Found 1 unknown key. Trying to map it:
      x chocolate: No match, removing.

# as_cff reads complete cff structures

    Code
      df
    Output
                                    class
      authors            cff_pers_lst|cff
      contact            cff_pers_lst|cff
      identifiers         cff_ref_lst|cff
      references          cff_ref_lst|cff
      preferred-citation      cff_ref|cff

---

    Code
      df2
    Output
                                   class
      authors           cff_pers_lst|cff
      contact           cff_pers_lst|cff
      editors           cff_pers_lst|cff
      editors-series    cff_pers_lst|cff
      recipients        cff_pers_lst|cff
      senders           cff_pers_lst|cff
      translators       cff_pers_lst|cff
      conference            cff_pers|cff
      database-provider     cff_pers|cff
      institution           cff_pers|cff
      location              cff_pers|cff
      publisher             cff_pers|cff
      identifiers        cff_ref_lst|cff

