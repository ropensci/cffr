# Test ALL installed packages

    
    
    ## Sessioninfo 
    
    R version 4.1.1 (2021-08-10)
    Platform: x86_64-w64-mingw32/x64 (64-bit)
    Running under: Windows 10 x64 (build 19043)
    
    Matrix products: default
    
    locale:
    [1] LC_COLLATE=C                   LC_CTYPE=Spanish_Spain.1252   
    [3] LC_MONETARY=Spanish_Spain.1252 LC_NUMERIC=C                  
    [5] LC_TIME=Spanish_Spain.1252    
    
    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     
    
    other attached packages:
    [1] cffr_0.0.0.9000 testthat_3.0.4 
    
    loaded via a namespace (and not attached):
     [1] Rcpp_1.0.7         rstudioapi_0.13    magrittr_2.0.1     usethis_2.0.1     
     [5] devtools_2.4.2     pkgload_1.2.2      jsonvalidate_1.1.0 R6_2.5.1          
     [9] rlang_0.4.11       fastmap_1.1.0      tools_4.1.1        pkgbuild_1.2.0    
    [13] sessioninfo_1.1.1  cli_3.0.1          withr_2.4.2        ellipsis_0.3.2    
    [17] remotes_2.4.0      yaml_2.2.1         rprojroot_2.0.2    lifecycle_1.0.0   
    [21] crayon_1.4.1       processx_3.5.2     purrr_0.3.4        callr_3.7.0       
    [25] fs_1.5.0           ps_1.6.0           curl_4.3.2         memoise_2.0.0     
    [29] glue_1.4.2         cachem_1.0.6       V8_3.4.2           compiler_4.1.1    
    [33] desc_1.3.0         prettyunits_1.1.1  jsonlite_1.7.2    
    
    ---

---

    
    
    ## Summary 
    
    [1] "testing a sample of 1930 installed packages"
    
    ---

---

    
    
    ## Errors 
    
                              Package Version with_citation is_ok
    InformationValue InformationValue   1.2.3         FALSE FALSE
    iheatmapr               iheatmapr   0.5.1          TRUE FALSE
    outcomerate           outcomerate   1.0.1          TRUE FALSE
    psychotree             psychotree  0.15-4          TRUE FALSE
    rromeo                     rromeo   0.1.1          TRUE FALSE
    
    ---
    
    ## Error reports for  
    
    [1] "InformationValue, iheatmapr, outcomerate, psychotree, rromeo"
    
    ---
    
    ## InformationValue: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "InformationValue" in publications use:'
    type: software
    license: GPL-2.0-or-later
    title: 'InformationValue: Performance Analysis and Companion Functions for Binary
      Classification Models'
    version: 1.2.3
    abstract: Provides companion function for analysing the performance of classification
      models. Also, provides function to optimise probability cut- off score based on
      used specified objectives, Plot 'ROC' Curve in 'ggplot2', 'AUROC', 'IV', 'WOE' Calculation,
      'KS Statistic' etc to aid accuracy improvement in binary classification models.
    authors:
    - family-names: Prabhakaran
      given-names: Selva
      email: selva86@gmail.com
    repository-code: 'https://github.com/selva86/InformationValue/issues License: GPL
      (>= 2)'
    url: http://r-statistics.co/Information-Value-With-R.html
    date-released: '2016-10-29'
    contact:
    - family-names: Prabhakaran
      given-names: Selva
      email: selva86@gmail.com
    
    ---
    
    ## Validation results 
    
                        field                          message
    1 data["repository-code"] referenced schema does not match
    [1] FALSE
    
    ---
    
    ## iheatmapr: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "iheatmapr" in publications use:'
    type: software
    license: MIT
    title: 'iheatmapr: Interactive, Complex Heatmaps'
    version: 0.5.1
    doi: 10.21105/joss.00359
    abstract: Make complex, interactive heatmaps. 'iheatmapr' includes a modular system
      for iteratively building up complex heatmaps, as well as the iheatmap() function
      for making relatively standard heatmaps.
    authors:
    - family-names: Schep
      given-names: Alicia
      email: aschep@gmail.com
      orcid: https://orcid.org/orcid.org/0000-0002-3915-0618
    - family-names: Kummerfeld
      given-names: Sarah
      email: kummerfeld.sarah@gene.com
      orcid: https://orcid.org/orcid.org/0000-0002-0089-2358
    preferred-citation:
      type: article
      title: 'iheatmapr: Interactive complex heatmaps in R'
      authors:
      - family-names: Schep
        given-names: Alicia N
      - family-names: Kummerfeld
        given-names: Sarah K
      year: '2017'
      journal: Journal of Open Source Software
      url: http://dx.doi.org/10.21105/joss.00359
      doi: 10.21105/joss.00359
    repository-code: https://github.com/ropensci/iheatmapr
    url: https://docs.ropensci.org/iheatmapr
    date-released: '2020-10-14'
    contact:
    - family-names: Schep
      given-names: Alicia
      email: aschep@gmail.com
      orcid: https://orcid.org/orcid.org/0000-0002-3915-0618
    keywords:
    - heatmap
    - plotly
    - r
    - interactive-visualizations
    - data-visualization
    - htmlwidgets
    
    ---
    
    ## Validation results 
    
               field          message
    1 data.authors.0 no schemas match
    2 data.authors.1 no schemas match
    3 data.contact.0 no schemas match
    [1] FALSE
    
    ---
    
    ## outcomerate: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "outcomerate" in publications use:'
    type: software
    license: CC0-1.0
    title: 'outcomerate: AAPOR Survey Outcome Rates'
    version: 1.0.1
    abstract: 'Standardized survey outcome rate functions, including the response rate,
      contact rate, cooperation rate, and refusal rate. These outcome rates allow survey
      researchers to measure the quality of survey data using definitions published by
      the American Association of Public Opinion Research (AAPOR). For details on these
      standards, see AAPOR (2016) <https://www.aapor.org/Standards-Ethics/Standard-Definitions-(1).aspx>. '
    authors:
    - family-names: Pilliard Hellwig
      given-names: Rafael
      email: rafael.taph@gmail.com
      orcid: https://orcid.org/0000-0002-3092-3493
    preferred-citation:
      type: manual
      title: 'Standard Definitions: Final Dispositions of Case Codes and Outcome Rates
        for Surveys'
      year: '2016'
      url: https://www.aapor.org/Standards-Ethics/Standard-Definitions-(1).aspx
    repository-code: https://github.com/ropensci/outcomerate
    url: https://github.com/ropensci/outcomerate
    date-released: '2018-10-06'
    contact:
    - family-names: Pilliard Hellwig
      given-names: Rafael
      email: rafael.taph@gmail.com
      orcid: https://orcid.org/0000-0002-3092-3493
    references:
    - type: generic
      title: 'outcomerate: AAPOR Survey Outcome Rates (R package)'
      authors:
      - family-names: Hellwig
        given-names: Rafael Pilliard
      year: '2018'
      url: https://github.com/ropensci/outcomerate
    
    ---
    
    ## Validation results 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---
    
    ## psychotree: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "psychotree" in publications use:'
    type: software
    license:
    - GPL-2.0-only
    - GPL-3.0-only
    title: 'psychotree: Recursive Partitioning Based on Psychometric Models'
    version: 0.15-4
    doi: 10.3102/1076998609359791
    abstract: Recursive partitioning based on psychometric models, employing the general
      MOB algorithm (from package partykit) to obtain Bradley-Terry trees, Rasch trees,
      rating scale and partial credit trees, and MPT trees.
    authors:
    - family-names: Zeileis
      given-names: Achim
      email: Achim.Zeileis@R-project.org
      orcid: https://orcid.org/0000-0003-0918-3766
    - family-names: Strobl
      given-names: Carolin
      email: Carolin.Strobl@psychologie.uzh.ch
    - family-names: Wickelmaier
      given-names: Florian
    - family-names: Komboz
      given-names: Basil
    - family-names: Kopf
      given-names: Julia
    preferred-citation:
      type: article
      title: Accounting for Individual Differences in Bradley-Terry Models by Means of
        Recursive Partitioning
      authors:
      - family-names: Strobl
        given-names: Carolin
      - family-names: Wickelmaier
        given-names: Florian
      - family-names: Zeileis
        given-names: Achim
        email: Achim.Zeileis@R-project.org
        orcid: https://orcid.org/0000-0003-0918-3766
      journal: Journal of Educational and Behavioral Statistics
      year: '2011'
      volume: '36'
      number: '2'
      doi: 10.3102/1076998609359791
    date-released: '2021-05-21'
    contact:
    - family-names: Zeileis
      given-names: Achim
      email: Achim.Zeileis@R-project.org
      orcid: https://orcid.org/0000-0003-0918-3766
    references:
    - type: article
      title: 'Rasch Trees: A New Method for Detecting Differential Item Functioning in
        the Rasch Model'
      authors:
      - family-names: Strobl
        given-names: Carolin
      - family-names: Kopf
        given-names: Julia
      - family-names: Zeileis
        given-names: Achim
        email: Achim.Zeileis@R-project.org
        orcid: https://orcid.org/0000-0003-0918-3766
      journal: Psychometrika
      year: '2015'
      volume: '80'
      number: '2'
      doi: 10.1007/s11336-013-9388-3
    - type: article
      title: Tree-Based Global Model Tests for Polytomous Rasch Models
      authors:
      - family-names: Komboz
        given-names: Basil
      - family-names: Zeileis
        given-names: Achim
        email: Achim.Zeileis@R-project.org
        orcid: https://orcid.org/0000-0003-0918-3766
      - family-names: Strobl
        given-names: Carolin
      journal: Educational and Psychological Measurement
      year: '2018'
      volume: '78'
      number: '1'
      doi: 10.1177/0013164416664394
    - type: article
      title: Using Recursive Partitioning to Account for Parameter Heterogeneity in Multinomial
        Processing Tree Models
      authors:
      - family-names: Wickelmaier
        given-names: Florian
      - family-names: Zeileis
        given-names: Achim
        email: Achim.Zeileis@R-project.org
        orcid: https://orcid.org/0000-0003-0918-3766
      journal: Behavior Research Methods
      year: '2018'
      volume: '50'
      number: '3'
      doi: 10.3758/s13428-017-0937-z
    - type: book
      title: Allgemeinbildung in Deutschland -- Erkenntnisse aus dem SPIEGEL Studentenpisa-Test
      year: '2010'
      publisher:
        name: VS Verlag
    
    ---
    
    ## Validation results 
    
                  field                          message
    1 data.references.3 referenced schema does not match
    [1] FALSE
    
    ---
    
    ## rromeo: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "rromeo" in publications use:'
    type: software
    license: GPL-3.0-only
    title: 'rromeo: Access Publisher Copyright & Self-Archiving Policies via the ''SHERPA/RoMEO''
      API'
    version: 0.1.1
    abstract: Fetches information from the 'SHERPA/RoMEO' API <http://www.sherpa.ac.uk/romeo/apimanual.php>
      which indexes policies of journal regarding the archival of scientific manuscripts
      before and/or after peer-review as well as formatted manuscripts.
    authors:
    - family-names: Grenié
      given-names: Matthias
      email: matthias.grenie@gmail.com
      orcid: https://orcid.org/0000-0002-4659-7522
    - family-names: Gruson
      given-names: Hugo
      orcid: https://orcid.org/0000-0002-4094-1476
    preferred-citation:
      type: generic
      title: 'rromeo: An R Client for SHERPA/RoMEO API'
      authors:
      - family-names: Grenié
        given-names: Matthias
      - family-names: Gruson
        given-names: Hugo
      year: '2020'
      url: https://CRAN.R-project.org/package=rromeo
    repository-code: https://github.com/ropensci/rromeo
    url: https://docs.ropensci.org/rromeo/
    date-released: '2020-03-11'
    contact:
    - family-names: Grenié
      given-names: Matthias
      email: matthias.grenie@gmail.com
      orcid: https://orcid.org/0000-0002-4659-7522
    references:
    - type: generic
      authors:
      - name: SHERPA/RoMEO
      url: http://www.sherpa.ac.uk/romeo/
      year: '2021'
    
    ---
    
    ## Validation results 
    
                  field                          message
    1 data.references.0 referenced schema does not match
    [1] FALSE
    
    ---

