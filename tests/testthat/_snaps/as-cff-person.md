# Coerce one person

    Code
      as_cff_person(p)
    Output
      - family-names: person
        given-names: one

# Coerce several persons

    Code
      as_cff_person(p)
    Output
      - family-names: person
        given-names: one
      - family-names: human
        given-names: another
      - family-names: more
        given-names: and one

# Coerce bibtex persons

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

# Coerce bibtex persons with masks

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

# Can extract comments from format

    Code
      pp2
    Output
      - family-names: Doe
        given-names: John
        email: first_mail@gmail.com
        orcid: https://orcid.org/0000-0001-8457-4658
        website: https://www.google.com/
        address: Sweet Home Chicago

