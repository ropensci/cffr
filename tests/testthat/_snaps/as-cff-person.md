# as_cff_person converts one person

    Code
      as_cff_person(p)
    Output
      - family-names: person
        given-names: one

# as_cff_person converts multiple persons

    Code
      as_cff_person(p)
    Output
      - family-names: person
        given-names: one
      - family-names: human
        given-names: another
      - family-names: more
        given-names: and one

# as_cff_person converts BibTeX person strings

    Code
      as_cff_person(s)
    Output
      - family-names: Wright
        given-names: Frank Edwin
        name-suffix: III

---

    Code
      as_cff_person(s)
    Output
      - family-names: person
        given-names: A
      - name: another
      - family-names: one
        given-names: Another

# as_cff_person preserves masked BibTeX names

    Code
      as_cff_person(s)
    Output
      - name: Elephant
      - name: Castle

---

    Code
      as_cff_person(s)
    Output
      - name: Elephant and Castle

---

    Code
      as_cff_person(s)
    Output
      - name: Elephant and Castle
      - name: this
      - name: Ltd.

---

    Code
      as_cff_person(s)
    Output
      - name: Elephant and Castle
      - name: this AND Ltd.

# as_cff_person extracts metadata from person comments

    Code
      pp2
    Output
      - family-names: Doe
        given-names: John
        email: first_mail@gmail.com
        orcid: https://orcid.org/0000-0001-8457-4658
        website: https://www.google.com/
        address: Sweet Home Chicago

