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

# as_cff.default

    Code
      as_cff(b)
    Output
      a: '1'

