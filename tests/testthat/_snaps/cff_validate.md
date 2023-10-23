# Validate full CITATION.cff

    Code
      ok <- cff_validate(fcff)
    Output
      == Validating cff ==============================================================
    Message
      v Congratulations! This <cff> is valid

# Validate error CITATION.cff

    Code
      tab <- cff_validate(ferr)
    Output
      == Validating cff ==============================================================
    Message
      x Oops! This <cff> has the following errors:
      * cff: has additional properties
      * cff.authors.0: no schemas match
      * cff.doi: referenced schema does not match
      * cff.keywords.0: is the wrong type
      * cff.license: referenced schema does not match
      * cff.url: referenced schema does not match

---

    Code
      df
    Output
                 field                          message
      1            cff        has additional properties
      2  cff.authors.0                 no schemas match
      3        cff.doi referenced schema does not match
      4 cff.keywords.0                is the wrong type
      5    cff.license referenced schema does not match
      6        cff.url referenced schema does not match

