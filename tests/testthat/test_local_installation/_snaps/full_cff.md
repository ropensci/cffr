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

    [1] "Skipping  DCluster, surveillance . cffr fails on this batch testing."

---

    
    
    ## Summary 
    
    [1] "testing a sample of 1928 installed packages"
    
    ---

---

    
    
    ## Errors 
    
                              Package Version with_citation is_ok
    InformationValue InformationValue   1.2.3         FALSE FALSE
    arrow                       arrow 5.0.0.2         FALSE FALSE
    iheatmapr               iheatmapr   0.5.1          TRUE FALSE
    midasr                     midasr     0.8          TRUE FALSE
    
    ---
    
    ## Error reports for  
    
    [1] "InformationValue, arrow, iheatmapr, midasr"
    
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
    repository-code: 'https://github.com/selva86/InformationValue License: GPL (>= 2)'
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
    
    ## arrow: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "arrow" in publications use:'
    type: software
    license: Apache-2.0
    title: 'arrow: Integration to ''Apache'' ''Arrow'''
    version: 5.0.0.2
    abstract: '''Apache'' ''Arrow'' <https://arrow.apache.org/> is a cross-language development
      platform for in-memory data. It specifies a standardized language-independent columnar
      memory format for flat and hierarchical data, organized for efficient analytic operations
      on modern hardware. This package provides an interface to the ''Arrow C++'' library.'
    authors:
    - family-names: Richardson
      given-names: Neal
      email: neal@ursalabs.org
    - family-names: Cook
      given-names: Ian
      email: ianmcook@gmail.com
    - family-names: Crane
      given-names: Nic
      email: thisisnic@gmail.com
    - family-names: Keane
      given-names: Jonathan
      email: jkeane@gmail.com
    - family-names: François
      given-names: Romain
      email: romain@rstudio.com
      orcid: https://orcid.org/0000-0002-2444-4226
    - family-names: Ooms
      given-names: Jeroen
      email: jeroen@berkeley.edu
    - name: Apache Arrow
      email: dev@arrow.apache.org
    repository-code: https://github.com/apache/arrow/
    url: https:/.apache.org/jira/projects/ARROW
    date-released: '2021-09-05'
    contact:
    - family-names: Richardson
      given-names: Neal
      email: neal@ursalabs.org
    
    ---
    
    ## Validation results 
    
         field                          message
    1 data.url referenced schema does not match
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
    
    ## midasr: cffr object 
    
    cff-version: 1.2.0
    message: 'To cite package "midasr" in publications use:'
    type: software
    license:
    - GPL-2.0-only
    - MIT
    title: 'midasr: Mixed Data Sampling Regression'
    version: '0.8'
    doi: 10.18637/jss.v072.i04
    abstract: Methods and tools for mixed frequency time series data analysis. Allows
      estimation, model selection and forecasting for MIDAS regressions.
    authors:
    - family-names: Zemlys-Balevicius
      given-names: Vaidotas
      email: zemlys@gmail.com
    - family-names: Kvedaras
      given-names: Virmantas
      email: virmantas.kvedaras@ec.europa.eu
    - family-names: Zemlys-Balevicius
      given-names: Vaidotas
      email: zemlys@gmail.com
    preferred-citation:
      type: article
      title: 'Mixed Frequency Data Sampling Regression Models: The R Package midasr'
      authors:
      - family-names: Ghysels
        given-names: Eric
        email: eghysels@unc.edu
      - family-names: Kvedaras
        given-names: Virmantas
        email: virmantas.kvedaras@mif.vu.lt
      - family-names: Zemlys
        given-names: Vaidotas
        email: vaidotas.zemlys@mif.vu.lt
      journal: Journal of Statistical Software
      year: '2016'
      volume: '72'
      number: '4'
      doi: 10.18637/jss.v072.i04
    repository-code: https://github.com/mpiktas/midasr
    url: http://mpiktas.github.io/midasr/
    date-released: '2021-02-23'
    contact:
    - family-names: Zemlys-Balevicius
      given-names: Vaidotas
      email: zemlys@gmail.com
    
    ---
    
    ## Validation results 
    
             field        message
    1 data.authors must be unique
    [1] FALSE
    
    ---

