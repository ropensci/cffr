# Test message on cff

    Code
      def <- cff("abcde")
    Condition
      Warning:
      The `path` argument of `cff()` is deprecated as of cffr 1.0.0.
      i Argument ignored.

---

    Code
      afile <- cff(nocff)
    Condition
      Warning:
      The `path` argument of `cff()` is deprecated as of cffr 1.0.0.
      i Argument ignored.

# Walk trough full lifecycle

    Code
      read
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it as below.
      abstract: This is an awesome piece of research software!
      authors:
      - family-names: Real Person
        given-names: One Truly
        name-particle: van der
        name-suffix: IV
        alias: Citey
        affiliation: Excellent University, Niceplace, Arcadia
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
      - name: Entity Project Team Conference entity
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
        date-start: '2017-01-01'
        date-end: '2017-01-31'
        location: The team garage
      commit: 156a04c74a8a79d40c5d705cddf9d36735feab4d
      contact:
      - family-names: Real Person
        given-names: One Truly
        name-particle: van der
        name-suffix: IV
        alias: Citey
        affiliation: Excellent University, Niceplace, Arcadia
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
      - name: Entity Project Team Conference entity
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
        date-start: '2017-01-01'
        date-end: '2017-01-31'
        location: The team garage
      date-released: '2017-12-11'
      doi: 10.5281/zenodo.1003150
      identifiers:
      - type: doi
        value: 10.5281/zenodo.1003150
      - type: swh
        value: swh:1:rel:99f6850374dc6597af01bd0ee1d3fc0699301b9f
      - type: url
        value: https://example.com
      - type: other
        value: other-schema://abcd.1234.efgh.5678
      keywords:
      - One
      - Two
      - Three
      - '4'
      license: CC-BY-SA-4.0
      license-url: https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText
      repository: https://www.example.com/foo/?bar=baz&inga=42&quux
      repository-code: http://foo.com/blah_(wikipedia)_blah#cite-1
      repository-artifact: https://files.pythonhosted.org/packages/0a/84/10507b69a07768bc16981184b4d147a0fc84b71fbf35c03bafc8dcced8e1/cffconvert-1.3.3.tar.gz
      title: Citation File Format 1.0.0
      type: software
      url: http://userid:password@example.com:8080/
      version: 1.0.0
      preferred-citation:
        type: book
        title: Book Title
        abbreviation: Abbr
        abstract: Description of the book.
        collection-doi: 10.5281/zenodo.1003150
        collection-title: Collection Title
        collection-type: Collection Type
        commit: 156a04c74a8a79d40c5d705cddf9d36735feab4d
        copyright: 2017 Stephan Druskat
        data-type: Data Type
        database: Database
        date-accessed: '2017-10-31'
        date-downloaded: '2017-10-31'
        date-released: '2017-10-31'
        date-published: '2017-10-31'
        department: Department
        doi: 10.5281/zenodo.1003150
        edition: 2nd edition
        end: '456'
        entry: Chapter 9
        filename: book.zip
        format: Printed book
        identifiers:
        - type: doi
          value: 10.5281/zenodo.1003150
        - type: swh
          value: swh:1:rel:99f6850374dc6597af01bd0ee1d3fc0699301b9f
        - type: url
          value: https://example.com
        - type: other
          value: other-schema://abcd.1234.efgh.5678
        isbn: 978-1-89183-044-0
        issn: 1234-543X
        issue: '123'
        issue-date: December
        issue-title: Special Issue on Software Citation
        journal: PeerJ
        keywords:
        - Software
        - Citation
        languages:
        - aaa
        - zu
        license: Apache-2.0
        license-url: https://spdx.org/licenses/Apache-2.0.html#licenseText
        loc-start: '14'
        loc-end: '54'
        medium: hardcover book
        month: '3'
        nihmsid: Don't know what format a NIHMSID is in
        notes: A field for general notes about the reference, usable in other formats such
          as BibTeX.
        number: A general-purpose field for accession numbers, cf. the specifications for
          examples.
        number-volumes: '7'
        pages: '765'
        patent-states:
        - Germany
        - ROI
        - 'but also for example US states, such as:'
        - IL
        - RI
        pmcid: PMC1234567
        repository: http://code.google.com/events/#&product=browser
        repository-code: http://142.42.1.1:8080/
        repository-artifact: https://files.pythonhosted.org/packages/0a/84/10507b69a07768bc16981184b4d147a0fc84b71fbf35c03bafc8dcced8e1/cffconvert-1.3.3.tar.gz
        scope: Cite this book if you want to reference the general concepts implemented
          in Citation File Format 1.0.0.
        section: Chapter 2 - "Reference keys"
        status: advance-online
        start: '123'
        thesis-type: Doctoral dissertation
        url: http://j.mp
        version: 0.0.1423-BETA
        volume: '2'
        volume-title: Advances in Software Citation
        year: '2017'
        year-original: '2012'
        conference:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        authors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        contact:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        database-provider:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors-series:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        institution:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        location:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        publisher:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        recipients:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        senders:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        translators:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
      references:
      - type: book
        title: Book Title
        abbreviation: Abbr
        abstract: Description of the book.
        collection-doi: 10.5281/zenodo.1003150
        collection-title: Collection Title
        collection-type: Collection Type
        commit: 156a04c74a8a79d40c5d705cddf9d36735feab4d
        copyright: 2017 Stephan Druskat
        data-type: Data Type
        database: Database
        date-accessed: '2017-10-31'
        date-downloaded: '2017-10-31'
        date-released: '2017-10-31'
        date-published: '2017-10-31'
        department: Department
        doi: 10.5281/zenodo.1003150
        edition: 2nd edition
        end: '123'
        entry: Chapter 9
        filename: book.zip
        format: Printed book
        identifiers:
        - type: doi
          value: 10.5281/zenodo.1003150
        - type: swh
          value: swh:1:rel:99f6850374dc6597af01bd0ee1d3fc0699301b9f
        - type: url
          value: https://example.com
        - type: other
          value: other-schema://abcd.1234.efgh.5678
        isbn: 978-1-89183-044-0
        issn: 1234-543X
        issue: '123'
        issue-date: December
        issue-title: Special Issue on Software Citation
        journal: PeerJ
        keywords:
        - Software
        - Citation
        languages:
        - aaa
        - zu
        license: Apache-2.0
        license-url: https://spdx.org/licenses/Apache-2.0.html#licenseText
        loc-start: '14'
        loc-end: '54'
        medium: hardcover book
        month: '3'
        nihmsid: Don't know what format a NIHMSID is in
        notes: A field for general notes about the reference, usable in other formats such
          as BibTeX.
        number: A general-purpose field for accession numbers, cf. the specifications for
          examples.
        number-volumes: '7'
        pages: '765'
        patent-states:
        - Germany
        - ROI
        - 'but also for example US states, such as:'
        - IL
        - RI
        pmcid: PMC1234567
        repository: http://code.google.com/events/#&product=browser
        repository-code: http://142.42.1.1:8080/
        repository-artifact: https://files.pythonhosted.org/packages/0a/84/10507b69a07768bc16981184b4d147a0fc84b71fbf35c03bafc8dcced8e1/cffconvert-1.3.3.tar.gz
        scope: Cite this book if you want to reference the general concepts implemented
          in Citation File Format 1.0.0.
        section: Chapter 2 - "Reference keys"
        status: advance-online
        start: '123'
        thesis-type: Doctoral dissertation
        url: http://j.mp
        version: 0.0.1423-BETA
        volume: '2'
        volume-title: Advances in Software Citation
        year: '2017'
        year-original: '2012'
        conference:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        authors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        contact:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        database-provider:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors-series:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        institution:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        location:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        publisher:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        recipients:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        senders:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        translators:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage

---

    Code
      modify
    Output
      cff-version: 1.2.0
      message: If you use this software, please cite it as below.
      type: software
      license: CC-BY-SA-4.0
      title: A new title
      version: 1.0.0
      doi: 10.5281/zenodo.1003150
      identifiers:
      - type: doi
        value: 10.5281/zenodo.1003150
      - type: swh
        value: swh:1:rel:99f6850374dc6597af01bd0ee1d3fc0699301b9f
      - type: url
        value: https://example.com
      - type: other
        value: other-schema://abcd.1234.efgh.5678
      abstract: This is an awesome piece of research software!
      authors:
      - family-names: Real Person
        given-names: One Truly
        name-particle: van der
        name-suffix: IV
        alias: Citey
        affiliation: Excellent University, Niceplace, Arcadia
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
      - name: Entity Project Team Conference entity
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
        date-start: '2017-01-01'
        date-end: '2017-01-31'
        location: The team garage
      preferred-citation:
        type: book
        title: Book Title
        abbreviation: Abbr
        abstract: Description of the book.
        collection-doi: 10.5281/zenodo.1003150
        collection-title: Collection Title
        collection-type: Collection Type
        commit: 156a04c74a8a79d40c5d705cddf9d36735feab4d
        copyright: 2017 Stephan Druskat
        data-type: Data Type
        database: Database
        date-accessed: '2017-10-31'
        date-downloaded: '2017-10-31'
        date-released: '2017-10-31'
        date-published: '2017-10-31'
        department: Department
        doi: 10.5281/zenodo.1003150
        edition: 2nd edition
        end: '456'
        entry: Chapter 9
        filename: book.zip
        format: Printed book
        identifiers:
        - type: doi
          value: 10.5281/zenodo.1003150
        - type: swh
          value: swh:1:rel:99f6850374dc6597af01bd0ee1d3fc0699301b9f
        - type: url
          value: https://example.com
        - type: other
          value: other-schema://abcd.1234.efgh.5678
        isbn: 978-1-89183-044-0
        issn: 1234-543X
        issue: '123'
        issue-date: December
        issue-title: Special Issue on Software Citation
        journal: PeerJ
        keywords:
        - Software
        - Citation
        languages:
        - aaa
        - zu
        license: Apache-2.0
        license-url: https://spdx.org/licenses/Apache-2.0.html#licenseText
        loc-start: '14'
        loc-end: '54'
        medium: hardcover book
        month: '3'
        nihmsid: Don't know what format a NIHMSID is in
        notes: A field for general notes about the reference, usable in other formats such
          as BibTeX.
        number: A general-purpose field for accession numbers, cf. the specifications for
          examples.
        number-volumes: '7'
        pages: '765'
        patent-states:
        - Germany
        - ROI
        - 'but also for example US states, such as:'
        - IL
        - RI
        pmcid: PMC1234567
        repository: http://code.google.com/events/#&product=browser
        repository-code: http://142.42.1.1:8080/
        repository-artifact: https://files.pythonhosted.org/packages/0a/84/10507b69a07768bc16981184b4d147a0fc84b71fbf35c03bafc8dcced8e1/cffconvert-1.3.3.tar.gz
        scope: Cite this book if you want to reference the general concepts implemented
          in Citation File Format 1.0.0.
        section: Chapter 2 - "Reference keys"
        status: advance-online
        start: '123'
        thesis-type: Doctoral dissertation
        url: http://j.mp
        version: 0.0.1423-BETA
        volume: '2'
        volume-title: Advances in Software Citation
        year: '2017'
        year-original: '2012'
        conference:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        authors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        contact:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        database-provider:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors-series:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        institution:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        location:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        publisher:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        recipients:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        senders:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        translators:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
      repository: https://www.example.com/foo/?bar=baz&inga=42&quux
      repository-artifact: https://files.pythonhosted.org/packages/0a/84/10507b69a07768bc16981184b4d147a0fc84b71fbf35c03bafc8dcced8e1/cffconvert-1.3.3.tar.gz
      repository-code: http://foo.com/blah_(wikipedia)_blah#cite-1
      commit: 156a04c74a8a79d40c5d705cddf9d36735feab4d
      url: http://userid:password@example.com:8080/
      date-released: '2017-12-11'
      contact:
      - family-names: Real Person
        given-names: One Truly
        name-particle: van der
        name-suffix: IV
        alias: Citey
        affiliation: Excellent University, Niceplace, Arcadia
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
      - name: Entity Project Team Conference entity
        address: 22 Acacia Avenue
        city: Citationburgh
        region: Renfrewshire
        post-code: C13 7X7
        country: GB
        orcid: https://orcid.org/0000-0001-2345-6789
        email: project@entity.com
        tel: +44(0)141-323 4567
        fax: +44(0)141-323 45678
        website: https://www.entity-project-team.io
        date-start: '2017-01-01'
        date-end: '2017-01-31'
        location: The team garage
      keywords:
      - One
      - Two
      - Three
      - '4'
      references:
      - type: book
        title: Book Title
        abbreviation: Abbr
        abstract: Description of the book.
        collection-doi: 10.5281/zenodo.1003150
        collection-title: Collection Title
        collection-type: Collection Type
        commit: 156a04c74a8a79d40c5d705cddf9d36735feab4d
        copyright: 2017 Stephan Druskat
        data-type: Data Type
        database: Database
        date-accessed: '2017-10-31'
        date-downloaded: '2017-10-31'
        date-released: '2017-10-31'
        date-published: '2017-10-31'
        department: Department
        doi: 10.5281/zenodo.1003150
        edition: 2nd edition
        end: '123'
        entry: Chapter 9
        filename: book.zip
        format: Printed book
        identifiers:
        - type: doi
          value: 10.5281/zenodo.1003150
        - type: swh
          value: swh:1:rel:99f6850374dc6597af01bd0ee1d3fc0699301b9f
        - type: url
          value: https://example.com
        - type: other
          value: other-schema://abcd.1234.efgh.5678
        isbn: 978-1-89183-044-0
        issn: 1234-543X
        issue: '123'
        issue-date: December
        issue-title: Special Issue on Software Citation
        journal: PeerJ
        keywords:
        - Software
        - Citation
        languages:
        - aaa
        - zu
        license: Apache-2.0
        license-url: https://spdx.org/licenses/Apache-2.0.html#licenseText
        loc-start: '14'
        loc-end: '54'
        medium: hardcover book
        month: '3'
        nihmsid: Don't know what format a NIHMSID is in
        notes: A field for general notes about the reference, usable in other formats such
          as BibTeX.
        number: A general-purpose field for accession numbers, cf. the specifications for
          examples.
        number-volumes: '7'
        pages: '765'
        patent-states:
        - Germany
        - ROI
        - 'but also for example US states, such as:'
        - IL
        - RI
        pmcid: PMC1234567
        repository: http://code.google.com/events/#&product=browser
        repository-code: http://142.42.1.1:8080/
        repository-artifact: https://files.pythonhosted.org/packages/0a/84/10507b69a07768bc16981184b4d147a0fc84b71fbf35c03bafc8dcced8e1/cffconvert-1.3.3.tar.gz
        scope: Cite this book if you want to reference the general concepts implemented
          in Citation File Format 1.0.0.
        section: Chapter 2 - "Reference keys"
        status: advance-online
        start: '123'
        thesis-type: Doctoral dissertation
        url: http://j.mp
        version: 0.0.1423-BETA
        volume: '2'
        volume-title: Advances in Software Citation
        year: '2017'
        year-original: '2012'
        conference:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        authors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        contact:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        database-provider:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        editors-series:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        institution:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        location:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        publisher:
          name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        recipients:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        senders:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
        translators:
        - family-names: Real Person
          given-names: One Truly
          name-particle: van der
          name-suffix: IV
          alias: Citey
          affiliation: Excellent University, Niceplace, Arcadia
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
        - name: Entity Project Team Conference entity
          address: 22 Acacia Avenue
          city: Citationburgh
          region: Renfrewshire
          post-code: C13 7X7
          country: GB
          orcid: https://orcid.org/0000-0001-2345-6789
          email: project@entity.com
          tel: +44(0)141-323 4567
          fax: +44(0)141-323 45678
          website: https://www.entity-project-team.io
          date-start: '2017-01-01'
          date-end: '2017-01-31'
          location: The team garage
      license-url: https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText

# Recursive parsing

    Code
      read <- cff(complete)
    Condition
      Warning:
      The `path` argument of `cff()` is deprecated as of cffr 1.0.0.
      i Please use `cff_read_cff_citation()` instead.

# Fuzzy matching of keys on cff

    Code
      cff(tittle = "a", cff_version = "ar", version = "200", messange = "Fix my keys")
    Message
      i Found misspelled keys. Trying to map:
      v tittle: title
      v messange: message
    Output
      title: a
      cff-version: ar
      version: '200'
      message: Fix my keys

---

    Code
      cffobj <- cff(tittle = "a", cff_version = "1.2.0", version = "200", messange = "aa",
        anthor = list(list(`family-names` = "a", `given-names` = "b")))
    Message
      i Found misspelled keys. Trying to map:
      v tittle: title
      v messange: message
      v anthor: authors

# duplicated

    Code
      ss <- cff(tittle = "a", tittle = "ar", version = "200", messange = "Fix my keys")
    Message
      i Found misspelled keys. Trying to map:
      v tittle: title
      v tittle: title
      v messange: message
      ! Removing duplicated keys.

# unnamed

    Code
      ss <- cff(path = "a", "200", "Fix my keys")
    Condition
      Warning:
      The `path` argument of `cff()` is deprecated as of cffr 1.0.0.
      i Argument ignored.
      Error in `validate_extra_keys()`:
      ! Elements in `...` should be named.

---

    Code
      s1 <- cff(path = NULL, title = "a", "b", version = 1)
    Condition
      Warning:
      The `path` argument of `cff()` is deprecated as of cffr 1.0.0.
      i Argument ignored.
    Message
      ! Found 1 not-named argument in position 2.
      i Removing unnamed arguments

---

    Code
      s2 <- cff(path = NULL, title = "a", "aa", "bb", "cc", "b", version = 1, "h",
        "j")
    Condition
      Warning:
      The `path` argument of `cff()` is deprecated as of cffr 1.0.0.
      i Argument ignored.
    Message
      ! Found 6 not-named arguments in positions 2, 3, 4, 5, 7, and 8.
      i Removing unnamed arguments

