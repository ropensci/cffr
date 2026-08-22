# person parser handles First von Last names

    Code
      results
    Output
      $`AA BB`
      family-names  given-names 
              "BB"         "AA" 
      
      $AA
      name 
      "AA" 
      
      $`AA bb`
      family-names  given-names 
              "bb"         "AA" 
      
      $aa
      name 
      "aa" 
      
      $`AA bb CC`
       family-names   given-names name-particle 
               "CC"          "AA"          "bb" 
      
      $`AA bb CC dd EE`
       family-names   given-names name-particle 
               "EE"          "AA"    "bb CC dd" 
      
      $`AA {b}B cc dd`
       family-names   given-names name-particle 
               "dd"       "AA bB"          "cc" 
      
      $`AA \\BB{b} cc dd`
       family-names   given-names name-particle 
               "dd"    "AA \\BBb"          "cc" 
      
      $`AA {bb} cc DD`
       family-names   given-names name-particle 
               "DD"       "AA bb"          "cc" 
      
      $`AA bb {cc} DD`
       family-names   given-names name-particle 
            "cc DD"          "AA"          "bb" 
      
      $`AA {bb} CC`
      family-names  given-names 
              "CC"      "AA bb" 
      

# person parser handles varied First von Last names

    Code
      results
    Output
      $`Jean de La Fontaine`
       family-names   given-names name-particle 
      "La Fontaine"        "Jean"          "de" 
      
      $`Diego {Hernandez Sanz}`
          family-names      given-names 
      "Hernandez Sanz"          "Diego" 
      
      $`Juan Manuel Miramontes`
       family-names   given-names 
       "Miramontes" "Juan Manuel" 
      
      $`Juan Manuel {Miramontes Garcia}`
             family-names         given-names 
      "Miramontes Garcia"       "Juan Manuel" 
      
      $`Juan Manuel van Halen`
       family-names   given-names name-particle 
            "Halen" "Juan Manuel"         "van" 
      
      $`Bosco {de la Cruz y Ochoa}`
              family-names          given-names 
      "de la Cruz y Ochoa"              "Bosco" 
      

# person parser handles von Last, First names

    Code
      results
    Output
      $`bb CC, AA`
       family-names   given-names name-particle 
               "CC"          "AA"          "bb" 
      
      $`bb CC, aa`
       family-names   given-names name-particle 
               "CC"          "aa"          "bb" 
      
      $`bb CC dd EE, AA`
       family-names   given-names name-particle 
               "EE"          "AA"    "bb CC dd" 
      
      $`bb, AA`
      family-names  given-names 
              "bb"         "AA" 
      
      $`BB,`
      name 
      "BB" 
      

# person parser preserves masking in von Last, First names

    Code
      results
    Output
      $`de Armas, Ana`
       family-names   given-names name-particle 
            "Armas"         "Ana"          "de" 
      
      $`{de Armas}, Ana`
      family-names  given-names 
        "de Armas"        "Ana" 
      
      $`{de Armas, Aguero}, Ana`
            family-names        given-names 
      "de Armas, Aguero"              "Ana" 
      
      $`{de Armas, Aguero}, Ana Maria`
            family-names        given-names 
      "de Armas, Aguero"        "Ana Maria" 
      

# person parser handles von Last, Jr, First names

    Code
      results
    Output
      $`bb CC,XX, AA`
       family-names   given-names name-particle   name-suffix 
               "CC"          "AA"          "bb"          "XX" 
      
      $`BB,, AA`
      family-names  given-names 
              "BB"         "AA" 
      
      $`BB, AA,`
         name 
      "BB AA" 
      

# person parser preserves masking with suffixes

    Code
      results
    Output
      $`Davis, Jr, Sammy`
      family-names  given-names  name-suffix 
           "Davis"      "Sammy"         "Jr" 
      
      $`{Davis, and}, {Jr, another}, Sammy`
       family-names   given-names   name-suffix 
       "Davis, and"       "Sammy" "Jr, another" 
      

# person parser handles organizations and edge cases

    Code
      unlist(result)
    Output
                                  name 
      "David, and, Jr, another, Sammy" 

# person parser handles canonical BibTeX name examples

    Code
      results
    Output
      $`jean de la fontaine`
                       name 
      "jean de la fontaine" 
      
      $`Jean de la fontaine `
       family-names   given-names name-particle 
         "fontaine"        "Jean"       "de la" 
      
      $`Jean {de} la fontaine `
       family-names   given-names name-particle 
         "fontaine"     "Jean de"          "la" 
      
      $`jean {de} {la} fontaine `
                       name 
      "jean de la fontaine" 
      
      $`Jean {de} {la} fontaine `
      family-names  given-names 
        "fontaine" "Jean de la" 
      
      $`Jean De La Fontaine `
      family-names  given-names 
        "Fontaine" "Jean De La" 
      
      $`jean De la Fontaine `
                       name 
      "jean De la Fontaine" 
      
      $`Jean de La Fontaine `
       family-names   given-names name-particle 
      "La Fontaine"        "Jean"          "de" 
      
      $`jean de la fontaine,`
                       name 
      "jean de la fontaine" 
      
      $`de la fontaine, Jean `
       family-names   given-names name-particle 
         "fontaine"        "Jean"       "de la" 
      
      $`De La Fontaine, Jean`
          family-names      given-names 
      "De La Fontaine"           "Jean" 
      
      $`De la Fontaine, Jean`
       family-names   given-names name-particle 
         "Fontaine"        "Jean"       "De la" 
      
      $`de La Fontaine, Jean`
       family-names   given-names name-particle 
      "La Fontaine"        "Jean"          "de" 
      

