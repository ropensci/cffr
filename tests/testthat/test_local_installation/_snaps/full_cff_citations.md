# Test CITATION parsing of all installed packages

    
    
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
     [5] devtools_2.4.2     pkgload_1.2.1      jsonvalidate_1.1.0 R6_2.5.1          
     [9] rlang_0.4.11       fastmap_1.1.0      tools_4.1.1        pkgbuild_1.2.0    
    [13] sessioninfo_1.1.1  cli_3.0.1          withr_2.4.2        ellipsis_0.3.2    
    [17] remotes_2.4.0      yaml_2.2.1         rprojroot_2.0.2    lifecycle_1.0.0   
    [21] crayon_1.4.1       processx_3.5.2     purrr_0.3.4        callr_3.7.0       
    [25] fs_1.5.0           ps_1.6.0           curl_4.3.2         memoise_2.0.0     
    [29] glue_1.4.2         cachem_1.0.6       V8_3.4.2           compiler_4.1.1    
    [33] desc_1.3.0         prettyunits_1.1.1  jsonlite_1.7.2    
    
    ---
    
    ## Summary 
    
    [1] "testing 396 packages"
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on R.methodsS3 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on R.oo 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on RcppArmadillo 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on cartography 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on osmdata 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on sp 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---
    
    ## Packages with CITATION file: 82 
    
                 package    version valid
    1        R.methodsS3      1.8.1 FALSE
    2               R.oo     1.24.0 FALSE
    3       RandomFields      3.3.8  TRUE
    4  RandomFieldsUtils      0.5.3  TRUE
    5               Rcpp      1.0.7  TRUE
    6      RcppArmadillo 0.10.6.0.0 FALSE
    7          RcppEigen  0.3.3.9.1  TRUE
    8         RefManageR      1.3.0  TRUE
    9        RgoogleMaps    1.4.5.3  TRUE
    10               car     3.0-11  TRUE
    11       cartography      3.0.0 FALSE
    12         climaemet      1.0.0  TRUE
    13              coda     0.19-4  TRUE
    14        colorspace      2.0-2  TRUE
    15          corrplot       0.90  TRUE
    16       countrycode      1.3.0  TRUE
    17          eurostat      3.7.5  TRUE
    18             ggmap      3.0.0  TRUE
    19           ggplot2      3.3.5  TRUE
    20          ggsignif      0.6.2  TRUE
    21            giscoR      0.2.4  TRUE
    22             gstat      2.0-7  TRUE
    23              igoR      0.1.2  TRUE
    24            igraph      1.2.6  TRUE
    25             imguR      1.0.3  TRUE
    26          jsonlite      1.7.2  TRUE
    27             knitr       1.33  TRUE
    28              lme4   1.1-27.1  TRUE
    29         lubridate     1.7.10  TRUE
    30             lunar     0.1-04  TRUE
    31          mapSpain      0.3.0  TRUE
    32           network     1.17.1  TRUE
    33            nloptr    1.2.2.2  TRUE
    34     nominatimlite      0.0.1  TRUE
    35           osmdata      0.1.6 FALSE
    36            pacman      0.5.1  TRUE
    37          pbkrtest      0.5.1  TRUE
    38            pkgdev 0.0.1.9004  TRUE
    39              plyr      1.8.6  TRUE
    40           polynom      1.4-0  TRUE
    41               rio     0.5.27  TRUE
    42         rmarkdown       2.10  TRUE
    43       rostemplate 0.0.3.9020  TRUE
    44         satellite      1.0.2  TRUE
    45     scatterplot3d     0.3-41  TRUE
    46          seasonal      1.8.3  TRUE
    47           selectr      0.4-2  TRUE
    48                sf      1.0-2  TRUE
    49                sp      1.4-5 FALSE
    50         spacetime      1.2-5  TRUE
    51        spatialEco      1.3-7  TRUE
    52          spatstat      2.2-0  TRUE
    53     spatstat.core      2.3-0  TRUE
    54     spatstat.geom      2.2-2  TRUE
    55   spatstat.linnet      2.3-0  TRUE
    56             spdep     1.1-11  TRUE
    57    statnet.common      4.5.0  TRUE
    58        stringdist      0.9.7  TRUE
    59           stringi      1.7.4  TRUE
    60          survival     3.2-13  TRUE
    61          testthat      3.0.4  TRUE
    62           tidyBdE      0.2.0  TRUE
    63      tidygeocoder      1.0.3  TRUE
    64          tidytext      0.3.1  TRUE
    65         tidyverse      1.3.1  TRUE
    66          tinytest      1.3.1  TRUE
    67           tinytex       0.33  TRUE
    68              tmap      3.3-2  TRUE
    69        tokenizers      0.2.1  TRUE
    70             units      0.7-2  TRUE
    71               zoo      0.0.2  TRUE
    72              MASS      1.8-9  TRUE
    73              base     7.3-54  TRUE
    74              boot      1.3-4  TRUE
    75             class      4.1.1  TRUE
    76           cluster     1.3-28  TRUE
    77           lattice      4.1.1  TRUE
    78              mgcv    0.20-44  TRUE
    79              nlme      4.1.1  TRUE
    80              nnet     1.8-36  TRUE
    81           spatial      4.1.1  TRUE
    82          survival      4.1.1  TRUE
    
    ---

