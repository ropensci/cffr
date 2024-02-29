# Test first von last

    Code
      unlist(res)
    Output
      family-names  given-names 
              "BB"         "AA" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      name 
      "AA" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
              "bb"         "AA" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      name 
      "aa" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "CC"          "AA"          "bb" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "EE"          "AA"    "bb CC dd" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "dd"       "AA bB"          "cc" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "dd"    "AA \\BBb"          "cc" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "DD"       "AA bb"          "cc" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
            "cc DD"          "AA"          "bb" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
              "CC"      "AA bb" 

# Testing with random names First von Last

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
      "La Fontaine"        "Jean"          "de" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
          family-names      given-names 
      "Hernandez Sanz"          "Diego" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names 
       "Miramontes" "Juan Manuel" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
             family-names         given-names 
      "Miramontes Garcia"       "Juan Manuel" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
            "Halen" "Juan Manuel"         "van" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
              family-names          given-names 
      "de la Cruz y Ochoa"              "Bosco" 

# Test von Last, First

    Code
      unlist(res)
    Output
       family-names   given-names name-particle 
               "CC"          "AA"          "bb" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "CC"          "aa"          "bb" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
               "EE"          "AA"    "bb CC dd" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
              "bb"         "AA" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      name 
      "BB" 

# Test von Last, First with brackets, etc

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
            "Armas"         "Ana"          "de" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
        "de Armas"        "Ana" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
            family-names        given-names 
      "de Armas, Aguero"              "Ana" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
            family-names        given-names 
      "de Armas, Aguero"        "Ana Maria" 

# Test von Last, Jr,  First

    Code
      unlist(res)
    Output
       family-names   given-names name-particle   name-suffix 
               "CC"          "AA"          "bb"          "XX" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
              "BB"         "AA" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
         name 
      "BB AA" 

# Test von Last, Jr,  First with masking

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names  name-suffix 
           "Davis"      "Sammy"         "Jr" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names   name-suffix 
       "Davis, and"       "Sammy" "Jr, another" 

# Rest of cases

    Code
      unlist(res)
    Output
                                  name 
      "David, and, Jr, another, Sammy" 

# tames da beast

    Code
      unlist(create_person_from_txt(x))
    Output
                       name 
      "jean de la fontaine" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
         "fontaine"        "Jean"       "de la" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
         "fontaine"     "Jean de"          "la" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
                       name 
      "jean de la fontaine" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
        "fontaine" "Jean de la" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
      family-names  given-names 
        "Fontaine" "Jean De La" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
                       name 
      "jean De la Fontaine" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
      "La Fontaine"        "Jean"          "de" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
                       name 
      "jean de la fontaine" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
         "fontaine"        "Jean"       "de la" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
          family-names      given-names 
      "De La Fontaine"           "Jean" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
         "Fontaine"        "Jean"       "De la" 

---

    Code
      unlist(create_person_from_txt(x))
    Output
       family-names   given-names name-particle 
      "La Fontaine"        "Jean"          "de" 

