# Inspect CFF schema values

Helper functions with valid values for different keys and definition
fields. See the following guide: [Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

- `cff_schema_keys()` provides the valid high-level keys of the Citation
  File Format.

- `cff_schema_keys_license()` provides valid [SPDX license
  identifier(s)](https://spdx.org/licenses/) to be used on the
  `CITATION.cff` file.

- `cff_schema_definitions_person()` and
  `cff_schema_definitions_entity()` return the valid fields to include
  when defining a person or entity.

- `cff_schema_definitions_refs()` provides the valid keys to use in the
  `preferred-citation` and `references` keys.

## Usage

``` r
cff_schema_keys(sorted = FALSE)

cff_schema_keys_license()

cff_schema_definitions_person()

cff_schema_definitions_entity()

cff_schema_definitions_refs()
```

## Source

[Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

## Arguments

- sorted:

  A logical value. If `TRUE`, arrange the keys alphabetically.

## Value

A character vector with the names of valid keys for Citation File Format
version 1.2.0.

## Examples

``` r
cff_schema_keys(sorted = TRUE)
#>  [1] "abstract"            "authors"             "cff-version"        
#>  [4] "commit"              "contact"             "date-released"      
#>  [7] "doi"                 "identifiers"         "keywords"           
#> [10] "license"             "license-url"         "message"            
#> [13] "preferred-citation"  "references"          "repository"         
#> [16] "repository-artifact" "repository-code"     "title"              
#> [19] "type"                "url"                 "version"            
# Valid license keys.
head(cff_schema_keys_license(), 20)
#>  [1] "0BSD"              "AAL"               "Abstyles"         
#>  [4] "Adobe-2006"        "Adobe-Glyph"       "ADSL"             
#>  [7] "AFL-1.1"           "AFL-1.2"           "AFL-2.0"          
#> [10] "AFL-2.1"           "AFL-3.0"           "Afmparse"         
#> [13] "AGPL-1.0-only"     "AGPL-1.0-or-later" "AGPL-3.0-only"    
#> [16] "AGPL-3.0-or-later" "Aladdin"           "AMDPLPA"          
#> [19] "AML"               "AMPAS"            
cff_schema_definitions_person()
#>  [1] "address"       "affiliation"   "alias"         "city"         
#>  [5] "country"       "email"         "family-names"  "fax"          
#>  [9] "given-names"   "name-particle" "name-suffix"   "orcid"        
#> [13] "post-code"     "region"        "tel"           "website"      
cff_schema_definitions_entity()
#>  [1] "address"    "alias"      "city"       "country"    "date-end"  
#>  [6] "date-start" "email"      "fax"        "location"   "name"      
#> [11] "orcid"      "post-code"  "region"     "tel"        "website"   
cff_schema_definitions_refs()
#>  [1] "abbreviation"        "abstract"            "authors"            
#>  [4] "collection-doi"      "collection-title"    "collection-type"    
#>  [7] "commit"              "conference"          "contact"            
#> [10] "copyright"           "data-type"           "database-provider"  
#> [13] "database"            "date-accessed"       "date-downloaded"    
#> [16] "date-published"      "date-released"       "department"         
#> [19] "doi"                 "edition"             "editors"            
#> [22] "editors-series"      "end"                 "entry"              
#> [25] "filename"            "format"              "identifiers"        
#> [28] "institution"         "isbn"                "issn"               
#> [31] "issue"               "issue-date"          "issue-title"        
#> [34] "journal"             "keywords"            "languages"          
#> [37] "license"             "license-url"         "loc-end"            
#> [40] "loc-start"           "location"            "medium"             
#> [43] "month"               "nihmsid"             "notes"              
#> [46] "number"              "number-volumes"      "pages"              
#> [49] "patent-states"       "pmcid"               "publisher"          
#> [52] "recipients"          "repository"          "repository-artifact"
#> [55] "repository-code"     "scope"               "section"            
#> [58] "senders"             "start"               "status"             
#> [61] "term"                "thesis-type"         "title"              
#> [64] "translators"         "type"                "url"                
#> [67] "version"             "volume"              "volume-title"       
#> [70] "year"                "year-original"      
```
