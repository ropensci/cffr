# Test CITATION parsing of a random sample of installed packages

    
    
    ## Sessioninfo 
    
    R version 4.1.0 (2021-05-18)
    Platform: x86_64-pc-linux-gnu (64-bit)
    Running under: Ubuntu 20.04.2 LTS
    
    Matrix products: default
    BLAS:   /usr/lib/x86_64-linux-gnu/atlas/libblas.so.3.10.3
    LAPACK: /usr/lib/x86_64-linux-gnu/atlas/liblapack.so.3.10.3
    
    locale:
     [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
     [4] LC_COLLATE=C           LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
     [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    
    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     
    
    other attached packages:
    [1] cffr_0.0.0.9000 testthat_3.0.4 
    
    loaded via a namespace (and not attached):
     [1] styler_1.5.1       xfun_0.25          remotes_2.4.0      purrr_0.3.4       
     [5] rematch2_2.1.2     rcmdcheck_1.3.3    V8_3.4.2           vctrs_0.3.8       
     [9] usethis_2.0.1      htmltools_0.5.2    yaml_2.2.1         utf8_1.2.2        
    [13] rlang_0.4.11       pkgbuild_1.2.0     urlchecker_1.0.0   R.oo_1.24.0       
    [17] pillar_1.6.2       glue_1.4.2         withr_2.4.2        R.utils_2.10.1    
    [21] xopen_1.0.0        sessioninfo_1.1.1  R.cache_0.15.0     lifecycle_1.0.0   
    [25] stringr_1.4.0      commonmark_1.7     R.methodsS3_1.8.1  devtools_2.4.2    
    [29] memoise_2.0.0      evaluate_0.14      knitr_1.34         callr_3.7.0       
    [33] fastmap_1.1.0      ps_1.6.0           curl_4.3.2         fansi_0.5.0       
    [37] highr_0.9          Rcpp_1.0.7         backports_1.2.1    cachem_1.0.6      
    [41] jsonvalidate_1.1.0 desc_1.3.0         pkgload_1.2.1      jsonlite_1.7.2    
    [45] fs_1.5.0           pkgdev_0.0.1.9004  digest_0.6.27      stringi_1.7.4     
    [49] processx_3.5.2     rprojroot_2.0.2    cli_3.0.1          tools_4.1.0       
    [53] magrittr_2.0.1     tibble_3.1.4       crayon_1.4.1       pkgconfig_2.0.3   
    [57] codemeta_0.1.1     ellipsis_0.3.2     xml2_1.3.2         prettyunits_1.1.1 
    [61] rmarkdown_2.10     roxygen2_7.1.2     rstudioapi_0.13    R6_2.5.1          
    [65] compiler_4.1.0    
    
    ---
    
    ## Summary 
    
    [1] "testing a sample of 394 installed packages"
    
    ---              field                          message
    1 data.references.3 referenced schema does not match
    
    
    ## Errors on psychotree 
    
                  field                          message
    1 data.references.3 referenced schema does not match
    [1] FALSE
    
    ---
    
    ## Packages with CITATION file: 96 
    
                          package    version valid
    adehabitatMA     adehabitatMA     0.3.14  TRUE
    ape                       ape        5.5  TRUE
    car                       car     3.0-11  TRUE
    chron                   chron     2.3-56  TRUE
    circlize             circlize     0.4.13  TRUE
    coda                     coda     0.19-4  TRUE
    colorspace         colorspace      2.0-2  TRUE
    corrplot             corrplot       0.90  TRUE
    countrycode       countrycode      1.3.0  TRUE
    dendextend         dendextend     1.15.1  TRUE
    deSolve               deSolve       1.28  TRUE
    EpiModel             EpiModel      2.1.0  TRUE
    ergm                     ergm      4.1.2  TRUE
    FactoMineR         FactoMineR        2.4  TRUE
    filehash             filehash      2.4-2  TRUE
    fitdistrplus     fitdistrplus      1.1-5  TRUE
    flashClust         flashClust     1.01-2  TRUE
    Formula               Formula      1.2-4  TRUE
    future                 future     1.22.1  TRUE
    future.apply     future.apply      1.8.1  TRUE
    gdistance           gdistance      1.3-6  TRUE
    ggplot2               ggplot2      3.3.5  TRUE
    ggsignif             ggsignif      0.6.3  TRUE
    giscoR                 giscoR      0.2.4  TRUE
    gstat                   gstat      2.0-7  TRUE
    heatmaply           heatmaply      1.2.1  TRUE
    igraph                 igraph      1.2.6  TRUE
    jsonlite             jsonlite      1.7.2  TRUE
    knitr                   knitr       1.34  TRUE
    lava                     lava     1.6.10  TRUE
    leiden                 leiden      0.3.9  TRUE
    lme4                     lme4   1.1-27.1  TRUE
    lmtest                 lmtest     0.9-38  TRUE
    lubridate           lubridate     1.7.10  TRUE
    mapSpain             mapSpain      0.3.0  TRUE
    marmap                 marmap      1.0.5  TRUE
    mvtnorm               mvtnorm      1.1-2  TRUE
    network               network     1.17.1  TRUE
    nloptr                 nloptr    1.2.2.2  TRUE
    partykit             partykit     1.2-15  TRUE
    pbkrtest             pbkrtest      0.5.1  TRUE
    pkgdev                 pkgdev 0.0.1.9004  TRUE
    plotly                 plotly    4.9.4.1  TRUE
    plotrix               plotrix      3.8-2  TRUE
    plyr                     plyr      1.8.6  TRUE
    polynom               polynom      1.4-0  TRUE
    pROC                     pROC     1.18.0  TRUE
    psychotools       psychotools      0.6-1  TRUE
    psychotree         psychotree     0.15-4 FALSE
    R.methodsS3       R.methodsS3      1.8.1  TRUE
    R.oo                     R.oo     1.24.0  TRUE
    Rcpp                     Rcpp      1.0.7  TRUE
    RcppArmadillo   RcppArmadillo 0.10.6.0.0  TRUE
    RcppEigen           RcppEigen  0.3.3.9.1  TRUE
    reshape               reshape      0.8.8  TRUE
    reshape2             reshape2      1.4.4  TRUE
    rintrojs             rintrojs      0.3.0  TRUE
    rio                       rio     0.5.27  TRUE
    rmarkdown           rmarkdown       2.10  TRUE
    robustbase         robustbase     0.93-8  TRUE
    ROCR                     ROCR     1.0-11  TRUE
    Rtsne                   Rtsne       0.15  TRUE
    scatterplot3d   scatterplot3d     0.3-41  TRUE
    sctransform       sctransform      0.3.2  TRUE
    selectr               selectr      0.4-2  TRUE
    seriation           seriation      1.3.0  TRUE
    Seurat                 Seurat      4.0.4  TRUE
    sf                         sf      1.0-2  TRUE
    sp                         sp      1.4-5  TRUE
    spacetime           spacetime      1.2-5  TRUE
    spatstat.core   spatstat.core      2.3-0  TRUE
    spatstat.geom   spatstat.geom      2.2-2  TRUE
    spdep                   spdep     1.1-11  TRUE
    SQUAREM               SQUAREM     2021.1  TRUE
    statnet.common statnet.common      4.5.0  TRUE
    stringi               stringi      1.7.4  TRUE
    tergm                   tergm      4.0.2  TRUE
    testthat             testthat      3.0.4  TRUE
    tidyverse           tidyverse      1.3.1  TRUE
    tinytex               tinytex       0.33  TRUE
    TSP                       TSP     1.1-10  TRUE
    units                   units      0.7-2  TRUE
    viridis               viridis      0.6.1  TRUE
    viridisLite       viridisLite      0.4.0  TRUE
    zoo                       zoo      1.8-9  TRUE
    base                     base      4.1.0  TRUE
    boot                     boot     1.3-28  TRUE
    class                   class     7.3-19  TRUE
    cluster               cluster      2.1.2  TRUE
    lattice               lattice    0.20-44  TRUE
    MASS                     MASS     7.3-54  TRUE
    mgcv                     mgcv     1.8-35  TRUE
    nlme                     nlme    3.1-152  TRUE
    nnet                     nnet     7.3-16  TRUE
    spatial               spatial     7.3-14  TRUE
    survival             survival     3.2-11  TRUE
    
    ---

