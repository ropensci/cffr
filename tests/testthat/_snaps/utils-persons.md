# Test first von last

    Code
      unlist(res)
    Output
       given family 
        "AA"   "BB" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
      family 
        "AA" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
       given family 
        "AA"   "bb" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
      family 
        "aa" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
       given    von family 
        "AA"   "bb"   "CC" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
            "AA" "bb CC dd"       "EE" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
        given     von  family 
      "AA bB"    "cc"    "dd" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
      "AA \\BBb"       "cc"       "dd" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
        given     von  family 
      "AA bb"    "cc"    "DD" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
        given     von  family 
         "AA"    "bb" "cc DD" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
        given  family 
      "AA bb"    "CC" 

# Testing with random names First von Last

    Code
      unlist(as_person_bibtex(x))
    Output
              given           von        family 
             "Jean"          "de" "La Fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                 given           family 
               "Diego" "Hernandez Sanz" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
              given        family 
      "Juan Manuel"  "Miramontes" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                    given              family 
            "Juan Manuel" "Miramontes Garcia" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
              given           von        family 
      "Juan Manuel"         "van"       "Halen" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                     given               family 
                   "Bosco" "de la Cruz y Ochoa" 

# Test von Last, First

    Code
      unlist(res)
    Output
       given    von family 
        "AA"   "bb"   "CC" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
       given    von family 
        "aa"   "bb"   "CC" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
            "AA" "bb CC dd"       "EE" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
       given family 
        "AA"   "bb" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
      family 
        "BB" 

# Test von Last, First with brackets, etc

    Code
      unlist(as_person_bibtex(x))
    Output
        given     von  family 
        "Ana"    "de" "Armas" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given     family 
           "Ana" "de Armas" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                   given             family 
                   "Ana" "de Armas, Aguero" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                   given             family 
             "Ana Maria" "de Armas, Aguero" 

# Test von Last, Jr,  First

    Code
      unlist(res)
    Output
       given    von family     jr 
        "AA"   "bb"   "CC"   "XX" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
       given family 
        "AA"   "BB" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
      family     jr 
        "BB"   "AA" 

# Test von Last, Jr,  First with masking

    Code
      unlist(as_person_bibtex(x))
    Output
        given  family      jr 
      "Sammy" "Davis"    "Jr" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
              given        family            jr 
            "Sammy"  "Davis, and" "Jr, another" 

# Rest of cases

    Code
      unlist(res)
    Output
                                family 
      "David, and, Jr, another, Sammy" 

# tames da beast

    Code
      unlist(as_person_bibtex(x))
    Output
               von       family 
      "jean de la"   "fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
          "Jean"    "de la" "fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
       "Jean de"       "la" "fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                   von           family 
                "jean" "de la fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
             given       family 
      "Jean de la"   "fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
             given       family 
      "Jean De La"   "Fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
               von       family 
      "jean De la"   "Fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
              given           von        family 
             "Jean"          "de" "La Fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
               von       family 
      "jean de la"   "fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
          "Jean"    "de la" "fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
                 given           family 
                "Jean" "De La Fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
           given        von     family 
          "Jean"    "De la" "Fontaine" 

---

    Code
      unlist(as_person_bibtex(x))
    Output
              given           von        family 
             "Jean"          "de" "La Fontaine" 

