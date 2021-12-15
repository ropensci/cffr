# Parse one person

    family-names: person
    given-names: one

# Parse several persons

    - family-names: person
      given-names: one
    - family-names: human
      given-names: another
    - family-names: more
      given-names: and one

# Parse bibtex persons

    family-names: Wright
    given-names: Frank Edwin
    name-suffix: III

---

    - family-names: person
      given-names: A
    - name: another
    - family-names: one
      given-names: Another

# Parse bibtex persons with masks

    - name: Elephant
    - name: Castle

---

    name: Elephant and Castle

---

    - name: Elephant and Castle
    - name: this
    - name: Ltd.

---

    - name: Elephant and Castle
    - name: this AND Ltd.

