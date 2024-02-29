# debugging messages

    Code
      a <- cff_create_cff_person(ap)
    Message
      i In `cff_create_cff_person()` using internal for "person".

---

    Code
      b <- cff_create_cff_person("Example")
    Message
      i In `cff_create_cff_person()` using internal for "txt".

# Parse one person

    Code
      cff_create_cff_person(p)
    Output
      - family-names: person
        given-names: one

# Parse several persons

    Code
      cff_create_cff_person(p)
    Output
      - family-names: person
        given-names: one
      - family-names: human
        given-names: another
      - family-names: more
        given-names: and one

# Parse bibtex persons

    Code
      cff_create_cff_person(s)
    Output
      - family-names: Wright
        given-names: Frank Edwin
        name-suffix: III

---

    Code
      cff_create_cff_person(s)
    Output
      - family-names: person
        given-names: A
      - name: another
      - family-names: one
        given-names: Another

# Parse bibtex persons with masks

    Code
      cff_create_cff_person(s)
    Output
      - name: Elephant
      - name: Castle

---

    Code
      cff_create_cff_person(s)
    Output
      - name: Elephant and Castle

---

    Code
      cff_create_cff_person(s)
    Output
      - name: Elephant and Castle
      - name: this
      - name: Ltd.

---

    Code
      cff_create_cff_person(s)
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

