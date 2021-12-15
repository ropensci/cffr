# Test first von last

     given family 
      "AA"   "BB" 

---

    family 
      "AA" 

---

     given family 
      "AA"   "bb" 

---

    family 
      "aa" 

---

     given    von family 
      "AA"   "bb"   "CC" 

---

         given        von     family 
          "AA" "bb CC dd"       "EE" 

---

      given     von  family 
    "AA bB"    "cc"    "dd" 

---

         given        von     family 
    "AA \\BBb"       "cc"       "dd" 

---

      given     von  family 
    "AA bb"    "cc"    "DD" 

---

      given     von  family 
       "AA"    "bb" "cc DD" 

---

      given  family 
    "AA bb"    "CC" 

# Testing with random names First von Last

            given           von        family 
           "Jean"          "de" "La Fontaine" 

---

               given           family 
             "Diego" "Hernandez Sanz" 

---

            given        family 
    "Juan Manuel"  "Miramontes" 

---

                  given              family 
          "Juan Manuel" "Miramontes Garcia" 

---

            given           von        family 
    "Juan Manuel"         "van"       "Halen" 

---

                   given               family 
                 "Bosco" "de la Cruz y Ochoa" 

# Test von Last, First

     given    von family 
      "AA"   "bb"   "CC" 

---

     given    von family 
      "aa"   "bb"   "CC" 

---

         given        von     family 
          "AA" "bb CC dd"       "EE" 

---

     given family 
      "AA"   "bb" 

---

    family 
      "BB" 

# Test von Last, First with brackets, etc

      given     von  family 
      "Ana"    "de" "Armas" 

---

         given     family 
         "Ana" "de Armas" 

---

                 given             family 
                 "Ana" "de Armas, Aguero" 

---

                 given             family 
           "Ana Maria" "de Armas, Aguero" 

# Test von Last, Jr,  First

     given    von family     jr 
      "AA"   "bb"   "CC"   "XX" 

---

     given family 
      "AA"   "BB" 

---

    family     jr 
      "BB"   "AA" 

# Test von Last, Jr,  First with masking

      given  family      jr 
    "Sammy" "Davis"    "Jr" 

---

            given        family            jr 
          "Sammy"  "Davis, and" "Jr, another" 

# Rest of cases

                              family 
    "David, and, Jr, another, Sammy" 

# tames da beast

             von       family 
    "jean de la"   "fontaine" 

---

         given        von     family 
        "Jean"    "de la" "fontaine" 

---

         given        von     family 
     "Jean de"       "la" "fontaine" 

---

                 von           family 
              "jean" "de la fontaine" 

---

           given       family 
    "Jean de la"   "fontaine" 

---

           given       family 
    "Jean De La"   "Fontaine" 

---

             von       family 
    "jean De la"   "Fontaine" 

---

            given           von        family 
           "Jean"          "de" "La Fontaine" 

---

             von       family 
    "jean de la"   "fontaine" 

---

         given        von     family 
        "Jean"    "de la" "fontaine" 

---

               given           family 
              "Jean" "De La Fontaine" 

---

         given        von     family 
        "Jean"    "De la" "Fontaine" 

---

            given           von        family 
           "Jean"          "de" "La Fontaine" 

