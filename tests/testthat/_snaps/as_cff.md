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
      authors            cff_pers_list|cff|list
      contact            cff_pers_list|cff|list
      identifiers         cff_ref_list|cff|list
      references          cff_ref_list|cff|list
      preferred-citation       cff_ref|cff|list

---

    Code
      df2
    Output
                                         class
      authors           cff_pers_list|cff|list
      contact           cff_pers_list|cff|list
      editors           cff_pers_list|cff|list
      editors-series    cff_pers_list|cff|list
      recipients        cff_pers_list|cff|list
      senders           cff_pers_list|cff|list
      translators       cff_pers_list|cff|list
      conference             cff_pers|cff|list
      database-provider      cff_pers|cff|list
      institution            cff_pers|cff|list
      location               cff_pers|cff|list
      publisher              cff_pers|cff|list
      identifiers        cff_ref_list|cff|list

