# Test CITATION parsing of a random sample of installed packages

    
    
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
     [1] Rcpp_1.0.7         rstudioapi_0.13    knitr_1.34         magrittr_2.0.1    
     [5] usethis_2.0.1      devtools_2.4.2     pkgload_1.2.1      jsonvalidate_1.1.0
     [9] R6_2.5.1           rlang_0.4.11       fastmap_1.1.0      highr_0.9         
    [13] tools_4.1.1        pkgbuild_1.2.0     xfun_0.25          waldo_0.3.0       
    [17] sessioninfo_1.1.1  cli_3.0.1          withr_2.4.2        ellipsis_0.3.2    
    [21] remotes_2.4.0      yaml_2.2.1         rprojroot_2.0.2    lifecycle_1.0.0   
    [25] crayon_1.4.1       processx_3.5.2     purrr_0.3.4        callr_3.7.0       
    [29] fs_1.5.0           ps_1.6.0           curl_4.3.2         memoise_2.0.0     
    [33] glue_1.4.2         cachem_1.0.6       V8_3.4.2           compiler_4.1.1    
    [37] desc_1.3.0         prettyunits_1.1.1  jsonlite_1.7.2    
    
    ---
    
    ## Summary 
    
    [1] "testing a sample of 822 installed packages"
    
    ---     field                          message
    1 data.url referenced schema does not match
    
    
    ## Errors on changepoint 
    
         field                          message
    1 data.url referenced schema does not match
    [1] FALSE
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## Errors on geospt 
    
                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    [1] FALSE
    
    ---
    
    ## Packages with CITATION file: 242 
    
                   package    version valid
    1                 ade4     1.7-17  TRUE
    2         adehabitatHR     0.4.19  TRUE
    3         adehabitatHS     0.3.15  TRUE
    4         adehabitatLT     0.3.25  TRUE
    5         adehabitatMA     0.3.14  TRUE
    6            animation        2.6  TRUE
    7                areal      0.1.7  TRUE
    8            autoimage      2.2.3  TRUE
    9              automap     1.0-14  TRUE
    10          batchmeans      1.0-4  TRUE
    11         Brobdingnag      1.2-6  TRUE
    12                bsam      1.1.3  TRUE
    13           cancensus      0.4.3  TRUE
    14                 car     3.0-11  TRUE
    15            CARBayes      5.2.4  TRUE
    16          CARBayesST      3.2.1  TRUE
    17         cartography      3.0.0  TRUE
    18         changepoint      2.2.2 FALSE
    19           checkmate      2.0.0  TRUE
    20               chron     2.3-56  TRUE
    21           climaemet      1.0.0  TRUE
    22             cmocean      0.3-1  TRUE
    23                coda     0.19-4  TRUE
    24          colorspace      2.0-2  TRUE
    25         CompRandFld    1.0.3-6  TRUE
    26  constrainedKriging      0.2.4  TRUE
    27            corrplot       0.90  TRUE
    28         countrycode      1.3.0  TRUE
    29               crawl      2.2.1  TRUE
    30                 ctv      0.8-5  TRUE
    31               dbmss      2.7-7  TRUE
    32             DEoptim      2.2-6  TRUE
    33               Deriv      4.1.3  TRUE
    34      diseasemapping      1.5.1  TRUE
    35           dotCall64      1.0-1  TRUE
    36              ecespa     1.1-13  TRUE
    37             elevatr      0.4.1  TRUE
    38            EnvStats      2.4.0  TRUE
    39            eurostat      3.7.5  TRUE
    40                 evd      2.3-3  TRUE
    41         fastcluster      1.2.3  TRUE
    42              fields       12.5  TRUE
    43            filehash      2.4-2  TRUE
    44            fishmove      0.3-3  TRUE
    45            foieGras      0.7-6  TRUE
    46         forestError      1.1.0  TRUE
    47             Formula      1.2-4  TRUE
    48                 FRK      2.0.0  TRUE
    49              future     1.22.1  TRUE
    50        future.apply      1.8.1  TRUE
    51                  GA      3.2.1  TRUE
    52             gapfill    0.9.6-1  TRUE
    53           gdistance      1.3-6  TRUE
    54                geeM     0.10.1  TRUE
    55             geepack      1.3-2  TRUE
    56            GeoLight      2.0.0  TRUE
    57              geospt      1.0-2 FALSE
    58               geouy      0.2.5  TRUE
    59               ggmap      3.0.0  TRUE
    60             ggplot2      3.3.5  TRUE
    61            ggsignif      0.6.3  TRUE
    62              giscoR      0.2.4  TRUE
    63              glmnet      4.1-2  TRUE
    64                 gmm      1.6-6  TRUE
    65           googleVis     0.6.10  TRUE
    66                 gsl      2.1-6  TRUE
    67               gstat      2.0-7  TRUE
    68              hdrcde        3.4  TRUE
    69                igoR      0.1.2  TRUE
    70              igraph      1.2.6  TRUE
    71               imguR      1.0.3  TRUE
    72             inlmisc      0.5.2  TRUE
    73             intamap      1.4-9  TRUE
    74                ipdw      0.2-9  TRUE
    75            jsonlite      1.7.2  TRUE
    76             kernlab     0.9-29  TRUE
    77               knitr       1.34  TRUE
    78             landsat      1.1.0  TRUE
    79    landscapemetrics      1.5.4  TRUE
    80            leafletR      0.4-0  TRUE
    81            limSolve      1.5.6  TRUE
    82                lme4   1.1-27.1  TRUE
    83              lmtest     0.9-38  TRUE
    84           lubridate     1.7.10  TRUE
    85               lunar     0.1-04  TRUE
    86            magclass     5.24.7  TRUE
    87               magic      1.5-9  TRUE
    88             mapmisc      1.8.0  TRUE
    89            mapSpain      0.3.1  TRUE
    90              marmap      1.0.5  TRUE
    91              maxLik      1.5-2  TRUE
    92              mclust      5.4.7  TRUE
    93            MCMCpack      1.5-0  TRUE
    94                mice     3.13.0  TRUE
    95            micromap      1.9.4  TRUE
    96              misc3d      0.9-0  TRUE
    97                 mlr     2.19.0  TRUE
    98              mnormt      2.0.2  TRUE
    99            ModelMap    3.4.0.1  TRUE
    100         momentuHMM      1.5.4  TRUE
    101          mousetrap      3.2.0  TRUE
    102            moveHMM        1.7  TRUE
    103            moveVis     0.10.5  TRUE
    104                msm      1.6.8  TRUE
    105            mvtnorm      1.1-2  TRUE
    106              nabor      0.5.0  TRUE
    107            network     1.17.1  TRUE
    108          ngspatial      1.2-2  TRUE
    109             nloptr    1.2.2.2  TRUE
    110      nominatimlite      0.0.1  TRUE
    111                 np    0.60-11  TRUE
    112             OasisR      3.0.2  TRUE
    113            openair      2.8-3  TRUE
    114             optimx  2021-6.12  TRUE
    115              osmar      1.1-7  TRUE
    116            osmdata      0.1.6  TRUE
    117             pacman      0.5.1  TRUE
    118           pbkrtest      0.5.1  TRUE
    119             pkgdev 0.0.1.9004  TRUE
    120                plm      2.4-1  TRUE
    121            plotKML      0.8-1  TRUE
    122             plotly    4.9.4.1  TRUE
    123               plyr      1.8.6  TRUE
    124            polyCub      0.8.0  TRUE
    125            polynom      1.4-0  TRUE
    126            PReMiuM      3.2.6  TRUE
    127    PresenceAbsence      1.1.9  TRUE
    128               pscl      1.5.5  TRUE
    129              psych      2.1.6  TRUE
    130          quickmapr      0.3.0  TRUE
    131        R.methodsS3      1.8.1  TRUE
    132               R.oo     1.24.0  TRUE
    133              ramps     0.6.16  TRUE
    134       RandomFields      3.3.8  TRUE
    135  RandomFieldsUtils      0.5.3  TRUE
    136       randomForest     4.6-14  TRUE
    137        randtoolbox     1.30.1  TRUE
    138             ranger     0.13.1  TRUE
    139          rasterVis     0.50.3  TRUE
    140               Rcpp      1.0.7  TRUE
    141      RcppArmadillo 0.10.6.0.0  TRUE
    142          RcppEigen  0.3.3.9.1  TRUE
    143             Rdpack      2.1.2  TRUE
    144             recmap      1.0.9  TRUE
    145         RefManageR      1.3.0  TRUE
    146            regress     1.3-21  TRUE
    147            reshape      0.8.8  TRUE
    148           reshape2      1.4.4  TRUE
    149              rgbif      3.6.0  TRUE
    150               rgee      1.1.0  TRUE
    151        RgoogleMaps    1.4.5.3  TRUE
    152             rgugik      0.3.1  TRUE
    153                rio     0.5.27  TRUE
    154          rmarkdown       2.10  TRUE
    155            rngWELL     0.10-6  TRUE
    156         robustbase     0.93-8  TRUE
    157               ROCR     1.0-11  TRUE
    158                ROI      1.0-0  TRUE
    159        rostemplate 0.0.3.9020  TRUE
    160           rpostgis      1.4.3  TRUE
    161            RSurvey      0.9.3  TRUE
    162               rtop     0.5-14  TRUE
    163          rworldmap      1.3-6  TRUE
    164           sandwich      3.0-1  TRUE
    165          satellite      1.0.2  TRUE
    166      scatterplot3d     0.3-41  TRUE
    167          SDLfilter      2.1.1  TRUE
    168           seasonal      1.8.3  TRUE
    169            selectr      0.4-2  TRUE
    170                 sf      1.0-2  TRUE
    171          shp2graph        0-5  TRUE
    172             signal      0.7-7  TRUE
    173             SiMRiv      1.0.4  TRUE
    174             siplab        1.5  TRUE
    175               smam      0.6.0  TRUE
    176              solaR       0.45  TRUE
    177                 sp      1.4-5  TRUE
    178          spacetime      1.2-5  TRUE
    179               spam      2.7-0  TRUE
    180              spaMM     3.8.23  TRUE
    181              sparr     2.2-15  TRUE
    182              spate        1.7  TRUE
    183            spatial     7.3-14  TRUE
    184         spatialEco      1.3-7  TRUE
    185         spatialreg      1.1-8  TRUE
    186           spatstat      2.2-0  TRUE
    187      spatstat.core      2.3-0  TRUE
    188      spatstat.geom      2.2-2  TRUE
    189    spatstat.linnet      2.3-0  TRUE
    190            spBayes      0.4-3  TRUE
    191        spBayesSurv      1.1.5  TRUE
    192              spdep     1.1-11  TRUE
    193         sperrorest      3.0.2  TRUE
    194           spgrass6      0.8-9  TRUE
    195              sphet        1.7  TRUE
    196              spind      2.2.1  TRUE
    197               splm     1.4-11  TRUE
    198           spsurvey      4.1.4  TRUE
    199            spTimer      3.3.1  TRUE
    200                SSN     1.1.15  TRUE
    201             stampr        0.2  TRUE
    202            statmod     1.4.36  TRUE
    203     statnet.common      4.5.0  TRUE
    204            stplanr      0.8.3  TRUE
    205         stringdist      0.9.8  TRUE
    206            stringi      1.7.4  TRUE
    207           survival     3.2-13  TRUE
    208           testthat      3.0.4  TRUE
    209                tgp     2.4-17  TRUE
    210            tidyBdE      0.2.0  TRUE
    211       tidygeocoder      1.0.3  TRUE
    212           tidytext      0.3.1  TRUE
    213          tidyverse      1.3.1  TRUE
    214           tinytest      1.3.1  TRUE
    215            tinytex       0.33  TRUE
    216               tmap      3.3-2  TRUE
    217                TMB     1.7.21  TRUE
    218           tmvtnorm     1.4-10  TRUE
    219         tokenizers      0.2.1  TRUE
    220           trackdem      0.5.2  TRUE
    221            trackeR      1.5.2  TRUE
    222              trajr      1.4.0  TRUE
    223               trip      1.8.5  TRUE
    224     tripEstimation     0.0-44  TRUE
    225              units      0.7-2  TRUE
    226            viridis      0.6.1  TRUE
    227        viridisLite      0.4.0  TRUE
    228             VTrack       1.21  TRUE
    229         wildlifeDI      0.4.1  TRUE
    230                zoo      1.8-9  TRUE
    231               zoom      2.0.4  TRUE
    232               base      4.1.1  TRUE
    233               boot     1.3-28  TRUE
    234              class     7.3-19  TRUE
    235            cluster      2.1.2  TRUE
    236            lattice    0.20-44  TRUE
    237               MASS     7.3-54  TRUE
    238               mgcv     1.8-36  TRUE
    239               nlme    3.1-152  TRUE
    240               nnet     7.3-16  TRUE
    241            spatial     7.3-14  TRUE
    242           survival     3.2-11  TRUE
    
    ---

