# as.cff still works

    Code
      l2
    Output
      cff-version: 1.2.0
      title: Manipulating files

# as_cff.person

    Code
      as_cff(pers)
    Output
      - family-names: person
        given-names: A
        email: fake@gmail.com
        orcid: https://orcid.org/0000-0000-0000-0000
        affiliation: Real Madrid
        website: https://www.google.com/

---

    Code
      single_cff
    Output
      family-names: person
      given-names: A
      email: fake@gmail.com
      orcid: https://orcid.org/0000-0000-0000-0000
      affiliation: Real Madrid
      website: https://www.google.com/

# as_cff.bibentry, toBibtex

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

# as_cff.default

    Code
      as_cff(b)
    Output
      a: '1'

# Other convertes

    Code
      noadd <- cff(chocolate = "New York", version = 5)
    Message
      i Found misspelled keys. Trying to map:
      x chocolate: No match, removing.

# Reading full cff

    Code
      df
    Output
                                   class
      authors            cffperslist|cff
      contact            cffperslist|cff
      identifiers         cffreflist|cff
      references          cffreflist|cff
      preferred-citation      cffref|cff

---

    Code
      df2
    Output
                                  class
      authors           cffperslist|cff
      contact           cffperslist|cff
      editors           cffperslist|cff
      editors-series    cffperslist|cff
      recipients        cffperslist|cff
      senders           cffperslist|cff
      translators       cffperslist|cff
      conference            cffpers|cff
      database-provider     cffpers|cff
      institution           cffpers|cff
      location              cffpers|cff
      publisher             cffpers|cff
      identifiers        cffreflist|cff

