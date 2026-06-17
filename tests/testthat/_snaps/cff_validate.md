# Validate full CITATION.cff

    Code
      ok <- cff_validate(fcff)
    Output
      == Validating CFF ==============================================================
    Message
      v This <cff> object is valid.

# Validate error CITATION.cff

    Code
      tab <- cff_validate(ferr)
    Output
      == Validating CFF ==============================================================
    Message
      x Validation failed. This <cff> object has the following errors:
      * cff/: must NOT have additional properties
      * cff/authors/0: must NOT have additional properties
      * cff/authors/0/orcid: must match pattern "https://orcid\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
      * cff/authors/0/orcid: must match format "uri"
      * cff/authors/0: must have required property 'name'
      * cff/authors/0: must NOT have additional properties
      * cff/authors/0: must NOT have additional properties
      * cff/authors/0: must NOT have additional properties
      * cff/authors/0/orcid: must match pattern "https://orcid\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
      * cff/authors/0/orcid: must match format "uri"
      * cff/authors/0: must match a schema in anyOf
      * cff/doi: must match pattern "^10\.\d{4,9}(\.\d+)?/[A-Za-z0-9:/_;\-\.\(\)\[\]\\]+$"
      * cff/keywords/0: must be string
      * cff/license: must be equal to one of the allowed values
      * cff/license: must be array
      * cff/license: must match exactly one schema in oneOf
      * cff/url: must match pattern "^(https|http|ftp|sftp)://.+"
      * cff/url: must match format "uri"

---

    Code
      df[, snap_fields == "character"]
    Output
                       field
      1                 cff/
      2        cff/authors/0
      3  cff/authors/0/orcid
      4  cff/authors/0/orcid
      5        cff/authors/0
      6        cff/authors/0
      7        cff/authors/0
      8        cff/authors/0
      9  cff/authors/0/orcid
      10 cff/authors/0/orcid
      11       cff/authors/0
      12             cff/doi
      13      cff/keywords/0
      14         cff/license
      15         cff/license
      16         cff/license
      17             cff/url
      18             cff/url
                                                                                       message
      1                                                    must NOT have additional properties
      2                                                    must NOT have additional properties
      3  must match pattern "https://orcid\\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
      4                                                                must match format "uri"
      5                                                     must have required property 'name'
      6                                                    must NOT have additional properties
      7                                                    must NOT have additional properties
      8                                                    must NOT have additional properties
      9  must match pattern "https://orcid\\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
      10                                                               must match format "uri"
      11                                                          must match a schema in anyOf
      12 must match pattern "^10\\.\\d{4,9}(\\.\\d+)?/[A-Za-z0-9:/_;\\-\\.\\(\\)\\[\\]\\\\]+$"
      13                                                                        must be string
      14                                            must be equal to one of the allowed values
      15                                                                         must be array
      16                                                must match exactly one schema in oneOf
      17                                      must match pattern "^(https|http|ftp|sftp)://.+"
      18                                                               must match format "uri"
             instancePath                       schemaPath              keyword
      1                             #/additionalProperties additionalProperties
      2        /authors/0           #/additionalProperties additionalProperties
      3  /authors/0/orcid      #/definitions/orcid/pattern              pattern
      4  /authors/0/orcid       #/definitions/orcid/format               format
      5        /authors/0                       #/required             required
      6        /authors/0           #/additionalProperties additionalProperties
      7        /authors/0           #/additionalProperties additionalProperties
      8        /authors/0           #/additionalProperties additionalProperties
      9  /authors/0/orcid      #/definitions/orcid/pattern              pattern
      10 /authors/0/orcid       #/definitions/orcid/format               format
      11       /authors/0 #/properties/authors/items/anyOf                anyOf
      12             /doi        #/definitions/doi/pattern              pattern
      13      /keywords/0 #/properties/keywords/items/type                 type
      14         /license  #/definitions/license-enum/enum                 enum
      15         /license                   #/oneOf/1/type                 type
      16         /license                          #/oneOf                oneOf
      17             /url        #/definitions/url/pattern              pattern
      18             /url         #/definitions/url/format               format
                 dataPath
      1                  
      2        /authors/0
      3  /authors/0/orcid
      4  /authors/0/orcid
      5        /authors/0
      6        /authors/0
      7        /authors/0
      8        /authors/0
      9  /authors/0/orcid
      10 /authors/0/orcid
      11       /authors/0
      12             /doi
      13      /keywords/0
      14         /license
      15         /license
      16         /license
      17             /url
      18             /url

