# No auto generate preferred citations

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
    repository: https://CRAN.R-project.org/package=rgeos
    repository-code: https://r-forge.r-project.org/projects/rgeos/
    url: https://trac.osgeo.org/geos/
    date-released: '2020-09-07'
    contact:
    - family-names: Bivand
      given-names: Roger
      email: Roger.Bivand@nhh.no
      orcid: https://orcid.org/0000-0003-2392-6140
    identifiers:
    - type: url
      value: http://rgeos.r-forge.r-project.org/index.html

---

    cff-version: 1.2.0
    message: 'To cite package "basicdescdate" in publications use:'
    type: software
    license: GPL-3.0-only
    title: 'basicdescdate: A Basic Description with Date'
    version: 0.1.6
    abstract: A very basic description. Should parse without problems. I have a Date
    authors:
    - family-names: Basic
      given-names: Marc
      email: marcbasic@gmail.com
    repository-code: https://github.com/basic/package
    url: https://basic.github.io/package
    date-released: '1999-01-01'
    contact:
    - family-names: Basic
      given-names: Marc
      email: marcbasic@gmail.com

# Fuzzy match on cff_create

    
    
    ## Fuzzy match on cff_create 
    
    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    title: Modifying a 'cff' object
    version: 0.0.1
    authors:
    - family-names: Doe
      given-names: John
    repository: https://github.com/user/repo
    url: https://ropensci.org/
    
    ---

