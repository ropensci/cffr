# Parse one person

    Code
      cff_parse_person(p)
    Output
      family-names: person
      given-names: one

# Parse several persons

    Code
      cff_parse_person(p)
    Output
      - family-names: person
        given-names: one
      - family-names: human
        given-names: another
      - family-names: more
        given-names: and one

# Parse bibtex persons

    Code
      cff_parse_person_bibtex(s)
    Output
      family-names: Wright
      given-names: Frank Edwin
      name-suffix: III

---

    Code
      cff_parse_person_bibtex(s)
    Output
      - family-names: person
        given-names: A
      - name: another
      - family-names: one
        given-names: Another

# Parse bibtex persons with masks

    Code
      cff_parse_person_bibtex(s)
    Output
      - name: Elephant
      - name: Castle

---

    Code
      cff_parse_person_bibtex(s)
    Output
      name: Elephant and Castle

---

    Code
      cff_parse_person_bibtex(s)
    Output
      - name: Elephant and Castle
      - name: this
      - name: Ltd.

---

    Code
      cff_parse_person_bibtex(s)
    Output
      - name: Elephant and Castle
      - name: this AND Ltd.

