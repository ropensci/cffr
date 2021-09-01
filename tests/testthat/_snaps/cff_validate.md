# Snapshot for validating message

    Code
      err <- system.file("examples/CITATION_error.cff", package = "cffR")
      cff_validate(err)
    Message <simpleMessage>
      
      cff_validate results-----
      Oops! This CITATION.cff file has the following errors:
      
    Output
                  field                          message
      1            data        has additional properties
      2  data.authors.0                 no schemas match
      3        data.doi referenced schema does not match
      4 data.keywords.0                is the wrong type
      5    data.license referenced schema does not match
      6        data.url referenced schema does not match

