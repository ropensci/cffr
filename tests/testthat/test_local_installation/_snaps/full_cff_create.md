# Test CITATION.cff of all installed packages

                           field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## ---- 
    
    cff-version: 1.2.0
    message: 'To cite package "rgeos" in publications use:'
    type: software
    license: GPL-2.0-or-later
    title: 'rgeos: Interface to Geometry Engine - Open Source (''GEOS'')'
    version: 0.5-7
    abstract: 'Interface to Geometry Engine - Open Source (''GEOS'') using the C ''API''
      for topology operations on geometries. Please note that ''rgeos'' will be retired
      by the end of 2023, plan transition to sf functions using ''GEOS'' at your earliest
      convenience. The ''GEOS'' library is external to the package, and, when installing
      the package from source, must be correctly installed first. Windows and Mac Intel
      OS X binaries are provided on ''CRAN''. (''rgeos'' >= 0.5-1): Up to and including
      ''GEOS'' 3.7.1, topological operations succeeded with some invalid geometries for
      which the same operations fail from and including ''GEOS'' 3.7.2. The ''checkValidity=''
      argument defaults and structure have been changed, from default FALSE to integer
      default ''0L'' for ''GEOS'' < 3.7.2 (no check), ''1L'' ''GEOS'' >= 3.7.2 (check
      and warn). A value of ''2L'' is also provided that may be used, assigned globally
      using ''set_RGEOS_CheckValidity(2L)'', or locally using the ''checkValidity=2L''
      argument, to attempt zero-width buffer repair if invalid geometries are found. The
      previous default (FALSE, now ''0L'') is fastest and used for ''GEOS'' < 3.7.2, but
      will not warn users of possible problems before the failure of topological operations
      that previously succeeded. From ''GEOS'' 3.8.0, repair of geometries may also be
      attempted using ''gMakeValid()'', which may, however, return a collection of geometries
      of different types.'
    authors:
    - family-names: Bivand
      given-names: Roger
      email: Roger.Bivand@nhh.no
      orcid: https://orcid.org/0000-0003-2392-6140
    - family-names: Rundel
      given-names: Colin
    preferred-citation:
      title: 'rgeos: Interface to Geometry Engine - Open Source (''GEOS'')'
      authors:
      - family-names: Bivand
        given-names: Roger
        email: Roger.Bivand@nhh.no
        orcid: https://orcid.org/0000-0003-2392-6140
      - family-names: Rundel
        given-names: Colin
      year: '2021'
      url: https://r-forge.r-project.org/projects/rgeos/ https://trac.osgeo.org/geos/
        http://rgeos.r-forge.r-project.org/index.html
      type: manual
    date-released: '2021-09-07'
    contact:
    - family-names: Bivand
      given-names: Roger
      email: Roger.Bivand@nhh.no
      orcid: https://orcid.org/0000-0003-2392-6140
    
    ---                       field                          message
    1 data["preferred-citation"] referenced schema does not match
    
    
    ## ---- 
    
    cff-version: 1.2.0
    message: 'To cite package "urltools" in publications use:'
    type: software
    license: MIT
    title: 'urltools: Vectorised Tools for URL Handling and Parsing'
    version: 1.7.3
    abstract: A toolkit for all URL-handling needs, including encoding and decoding, parsing,
      parameter extraction and modification. All functions are designed to be both fast
      and entirely vectorised. It is intended to be useful for people dealing with web-related
      datasets, such as server-side logs, although may be useful for other situations
      involving large sets of URLs.
    authors:
    - family-names: Keyes
      given-names: Os
      email: ironholds@gmail.com
    - family-names: Jacobs
      given-names: Jay
    - family-names: Schmidt
      given-names: Drew
    - family-names: Greenaway
      given-names: Mark
    - family-names: Rudis
      given-names: Bob
    - family-names: Pinto
      given-names: Alex
    - family-names: Khezrzadeh
      given-names: Maryam
    - family-names: Meilstrup
      given-names: Peter
    - family-names: Costello
      given-names: Adam M.
    - family-names: Bezanson
      given-names: Jeff
    - family-names: Jiang
      given-names: Xueyuan
    preferred-citation:
      title: 'urltools: Vectorised Tools for URL Handling and Parsing'
      authors:
      - family-names: Keyes
        given-names: Os
      - family-names: Jacobs
        given-names: Jay
      - family-names: Schmidt
        given-names: Drew
      - family-names: Greenaway
        given-names: Mark
      - family-names: Rudis
        given-names: Bob
      - family-names: Pinto
        given-names: Alex
      - family-names: Khezrzadeh
        given-names: Maryam
      - family-names: Meilstrup
        given-names: Peter
      - family-names: Costello
        given-names: Adam M.
      - family-names: Bezanson
        given-names: Jeff
      - family-names: Meilstrup
        given-names: Peter
      - family-names: Jiang
        given-names: Xueyuan
      year: '2019'
      url: https://github.com/Ironholds/urltools/
      type: manual
    repository-code: https://github.com/Ironholds/urltools
    url: https://github.com/Ironholds/urltools/
    date-released: '2019-04-14'
    contact:
    - family-names: Keyes
      given-names: Os
      email: ironholds@gmail.com
    
    ---
    
    ## Installed packages 
    
    [1] "256 packages"
    
    ---
    
    ## Errors 
    
              package version   res
    rgeos       rgeos   0.5-7 FALSE
    urltools urltools   1.7.3 FALSE
    
    ---

