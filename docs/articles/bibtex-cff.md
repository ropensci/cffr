# BibTeX and CFF

> **Important**
>
> Generative AI tools were used to assist with parts of this article.

## Citation

Cite this article with this BibTeX entry:

``` bib
@article{hernangomez2022,
    title        = {{BibTeX} and {CFF}, A deterministic crosswalk between two non-equivalent citation schemas},
    author       = {Diego Hernangómez},
    year         = 2022,
    journal      = {The {cffr} package},
    volume       = {Vignettes},
    doi          = {10.21105/joss.03900},
    url          = {https://docs.ropensci.org/cffr/articles/bibtex-cff.html}
}
```

## BibTeX and R

[BibTeX](https://en.wikipedia.org/wiki/BibTeX) is a widely used format
for storing bibliographic references, originally designed in 1985 for
document-centric workflows. It represents citations as relatively flat
records with loosely constrained fields, relying on convention rather
than an explicit schema.

The Citation File Format (CFF) ([Druskat et al.
2021](#ref-druskat_citation_2021)) provides a structured and extensible
alternative for representing citation metadata, particularly for
software and research outputs. It supports explicit typing, nested
objects and richer semantics, including contributor roles and
identifiers.

In modern research workflows, both formats frequently coexist. BibTeX
remains dominant in academic publishing pipelines, while CFF is
increasingly adopted by infrastructure platforms such as GitHub and
Zenodo.

**cffr** ([Hernangómez 2021](#ref-hernangomez2021)) provides a
deterministic mapping (crosswalk) between BibTeX and CFF, enabling
practical interoperability. Due to fundamental differences in their data
models, this mapping is not bijective and may involve structural
transformations, heuristic parsing and controlled information loss.

## Conceptual differences between BibTeX and CFF

At a conceptual level, BibTeX and CFF embody different design
philosophies.

BibTeX represents bibliographic information as flat records with loosely
defined fields, optimized for citation rendering in documents. Semantics
are largely implicit and contextual, depending on entry types and
bibliography styles.

CFF, in contrast, defines a structured schema with explicit typing,
nested objects and richer metadata support. It is designed for producing
citations and for machine-actionable interoperability across platforms.

These conceptual differences explain why a direct one-to-one
correspondence between BibTeX and CFF is not possible. Any crosswalk
must rely on explicit design decisions that balance fidelity, usability
and schema constraints.

## BibTeX definitions

Patashnik ([1988](#ref-patashnik1988)) provides the canonical
description of the BibTeX format. Two key concepts are central:
**entries** and **fields**.

### Entries

The original BibTeX specification defines fourteen canonical entry
types, each corresponding to a class of cited work:

1.  **@article**: An article from a journal or magazine.
2.  **@book**: A book with an explicit publisher.
3.  **@booklet**: A printed and bound work without a named publisher.
4.  **@conference**: Equivalent to **@inproceedings**, included for
    [Scribe](https://en.wikipedia.org/wiki/Scribe_(markup_language))
    compatibility.
5.  **@inbook**: A part of a book, such as a chapter or page range.
6.  **@incollection**: A part of a book with its own title.
7.  **@inproceedings**: An article in conference proceedings.
8.  **@manual**: Technical documentation.
9.  **@mastersthesis**: A Master’s thesis.
10. **@misc**: A fallback type when no other entry fits.
11. **@phdthesis**: A PhD thesis.
12. **@proceedings**: The proceedings of a conference.
13. **@techreport**: A numbered technical report.
14. **@unpublished**: A work not formally published.

Other implementations, notably BibLaTeX ([Kime et al.
2025](#ref-biblatexpack)), extend this set with additional entry types
such as online resources, software and datasets. In standard BibTeX,
such entries must typically be represented as **@misc**.

In **R** ([R Core Team 2026](#ref-R_2021)), the base function
[`bibentry()`](https://rdrr.io/r/utils/bibentry.html) does not implement
**@conference**. Instead, **@inproceedings** is used, as both share the
same conceptual definition.

### Fields

BibTeX entries consist of fields whose relevance and requirement depend
on the entry type. Some fields are mandatory, some are optional and
others are ignored by standard bibliography styles but may still carry
useful information.

The following table summarizes the relationship between BibTeX
**entries** and their **required or optional fields**, following
Patashnik ([1988](#ref-patashnik1988)). Required fields are marked with
**x** and optional fields with **o**.

| field | @article | @book | @booklet | @inbook | @incollection | @conference, @inproceedings |
|:---|:--:|:--:|:--:|:--:|:--:|:--:|
| **address** |  | o | o | o | o | o |
| **annote** |  |  |  |  |  |  |
| **author** | x | x | o | x | x | x |
| **booktitle** |  |  |  |  | x | x |
| **chapter** |  |  |  | x | o |  |
| **crossref** |  |  |  |  |  |  |
| **edition** |  | o |  | o | o |  |
| **editor** |  | x |  | x | o | o |
| **howpublished** |  |  | o |  |  |  |
| **institution** |  |  |  |  |  |  |
| **journal** | x |  |  |  |  |  |
| **key** |  |  |  |  |  |  |
| **month** | o | o | o | o | o | o |
| **note** | o | o | o | o | o | o |
| **number** | o | o |  | o | o | o |
| **organization** |  |  |  |  |  | o |
| **pages** | o |  |  | x | o | o |
| **publisher** |  | x |  | x | x | o |
| **school** |  |  |  |  |  |  |
| **series** |  | o |  | o | o | o |
| **title** | x | x | x | x | x | x |
| **type** |  |  |  | o | o |  |
| **volume** | o | o |  | o | o | o |
| **year** | x | x | o | x | x | x |

\(a\) BibTeX: required fields by entry

| field | @manual | @mastersthesis, phdthesis | @misc | @proceedings | @techreport | @unpublished |
|:---|:--:|:--:|:--:|:--:|:--:|:--:|
| **address** | o | o |  | o | o |  |
| **annote** |  |  |  |  |  |  |
| **author** | o | x | o |  | x | x |
| **booktitle** |  |  |  |  |  |  |
| **chapter** |  |  |  |  |  |  |
| **crossref** |  |  |  |  |  |  |
| **edition** | o |  |  |  |  |  |
| **editor** |  |  |  | o |  |  |
| **howpublished** |  |  | o |  |  |  |
| **institution** |  |  |  |  | x |  |
| **journal** |  |  |  |  |  |  |
| **key** |  |  |  |  |  |  |
| **month** | o | o | o | o | o | o |
| **note** | o | o | o | o | o | x |
| **number** |  |  |  | o | o |  |
| **organization** | o |  |  | o |  |  |
| **pages** |  |  |  |  |  |  |
| **publisher** |  |  |  | o |  |  |
| **school** |  | x |  |  |  |  |
| **series** |  |  |  | o |  |  |
| **title** | x | x | o | x | x | x |
| **type** |  | o |  |  | o |  |
| **volume** |  |  |  | o |  |  |
| **year** | o | x | o | x | x | o |

\(b\) BibTeX: required fields by entry (cont.)

Table 1: BibTeX entries

Only a subset of fields is required for any given entry. Fields such as
**title**, **author** and **year** appear across most entry types,
whereas others are optional or never mandatory. This strict coupling
between entry types and fields is a defining feature of BibTeX and a key
source of friction when interoperating with schema-driven formats such
as CFF.

## Citation File Format

Citation File Format (CFF) consists of plain-text, YAML-based files that
encode human- and machine-readable citation metadata for software and
datasets.

Two keys play a central role in CFF reference modeling:

- `preferred-citation`: Identifies a work that should be cited instead
  of the software or dataset itself.
- `references`: Lists related creative works, analogous to references in
  a scholarly article.

Both keys expect `definitions.reference` objects, as defined in the [CFF
schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#preferred-citation).
These objects support explicit typing, metadata nesting and structured
identifiers, in contrast to BibTeX’s flat field model.

The following table summarizes the valid keys for CFF
`definitions.reference` objects:

|  |  |  |  |  |
|:---|:---|:---|:---|:---|
| `abbreviation` | `abstract` | `authors` | `collection-doi` | `collection-title` |
| `collection-type` | `commit` | `conference` | `contact` | `copyright` |
| `data-type` | `database-provider` | `database` | `date-accessed` | `date-downloaded` |
| `date-published` | `date-released` | `department` | `doi` | `edition` |
| `editors` | `editors-series` | `end` | `entry` | `filename` |
| `format` | `identifiers` | `institution` | `isbn` | `issn` |
| `issue` | `issue-date` | `issue-title` | `journal` | `keywords` |
| `languages` | `license` | `license-url` | `loc-end` | `loc-start` |
| `location` | `medium` | `month` | `nihmsid` | `notes` |
| `number` | `number-volumes` | `pages` | `patent-states` | `pmcid` |
| `publisher` | `recipients` | `repository` | `repository-artifact` | `repository-code` |
| `scope` | `section` | `senders` | `start` | `status` |
| `term` | `thesis-type` | `title` | `translators` | `type` |
| `url` | `version` | `volume` | `volume-title` | `year` |
| `year-original` |  |  |  |  |

Table 2: Valid keys in CFF `definitions.reference` objects

Conceptually, most of these keys correspond to BibTeX
[**fields**](#fields), with one key playing a special role: `type`. In
CFF, `type` explicitly identifies the kind of referenced work, making it
conceptually analogous to a BibTeX [**entry**](#entries) type rather
than a **field**[^1].

## Mapping strategy

The mapping implemented in **cffr** follows a three-step pipeline:

1.  Parse BibTeX entries into an intermediate representation.
2.  Apply deterministic mapping rules to transform entry types and
    fields.
3.  Serialize the result into CFF (and vice versa).

Whenever possible, mappings are deterministic. However, some fields
require heuristic parsing, particularly when normalizing names, dates or
page ranges. As a result, semantic round‑trip reversibility is not
guaranteed, even when the conversion process itself is reproducible.

``` r

string <- "@book{einstein1921,
    title        = {Relativity: The Special and the General Theory},
    author       = {Einstein, A.},
    year         = 1920,
    publisher    = {Henry Holt and Company},
    address      = {London, United Kingdom},
    isbn         = 9781587340925}"

# Convert to `cff`.
library(cffr)
cff_format <- cff_read_bib_text(string)

cff_format
#> - type: book
#>   title: 'Relativity: The Special and the General Theory'
#>   authors:
#>   - family-names: Einstein
#>     given-names: A.
#>   year: '1920'
#>   publisher:
#>     name: Henry Holt and Company
#>     address: London, United Kingdom
#>   isbn: '9781587340925'

# Convert to BibTeX with the S3 method.
toBibtex(cff_format)
#> @Book{einstein:1920,
#>   title = {Relativity: The Special and the General Theory},
#>   author = {A. Einstein},
#>   year = {1920},
#>   publisher = {Henry Holt and Company},
#>   address = {London, United Kingdom},
#>   isbn = {9781587340925},
#> }
```

## Mapping tables

The following tables summarize the mapping rules implemented in
**cffr**. They are intended as implementation documentation rather than
as a normative specification.

Mapping types include:

- **direct**: preserved without modification.
- **transform**: renamed or structurally reorganized.
- **split**: one field mapped to multiple fields.
- **heuristic**: requires parsing or inference.
- **unsupported**: omitted due to lack of correspondence.
- **enrichment**: exists only in CFF.

These mappings are not bijective and may introduce normalization
effects.

> **Note**
>
> For clarity throughout this document, **bold** formatting (for
> example, **@book** and **edition**) is used for BibTeX entries and
> fields, whereas inline code formatting (for example, `book` and
> `edition`) is used for CFF keys.

| BibTeX entry | CFF key `type` | Mapping type | Notes |
|:---|:---|:---|:---|
| **@article** | `type: article` | direct | \- |
| **@book** | `type: book` | direct | \- |
| **@inbook** | `type: chapter` | transform | Normalized to CFF taxonomy |
| **@incollection** | `type: chapter` | transform | Same as **@inbook** |
| **@manual** | `type: manual` | direct | \- |
| **@misc** | `type: generic` | heuristic | `generic` is used as a fallback when no more specific CFF type applies. |
| **@phdthesis** | `type: thesis` | transform | The specific thesis subtype (e.g., master’s vs PhD) may be lost when mapping from BibTeX to CFF. |
| **@techreport** | `type: report` | transform | \- |
| **other** | `type: generic` | heuristic | Default fallback |

Table 3: BibTeX entries and CFF key `type` mapping

| BibTeX field | CFF key | Mapping type | Notes |
|:---|:---|:---|:---|
| **title** | `title` | direct | \- |
| **author** | `authors` | transform | Parsed into structured name objects |
| **editor** | `editors` | transform | Same parsing logic as authors |
| **year** | `year` | direct | \- |
| **month** | `month` | heuristic | Format normalization required |
| **journal** | `journal` | direct | \- |
| **booktitle** | `collection-title` | transform | Container title |
| **volume** | `volume` | direct | \- |
| **number** | `issue` | transform | Naming normalization |
| **pages** | `start`/`end` | split | Parsed from page range |
| **doi** | `doi` | direct | \- |
| **url** | `url` | direct | \- |

Table 4: Core fields

| BibTeX field | CFF key | Mapping type | Notes |
|:---|:---|:---|:---|
| **publisher** | `publisher.name` | transform | Converted to structured object |
| **address** | `publisher.location` | transform | Combined with `publisher` |
| **institution** | `institution` | direct | Used mainly in reports/thesis |
| **school** | `institution` | transform | Thesis normalization |

Table 5: Structural fields

| BibTeX field | CFF key | Mapping type | Notes |
|:---|:---|:---|:---|
| **pages** | `start`/`end` | heuristic | Requires parsing, may fail |
| **author** | `authors` | heuristic | Name splitting is not always reliable |
| **month** | `month` | heuristic | Multiple formats possible |
| **note** | `notes` | heuristic | Free text |

Table 6: Parsed fields

| CFF key              | BibTeX equivalent | Mapping type | Notes                |
|:---------------------|:------------------|:-------------|:---------------------|
| `preferred-citation` | \-                | enrichment   | CFF-specific concept |
| `references`         | \-                | enrichment   | Not representable    |
| `type: software`     | \-                | unsupported  | No BibTeX equivalent |
| `identifiers`        | partial           | transform    | Only DOI/URL mapped  |

Table 7: CFF keys with no BibTeX equivalence

## Proposed crosswalk

**cffr** provides utilities for mapping BibTeX entries (with
[`bibentry()`](https://rdrr.io/r/utils/bibentry.html)) to CFF and back.
This section describes how the crosswalk is implemented, partially
informed by Haines and The Ruby Citation File Format Developers
([2022](#ref-Haines_Ruby_CFF_Library_2021))[^2].

The crosswalk is primarily defined for BibTeX to CFF conversion. Reverse
mapping is a best-effort approximation and may be lossy.

After presenting the general mapping between BibTeX **entries** and
**fields** and CFF keys, the next section introduces [**entry
models**](#entrymodels) that refine these rules for specific BibTeX
entry types.

The mapping is structured according to the transformation semantics
defined below.

## Transformation semantics

The crosswalk applies different transformation strategies:

- **Direct mapping**: one-to-one correspondence between a BibTeX field
  and a CFF key.
- **Structural transformation**: a single field is expanded into
  multiple keys, such as **pages** to `start` and `end`.
- **Heuristic mapping**: equivalence is inferred based on entry type or
  context.
- **Lossy mapping**: information is discarded due to lack of an
  equivalent representation.

Unless stated otherwise, mappings are lossy in at least one direction.

All mappings and examples in the following sections are instances of
these transformation classes.

### Entry/key `type` crosswalk

For mapping general BibTeX entries to CFF key `type`, the following
equivalence is proposed:

| BibTeX entry | CFF key: `type` | Notes |
|:---|:---|:---|
| **@article** | `article` |  |
| **@book, @inbook** | `book` | **@inbook** is a `book` with **chapter** and/or **pages** |
| **@booklet** | `pamphlet` |  |
| **@conference** | `conference-paper` |  |
| **@incollection** | `generic` | Needs additional fields |
| **@inproceedings** | `conference-paper` |  |
| **@manual** | `manual` |  |
| **@mastersthesis, @phdthesis** | `thesis` | Identified by `thesis-type` |
| **@misc** | `generic` |  |
| **@proceedings** | `proceedings` |  |
| **@techreport** | `report` |  |
| **@unpublished** | `unpublished` |  |

Table 8: Entry/Type crosswalk: From BibTeX to CFF

The previous mapping has the following specifications:

- **@book**, **@inbook** and **@incollection** are closely related in
  BibTeX[^3]. While **@inbook** and **@incollection** both reference
  parts of a **@book**, the former is used for citing sections,
  chapters, pages or other specific parts, whereas the latter is used
  for citing parts with a specific title. Since CFF allows keys
  `type: book` and `collection-type: book`, we can use a combination of
  these fields to tag each entry type in CFF accordingly.
- **@mastersthesis** and **@phdthesis** are tagged using a combination
  of `type: thesis` and `thesis-type` keys.

Because CFF allows a wide range of values[^4] for the key `type`, the
following mapping is applied from CFF to BibTeX:

The reverse mapping prioritizes BibTeX compatibility and normalization
over exact round-trip preservation.

| CFF key `type` | BibTeX entry | Notes |
|:---|:---|:---|
| `book` | **@book**, **@inbook** | **@inbook** is a `book` with `section` or `start/end` (reference to page number or range). |
| `conference, conference-paper` | **@inproceedings** |  |
| `article, magazine-article, newspaper-article` | **@article** |  |
| `manual` | **@manual** |  |
| `pamphlet` | **@booklet** |  |
| `proceedings` | **@proceedings** |  |
| `report` | **@techreport** |  |
| `thesis` | **@mastersthesis**, **@phdthesis** | Using `thesis-type` |
| `unpublished` | **@unpublished** |  |
| `generic` | **@misc**, **@incollection** | **@incollection** is a `generic` with `year,publisher,collection-title` |
| \<`any other value`\> | **@misc** |  |

Table 9: Entry/Key `type` crosswalk: From CFF to BibTeX

### Fields/key crosswalk

Some BibTeX fields and CFF keys have similar names and definitions. The
equivalence is straightforward in some cases, but some keys need to be
processed depending on the **entry** type.

| BibTeX **Field** | CFF key | Notes |
|:---|:---|:---|
| **address** | Several possibilities | In **BibTeX** it may be the address of a **publisher, conference, organization, institution** or **school**. |
| **annote** | Not clear, won’t be mapped |  |
| **author** | `authors` |  |
| **booktitle** | `collection-title` |  |
| **chapter** | `section` |  |
| **crossref** | Not clear, won’t be mapped |  |
| **edition** | `edition` |  |
| **editor** | `editors` |  |
| **howpublished** | `medium` |  |
| **institution, school, organization** | `institution` | No overlapping on **BibteX** requirements |
| **journal** | `journal` |  |
| **key** | Not clear, won’t be mapped |  |
| **month** | `month` | Fallback: information in `date-published` |
| **note** | `notes` |  |
| **number** | `issue` |  |
| **pages** | `start` & `end` |  |
| **publisher** | `publisher` |  |
| **series** | `collection-title` if no **booktitle** |  |
| **title** | `title` |  |
| **type** | Won’t be mapped | This is a special key in `CFF` resembling the **BibteX** entry. |
| **volume** | `volume` |  |
| **year** | `year` | Fallback: information in `date-published` |

Table 10: BibTeX - CFF key crosswalk

We provide more detail on some of the mappings presented in the table
above:

- Some fields are not mapped because there is no clear equivalence with
  CFF keys (such as **annote**, **crossref** and **key**). Regarding the
  **type** field, the CFF key `type` corresponds to the identifier of
  the work, similar to an entry in BibTeX. Therefore, BibTeX **type** is
  not mapped. These fields are always optional in BibTeX.
- For the **address** field, its intended use in BibTeX varies depending
  on the entry type. For **@inproceedings**, it denotes the **address**
  of the **conference**, while for **@mastersthesis/@phdthesis**, it is
  the **address** of the **school**. Mapping between BibTeX and CFF
  becomes more complex when institutional metadata is involved. This
  results in varying final mappings in CFF. When mapping from CFF to
  BibTeX, we propose to follow the same entry-based logic, using the key
  `location` as a fallback value when mapping to **address**.
- Because of the complexity mentioned above, **institution,
  organization** and **school** are mapped to `institution`.
- **series** is mapped to `collection-title` only on those entries that
  do not require **booktitle**. In practice, this means that
  `collection-title` corresponds to **booktitle** (for **@incollection**
  and **@inproceedings**), and in the other cases it corresponds to
  **series**. As a consequence, **series** information is lost for
  **@incollection** and **@inproceedings**, but in those cases it is an
  optional field.
- When mapping from CFF to BibTeX, we propose to use `date-published` as
  a fallback for extracting **month** and **year** fields.
- When **pages** is provided as a range separated by `--`, that is,
  **pages = {3–5}**, it is coerced as `start: 3`, `end: 5` in CFF.

#### BibLaTeX

Other CFF keys correspond to BibLaTeX fields. We include these fields in
the crosswalk[^5], even though they are not part of the core BibTeX
field definition.

| **BibLaTeX Field** | CFF key          |
|:-------------------|:-----------------|
| **abstract**       | `abstract`       |
| **date**           | `date-published` |
| **doi**            | `doi`            |
| **file**           | `filename`       |
| **isbn**           | `isbn`           |
| **issn**           | `issn`           |
| **issuetitle**     | `issue-title`    |
| **keywords**       | `keywords`       |
| **pagetotal**      | `pages`          |
| **translator**     | `translators`    |
| **url**            | `url`            |
| **urldate**        | `date-accessed`  |
| **version**        | `version`        |

Table 11: BibLaTeX - CFF field/key crosswalk

## Limitations

The proposed crosswalk is subject to multiple structural limitations
arising from differences between BibTeX and CFF schemas:

- **Lossy mappings**: Some BibTeX fields, including **crossref**,
  **annote** and **key**, have no equivalent in CFF and are omitted
  during conversion.
- **Ambiguous semantics**: Certain fields such as **address** and
  **series** have context-dependent meanings in BibTeX, requiring
  heuristic mapping to CFF keys such as `institution`, `location` or
  `collection-title`.
- **Type collapsing**: Multiple BibTeX entry types, including **@misc**
  and **@incollection**, are mapped to a single CFF type (`generic`),
  which acts as a fallback when no more specific type is available.
- **Structural transformations**: Some fields require transformation
  rather than direct mapping, such as **pages** → `start`/`end`,
  altering the representation of the original data.
- **Non-reversibility**: Due to the above factors, round-trip conversion
  (BibTeX → CFF → BibTeX) is not guaranteed to preserve the original
  structure or semantics.

These limitations reflect fundamental differences between the two
formats rather than implementation-specific constraints.

## Design decisions

The mapping implemented in **cffr** is guided by the following
principles:

- Prefer deterministic mappings whenever possible
- Use heuristics only when unavoidable
- Normalize metadata to align with CFF conventions
- Prioritize interoperability over exact round‑trip fidelity

## Entry models

This section documents entry-specific mapping behavior, expanding the
general crosswalk into concrete and testable models. Examples are
adapted from the
[xampl.bib](https://tug.org/texmf-docs/bibtex/xampl.bib) distributed
with BibTeX ([Patashnik 2010](#ref-patashnik)).

### @article

The crosswalk for **@article** does not require any special treatment.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@article** | `type: article, magazine-article, newspaper-article` |  |
| **author** (required) | `authors` |  |
| **title** (required) | `title` |  |
| **journal** (required) | `journal` |  |
| **year** (required) | `year` |  |
| **volume** | `volume` |  |
| **number** | `issue` |  |
| **pages** | `start` and `end` |  |
| **month** | `month` |  |
| **note** | `notes` |  |

Table 12: **@article** model

**Round-trip**

``` r

bib <- "@article{article-full,
    title        = {The Gnats and Gnus Document Preparation System},
    author       = {Leslie A. Aamport},
    year         = 1986,
    month        = jul,
    journal      = {{G-Animal's} Journal},
    volume       = 41,
    number       = 7,
    pages        = {73+},
    note         = {This is a full ARTICLE entry}}"

cff_read_bib_text(bib)
#> - type: article
#>   title: The Gnats and Gnus Document Preparation System
#>   authors:
#>   - family-names: Aamport
#>     given-names: Leslie A.
#>   year: '1986'
#>   month: '7'
#>   journal: G-Animal's Journal
#>   volume: '41'
#>   issue: '7'
#>   notes: This is a full ARTICLE entry
#>   start: 73+

toBibtex(cff_read_bib_text(bib))
#> @Article{aamport:1986,
#>   title = {The Gnats and Gnus Document Preparation System},
#>   author = {Leslie A. Aamport},
#>   year = {1986},
#>   month = {jul},
#>   journal = {G-Animal's Journal},
#>   volume = {41},
#>   number = {7},
#>   pages = {73+},
#>   note = {This is a full ARTICLE entry},
#> }
```

### @book / @inbook

In terms of fields required in BibTeX, the primary difference between
**@book** and **@inbook** is that **@inbook** requires a **chapter** or
**page** field, while **@book** does not even allow these fields as
optional. Therefore, we propose that an **@inbook** entry in CFF be
treated as a **@book** with the following supplementary fields:

1.  `section`: To denote the specific **chapter** within the book.
2.  `start`/`end`: To indicate the range of **pages** covered by the
    section.

In CFF, the **series** field corresponds to `collection-title` and the
**address** field represents the `publisher`’s `address`. Finally, the
key `collection-type` is populated with `book-series`.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@book, @inbook** | `type: book` | If `section` or `start-end` informed, it would be treated as **@inbook** |
| **author** (required) | `authors` | At least one of **author,editor** required |
| **editor** (required) | `editors` | At least one of **author,editor** required |
| **title** (required) | `title` |  |
| **publisher** (required) | `publisher` |  |
| **year** (required) | `year` |  |
| **chapter** (required in **@inbook** only) | `section` | Not even optional in **@book** |
| **pages** (required in **@inbook** only) | `start` and `end` | Not even optional in **@book** |
| **volume** | `volume` |  |
| **number** | `issue` |  |
| **series** | `collection-title` |  |
| **address** | `address` property of `publisher` |  |
| **edition** | `edition` |  |
| **month** | `month` |  |
| **note** | `notes` |  |
| **type** | Ignored | Only optional in **@inbook** |

Table 13: **@book / @inbook** model

There are notable differences in how BibTeX and **BibLaTeX** handle the
**@inbook** entry (further discussed in the [Appendix
A](#appendix_inbook)). We propose to treat a BibLaTeX **@inbook** as a
BibTeX **@incollection**.

**Round-trip: @book**

``` r

bib <- "@book{book-full,
    title        = {Seminumerical Algorithms},
    author       = {Donald E. Knuth},
    year         = 1981,
    month        = 10,
    publisher    = {Addison-Wesley},
    address      = {Reading, Massachusetts},
    series       = {The Art of Computer Programming},
    volume       = 2,
    note         = {This is a full BOOK entry},
    edition      = {Second}
}"

cff_read_bib_text(bib)
#> - type: book
#>   title: Seminumerical Algorithms
#>   authors:
#>   - family-names: Knuth
#>     given-names: Donald E.
#>   year: '1981'
#>   month: '10'
#>   publisher:
#>     name: Addison-Wesley
#>     address: Reading, Massachusetts
#>   collection-title: The Art of Computer Programming
#>   collection-type: book
#>   volume: '2'
#>   notes: This is a full BOOK entry
#>   edition: Second

toBibtex(cff_read_bib_text(bib))
#> @Book{knuth:1981,
#>   title = {Seminumerical Algorithms},
#>   author = {Donald E. Knuth},
#>   year = {1981},
#>   month = {oct},
#>   publisher = {Addison-Wesley},
#>   address = {Reading, Massachusetts},
#>   series = {The Art of Computer Programming},
#>   volume = {2},
#>   note = {This is a full BOOK entry},
#>   edition = {Second},
#> }
```

**Round-trip: @inbook**

``` r

bib <- "@inbook{inbook-full,
    title        = {Fundamental Algorithms},
    author       = {Donald E. Knuth},
    year         = 1973,
    month        = 10,
    publisher    = {Addison-Wesley},
    address      = {Reading, Massachusetts},
    series       = {The Art of Computer Programming},
    volume       = 1,
    pages        = {10--119},
    note         = {This is a full INBOOK entry},
    edition      = {Second},
    type         = {Section},
    chapter      = {1.2}
}"

cff_read_bib_text(bib)
#> - type: book
#>   title: Fundamental Algorithms
#>   authors:
#>   - family-names: Knuth
#>     given-names: Donald E.
#>   year: '1973'
#>   month: '10'
#>   publisher:
#>     name: Addison-Wesley
#>     address: Reading, Massachusetts
#>   collection-title: The Art of Computer Programming
#>   collection-type: book
#>   volume: '1'
#>   notes: This is a full INBOOK entry
#>   edition: Second
#>   section: '1.2'
#>   start: '10'
#>   end: '119'

toBibtex(cff_read_bib_text(bib))
#> @InBook{knuth:1973,
#>   title = {Fundamental Algorithms},
#>   author = {Donald E. Knuth},
#>   year = {1973},
#>   month = {oct},
#>   publisher = {Addison-Wesley},
#>   address = {Reading, Massachusetts},
#>   series = {The Art of Computer Programming},
#>   volume = {1},
#>   pages = {10--119},
#>   note = {This is a full INBOOK entry},
#>   chapter = {1.2},
#>   edition = {Second},
#> }
```

### @booklet

In **@booklet** **address** is mapped to `location`.

| BibTeX               | CFF              | Notes |
|:---------------------|:-----------------|:------|
| **@booklet**         | `type: pamphlet` |       |
| **title** (required) | `title`          |       |
| **author**           | `authors`        |       |
| **howpublished**     | `medium`         |       |
| **address**          | `location`       |       |
| **month**            | `month`          |       |
| **year**             | `year`           |       |
| **note**             | `notes`          |       |

Table 14: **@booklet** model

**Round-trip**

``` r

bib <- "@booklet{booklet-full,
    title        = {The Programming of Computer Art},
    author       = {Jill C. Knvth},
    date         = {1988-03-14},
    month        = feb,
    address      = {Stanford, California},
    note         = {This is a full BOOKLET entry},
    howpublished = {Vernier Art Center}
}"

cff_read_bib_text(bib)
#> - type: pamphlet
#>   title: The Programming of Computer Art
#>   authors:
#>   - family-names: Knvth
#>     given-names: Jill C.
#>   date-published: '1988-03-14'
#>   month: '2'
#>   location:
#>     name: Stanford, California
#>   notes: This is a full BOOKLET entry
#>   medium: Vernier Art Center
#>   year: '1988'

toBibtex(cff_read_bib_text(bib))
#> @Booklet{knvth:1988,
#>   title = {The Programming of Computer Art},
#>   author = {Jill C. Knvth},
#>   year = {1988},
#>   month = {feb},
#>   address = {Stanford, California},
#>   note = {This is a full BOOKLET entry},
#>   howpublished = {Vernier Art Center},
#>   date = {1988-03-14},
#> }
```

### @conference / @inproceedings

In this case, **organization** is mapped to `institution`. **series** is
ignored because there is no clear mapping in CFF for this field.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@conference / @inproceedings** | `type: conference-paper, conference` |  |
| **author** (required) | `authors` |  |
| **title** (required) | `title` |  |
| **booktitle** (required) | `collection-title` and `conference` | Additionally `collection-type` would be populated as “proceedings” |
| **year** (required) | `year` |  |
| **editor** | `editors` |  |
| **volume** | `volume` |  |
| **number** | `issue` |  |
| **series** | Ignored |  |
| **pages** | `start` and `end` |  |
| **address** | `address` property of `conference` |  |
| **month** | `month` |  |
| **organization** | `institution` |  |
| **publisher** | `publisher` |  |
| **note** | `notes` |  |

Table 15: **@conference / @inproceedings** model

**Round-trip**

``` r

bib <- "@inproceedings{inproceedings-full,
    title        = {On Notions of Information Transfer in {VLSI} Circuits},
    author       = {Alfred V. Oaho and Jeffrey D. Ullman and Mihalis Yannakakis},
    year         = 1983,
    month        = mar,
    booktitle    = {Proc. Fifteenth Annual ACM Symposium on the Theory of Computing},
    publisher    = {Academic Press},
    address      = {Boston},
    series       = {All ACM Conferences},
    number       = 17,
    pages        = {133--139},
    editor       = {Wizard V. Oz and Mihalis Yannakakis},
    organization = {The OX Association for Computing Machinery}
}"

cff_read_bib_text(bib)
#> - type: conference-paper
#>   title: On Notions of Information Transfer in VLSI Circuits
#>   authors:
#>   - family-names: Oaho
#>     given-names: Alfred V.
#>   - family-names: Ullman
#>     given-names: Jeffrey D.
#>   - family-names: Yannakakis
#>     given-names: Mihalis
#>   year: '1983'
#>   month: '3'
#>   collection-title: Proc. Fifteenth Annual ACM Symposium on the Theory of Computing
#>   collection-type: proceedings
#>   publisher:
#>     name: Academic Press
#>   issue: '17'
#>   editors:
#>   - family-names: Oz
#>     given-names: Wizard V.
#>   - family-names: Yannakakis
#>     given-names: Mihalis
#>   institution:
#>     name: The OX Association for Computing Machinery
#>   start: '133'
#>   end: '139'
#>   conference:
#>     name: Proc. Fifteenth Annual ACM Symposium on the Theory of Computing
#>     address: Boston

toBibtex(cff_read_bib_text(bib))
#> @InProceedings{oaho_etall:1983,
#>   title = {On Notions of Information Transfer in VLSI Circuits},
#>   author = {Alfred V. Oaho and Jeffrey D. Ullman and Mihalis Yannakakis},
#>   year = {1983},
#>   month = {mar},
#>   booktitle = {Proc. Fifteenth Annual ACM Symposium on the Theory of Computing},
#>   publisher = {Academic Press},
#>   address = {Boston},
#>   editor = {Wizard V. Oz and Mihalis Yannakakis},
#>   number = {17},
#>   pages = {133--139},
#>   organization = {The OX Association for Computing Machinery},
#> }
```

### @incollection

Because **booktitle** is a required field, we propose to map that field
to `collection-title` and the `type` to `generic`. Therefore, an
**@incollection** is a `type: generic` in CFF with a `collection-title`
key. The `generic` type is used as a fallback when no semantically
equivalent CFF type exists.

Additionally, **series** and **type** are ignored because there is no
clear mapping in CFF for these fields.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@incollection** | `type: generic` | Including a `collection-title` value |
| **author** (required) | `authors` |  |
| **title** (required) | `title` |  |
| **booktitle** (required) | `collection-title` | Additionally `collection-type` would be populated as “collection” |
| **publisher** (required) | `publisher` |  |
| **year** (required) | `year` |  |
| **editor** | `editors` |  |
| **volume** | `volume` |  |
| **number** | `issue` |  |
| **series** | Ignored |  |
| **type** | Ignored |  |
| **chapter** | `section` |  |
| **pages** | `start` and `end` |  |
| **address** | `address` property of `publisher` |  |
| **edition** | `edition` |  |
| **month** | `month` |  |
| **note** | `notes` |  |

Table 16: **@incollection** model

**Round-trip**

``` r

bib <- "@incollection{incollection-full,
    title        = {Semigroups of Recurrences},
    author       = {Daniel D. Lincoll},
    year         = 1977,
    month        = sep,
    booktitle    = {High Speed Computer and Algorithm Organization},
    publisher    = {Academic Press},
    address      = {New York},
    series       = {Fast Computers},
    number       = 23,
    pages        = {179--183},
    note         = {This is a full INCOLLECTION entry},
    editor       = {David J. Lipcoll and D. H. Lawrie and A. H. Sameh},
    chapter      = 3,
    type         = {Part},
    edition      = {Third}
}"

cff_read_bib_text(bib)
#> - type: generic
#>   title: Semigroups of Recurrences
#>   authors:
#>   - family-names: Lincoll
#>     given-names: Daniel D.
#>   year: '1977'
#>   month: '9'
#>   collection-title: High Speed Computer and Algorithm Organization
#>   collection-type: collection
#>   publisher:
#>     name: Academic Press
#>     address: New York
#>   issue: '23'
#>   notes: This is a full INCOLLECTION entry
#>   editors:
#>   - family-names: Lipcoll
#>     given-names: David J.
#>   - family-names: Lawrie
#>     given-names: D. H.
#>   - family-names: Sameh
#>     given-names: A. H.
#>   section: '3'
#>   edition: Third
#>   start: '179'
#>   end: '183'

toBibtex(cff_read_bib_text(bib))
#> @InCollection{lincoll:1977,
#>   title = {Semigroups of Recurrences},
#>   author = {Daniel D. Lincoll},
#>   year = {1977},
#>   month = {sep},
#>   booktitle = {High Speed Computer and Algorithm Organization},
#>   publisher = {Academic Press},
#>   address = {New York},
#>   editor = {David J. Lipcoll and D. H. Lawrie and A. H. Sameh},
#>   number = {23},
#>   pages = {179--183},
#>   note = {This is a full INCOLLECTION entry},
#>   chapter = {3},
#>   edition = {Third},
#> }
```

### @manual

As with [**@conference** / **@inproceedings**](#conf_inproc),
**organization** is mapped to `institution`.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@manual** | `type: manual` |  |
| **title** (required) | `title` |  |
| **author** | `authors` |  |
| **organization** | `institution` |  |
| **address** | `address` property of `organization` | On missing `organization` mapped to `location` |
| **edition** | `edition` |  |
| **month** | `month` |  |
| **year** | `year` |  |
| **note** | `notes` |  |

Table 17: **@manual** model

**Round-trip**

Note that **month** cannot be coerced to a single integer in the range
`1--12` as required in CFF, so it is ignored to avoid validation errors.

``` r

bib <- "@manual{manual-full,
  title        = {The Definitive Computer Manual},
    author       = {Larry Manmaker},
    year         = 1986,
    month        = {apr-may},
    address      = {Silicon Valley},
    note         = {This is a full MANUAL entry},
    organization = {Chips-R-Us},
    edition      = {Silver}
}"

cff_read_bib_text(bib)
#> - type: manual
#>   title: The Definitive Computer Manual
#>   authors:
#>   - family-names: Manmaker
#>     given-names: Larry
#>   year: '1986'
#>   month: '4'
#>   notes: This is a full MANUAL entry
#>   institution:
#>     name: Chips-R-Us
#>     address: Silicon Valley
#>   edition: Silver

toBibtex(cff_read_bib_text(bib))
#> @Manual{manmaker:1986,
#>   title = {The Definitive Computer Manual},
#>   author = {Larry Manmaker},
#>   year = {1986},
#>   month = {apr},
#>   address = {Silicon Valley},
#>   note = {This is a full MANUAL entry},
#>   edition = {Silver},
#>   organization = {Chips-R-Us},
#> }
```

### @mastersthesis / @phdthesis

In terms of fields required by BibTeX, it is identical for both
**@mastersthesis** and **@phdthesis.**

We propose here to identify each type of thesis using the key
`thesis-type`. If `thesis-type` contains a [regex
pattern](https://regex101.com/r/mBWfbs/1) `(?i)(phd)`, it is recognized
as **@phdthesis**.

Additionally, **school** is mapped to `institution`.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@mastersthesis, @phdthesis** | `type: thesis` | Use also `thesis-type` for identifying the thesis type. |
| **author** (required) | `authors` |  |
| **title** (required) | `title` |  |
| **school** (required) | `institution` |  |
| **year** (required) | `year` |  |
| **type** | Ignored |  |
| **address** | `address` property of `institution` |  |
| **month** | `month` |  |
| **note** | `notes` |  |

Table 18: **@mastersthesis / @phdthesis** model

**Round-trip: @mastersthesis**

``` r

bib <- "@mastersthesis{mastersthesis-full,
    title        = {Mastering Thesis Writing},
    author       = {Edouard Masterly},
    year         = 1988,
    month        = jun,
    address      = {English Department},
    note         = {This is a full MASTERSTHESIS entry},
    school       = {Stanford University},
    type         = {Master's project}
}"

cff_read_bib_text(bib)
#> - type: thesis
#>   title: Mastering Thesis Writing
#>   authors:
#>   - family-names: Masterly
#>     given-names: Edouard
#>   year: '1988'
#>   month: '6'
#>   notes: This is a full MASTERSTHESIS entry
#>   institution:
#>     name: Stanford University
#>     address: English Department
#>   thesis-type: Master's Thesis

toBibtex(cff_read_bib_text(bib))
#> @MastersThesis{masterly:1988,
#>   title = {Mastering Thesis Writing},
#>   author = {Edouard Masterly},
#>   year = {1988},
#>   month = {jun},
#>   address = {English Department},
#>   note = {This is a full MASTERSTHESIS entry},
#>   school = {Stanford University},
#> }
```

**Round-trip: @phdthesis**

``` r

bib <- "@phdthesis{phdthesis-full,
    title        = {Fighting Fire with Fire: Festooning {F}rench Phrases},
    author       = {F. Phidias Phony-Baloney},
    year         = 1988,
    month        = jun,
    address      = {Department of French},
    note         = {This is a full PHDTHESIS entry},
    school       = {Fanstord University},
    type         = {{PhD} Dissertation}
}"

cff_read_bib_text(bib)
#> - type: thesis
#>   title: 'Fighting Fire with Fire: Festooning French Phrases'
#>   authors:
#>   - family-names: Phony-Baloney
#>     given-names: F. Phidias
#>   year: '1988'
#>   month: '6'
#>   notes: This is a full PHDTHESIS entry
#>   institution:
#>     name: Fanstord University
#>     address: Department of French
#>   thesis-type: PhD Thesis

toBibtex(cff_read_bib_text(bib))
#> @PhdThesis{phonybaloney:1988,
#>   title = {Fighting Fire with Fire: Festooning French Phrases},
#>   author = {F. Phidias Phony-Baloney},
#>   year = {1988},
#>   month = {jun},
#>   address = {Department of French},
#>   note = {This is a full PHDTHESIS entry},
#>   school = {Fanstord University},
#> }
```

### @misc

The crosswalk for **@misc** does not require any special treatment. This
**entry** does not require any **field**.

Note also that it is mapped to `type: generic` as
[**@incollection**](#incol), but in this case **booktitle** is not even
an option, so the proposed definition should cover both **@misc** and
**@incollection** without problems.

| BibTeX           | CFF             | Notes |
|:-----------------|:----------------|:------|
| **@misc**        | `type: generic` |       |
| **author**       | `authors`       |       |
| **title**        | `title`         |       |
| **howpublished** | `medium`        |       |
| **month**        | `month`         |       |
| **year**         | `year`          |       |
| **note**         | `notes`         |       |

Table 19: **@misc** model

**Round-trip**

``` r

bib <- "@misc{misc-full,
    title        = {Handing out random pamphlets in airports},
    author       = {Joe-Bob Missilany},
    year         = 1984,
    month        = oct,
    note         = {This is a full MISC entry},
    howpublished = {Handed out at O'Hare}
}"

cff_read_bib_text(bib)
#> - type: generic
#>   title: Handing out random pamphlets in airports
#>   authors:
#>   - family-names: Missilany
#>     given-names: Joe-Bob
#>   year: '1984'
#>   month: '10'
#>   notes: This is a full MISC entry
#>   medium: Handed out at O'Hare

toBibtex(cff_read_bib_text(bib))
#> @Misc{missilany:1984,
#>   title = {Handing out random pamphlets in airports},
#>   author = {Joe-Bob Missilany},
#>   year = {1984},
#>   month = {oct},
#>   note = {This is a full MISC entry},
#>   howpublished = {Handed out at O'Hare},
#> }
```

### @proceedings

The proposed model is consistent with [**@conference** /
**@inproceedings**](#conf_inproc). Note that **@proceedings** does not
prescribe an **author** field. In these cases, as `authors` is required
in CFF, we use *anonymous*[^6] when mapping to CFF and omit it when
mapping from CFF to BibTeX.

| BibTeX | CFF | Notes |
|:---|:---|:---|
| **@proceedings** | `type: proceedings` |  |
| **title** (required) | `title` and `conference` |  |
| **year** (required) | `year` |  |
| **editor** | `editors` |  |
| **volume** | `volume` |  |
| **number** | `issue` |  |
| **series** | `collection-title` | Additionally `collection-type` would be populated as “proceedings” |
| **address** | `address` property of `conference` |  |
| **month** | `month` |  |
| **organization** | `institution` |  |
| **publisher** | `publisher` |  |
| **note** | `notes` |  |

Table 20: **@proceedings** model

**Round-trip**

``` r

bib <- "@proceedings{proceedings-full,
    title        = {Proc. Fifteenth Annual ACM Symposium on the Theory of Computing},
    year         = 1983,
    month        = mar,
    publisher    = {Academic Press},
    address      = {Boston},
    series       = {All ACM Conferences},
    number       = 17,
    note         = {This is a full PROCEEDINGS entry},
    editor       = {Wizard V. Oz and Mihalis Yannakakis},
    organization = {The OX Association for Computing Machinery}
}"

cff_read_bib_text(bib)
#> - type: proceedings
#>   title: Proc. Fifteenth Annual ACM Symposium on the Theory of Computing
#>   authors:
#>   - name: anonymous
#>   year: '1983'
#>   month: '3'
#>   publisher:
#>     name: Academic Press
#>   collection-title: All ACM Conferences
#>   collection-type: proceedings
#>   issue: '17'
#>   notes: This is a full PROCEEDINGS entry
#>   editors:
#>   - family-names: Oz
#>     given-names: Wizard V.
#>   - family-names: Yannakakis
#>     given-names: Mihalis
#>   institution:
#>     name: The OX Association for Computing Machinery
#>   conference:
#>     name: All ACM Conferences
#>     address: Boston

toBibtex(cff_read_bib_text(bib))
#> @Proceedings{oz_etall:1983,
#>   title = {Proc. Fifteenth Annual ACM Symposium on the Theory of Computing},
#>   year = {1983},
#>   month = {mar},
#>   publisher = {Academic Press},
#>   address = {Boston},
#>   editor = {Wizard V. Oz and Mihalis Yannakakis},
#>   series = {All ACM Conferences},
#>   number = {17},
#>   note = {This is a full PROCEEDINGS entry},
#>   organization = {The OX Association for Computing Machinery},
#> }
```

### @techreport

The crosswalk for **@techreport** does not require any special
treatment.

| BibTeX                     | CFF                                 | Notes |
|:---------------------------|:------------------------------------|:------|
| **@techreport**            | `type: report`                      |       |
| **author** (required)      | `authors`                           |       |
| **title** (required)       | `title`                             |       |
| **institution** (required) | `institution`                       |       |
| **year** (required)        | `year`                              |       |
| **type**                   | Ignored                             |       |
| **number**                 | `issue`                             |       |
| **address**                | `address` property of `institution` |       |
| **month**                  | `month`                             |       |
| **note**                   | `notes`                             |       |

Table 21: **@techreport** model

**Round-trip**

``` r

bib <- "@techreport{techreport-full,
    title        = {A Sorting Algorithm},
    author       = {Tom Terrific},
    year         = 1988,
    month        = oct,
    address      = {Computer Science Department, Fanstord, California},
    number       = 7,
    note         = {This is a full TECHREPORT entry},
    institution  = {Fanstord University},
    type         = {Wishful Research Result}
}"

cff_read_bib_text(bib)
#> - type: report
#>   title: A Sorting Algorithm
#>   authors:
#>   - family-names: Terrific
#>     given-names: Tom
#>   year: '1988'
#>   month: '10'
#>   issue: '7'
#>   notes: This is a full TECHREPORT entry
#>   institution:
#>     name: Fanstord University
#>     address: Computer Science Department, Fanstord, California

toBibtex(cff_read_bib_text(bib))
#> @TechReport{terrific:1988,
#>   title = {A Sorting Algorithm},
#>   author = {Tom Terrific},
#>   year = {1988},
#>   month = {oct},
#>   address = {Computer Science Department, Fanstord, California},
#>   number = {7},
#>   note = {This is a full TECHREPORT entry},
#>   institution = {Fanstord University},
#> }
```

### @unpublished

The crosswalk for **@unpublished** does not require any special
treatment.

| BibTeX                | CFF                 | Notes |
|:----------------------|:--------------------|:------|
| **@unpublished**      | `type: unpublished` |       |
| **author** (required) | `authors`           |       |
| **title** (required)  | `title`             |       |
| **note** (required)   | `notes`             |       |
| **month**             | `month`             |       |
| **year**              | `year`              |       |

Table 22: **@unpublished** model

**Round-trip**

``` r

bib <- "@unpublished{unpublished-minimal,
    title        = {Lower Bounds for Wishful Research Results},
    author       = {Ulrich Underwood and Ned Net and Paul Pot},
    note         = {Talk at Fanstord University (this is a minimal UNPUBLISHED entry)}
}"

cff_read_bib_text(bib)
#> - type: unpublished
#>   title: Lower Bounds for Wishful Research Results
#>   authors:
#>   - family-names: Underwood
#>     given-names: Ulrich
#>   - family-names: Net
#>     given-names: Ned
#>   - family-names: Pot
#>     given-names: Paul
#>   notes: Talk at Fanstord University (this is a minimal UNPUBLISHED entry)

toBibtex(cff_read_bib_text(bib))
#> @Unpublished{underwood_etall,
#>   title = {Lower Bounds for Wishful Research Results},
#>   author = {Ulrich Underwood and Ned Net and Paul Pot},
#>   note = {Talk at Fanstord University (this is a minimal UNPUBLISHED entry)},
#> }
```

## Conclusion

This article presents a practical and reproducible crosswalk between
BibTeX and CFF.

Although the formats are not fully equivalent, the deterministic mapping
implemented in **cffr** enables consistent transformations across
heterogeneous citation ecosystems. By making design decisions explicit
and documenting limitations, this work supports interoperable citation
workflows bridging legacy bibliographic systems and modern
software-centric practices.

## Appendix A: **@inbook** in BibTeX and BibLaTeX

The definition of **@inbook** and **@incollection** in BibTeX
([Patashnik 1988](#ref-patashnik1988)) is as follows:

> - **@inbook**: A part of a book, which may be a chapter (or section)
>   and/or a range of pages. Required fields: author or editor, title,
>   chapter and/or pages, publisher, year (…)
>
> - **@incollection**: A part of a book having its own title. Required
>   fields: author, title, booktitle, publisher, year (…)

Whereas BibLaTeX ([Kime et al. 2025](#ref-biblatexpack)) specifies:

> - **@inbook:** A part of a book which forms a self-contained unit with
>   its own title. Note that the *profile* of this entry type is
>   *different from standard BibTeX*, see § 2.3.1. Required fields:
>   author, title, booktitle, year/date (…).

When considering required fields, an important difference is the
**booktitle** requirement in BibLaTeX. Notably, BibTeX **@incollection**
also requires this field. Moreover, both BibTeX **@incollection** and
BibLaTeX **@inbook** emphasize its reference to *“a part of a book (…)
with its own title”*.

In this article, the proposed crosswalk ensures full compatibility with
BibTeX. Therefore, we propose to consider a BibLaTeX **@inbook** entry
as equivalent to a BibTeX **@incollection**, given the congruence in
their definitions and field requirements.

**Round-trip**

``` r

bib <- "@inbook{inbook-biblatex,
    author       = {Yihui Xie and Christophe Dervieux and Emily Riederer},
    title        = {Bibliographies and citations},
    booktitle    = {{R} Markdown Cookbook},
    date         = {2023-12-30},
    publisher    = {Chapman and Hall/CRC},
    address      = {Boca Raton, Florida},
    series       = {The {R} Series},
    isbn         = 9780367563837,
    url          = {https://yihui.org/rmarkdown-cookbook/},
    chapter      = {4.5}
}"

cff_read_bib_text(bib)
#> - type: generic
#>   title: Bibliographies and citations
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>   - family-names: Dervieux
#>     given-names: Christophe
#>   - family-names: Riederer
#>     given-names: Emily
#>   collection-title: R Markdown Cookbook
#>   collection-type: collection
#>   date-published: '2023-12-30'
#>   publisher:
#>     name: Chapman and Hall/CRC
#>     address: Boca Raton, Florida
#>   isbn: '9780367563837'
#>   url: https://yihui.org/rmarkdown-cookbook/
#>   section: '4.5'
#>   year: '2023'
#>   month: '12'

toBibtex(cff_read_bib_text(bib))
#> @InCollection{xie_etall:2023,
#>   title = {Bibliographies and citations},
#>   author = {Yihui Xie and Christophe Dervieux and Emily Riederer},
#>   year = {2023},
#>   month = {dec},
#>   booktitle = {R Markdown Cookbook},
#>   publisher = {Chapman and Hall/CRC},
#>   address = {Boca Raton, Florida},
#>   isbn = {9780367563837},
#>   url = {https://yihui.org/rmarkdown-cookbook/},
#>   chapter = {4.5},
#>   date = {2023-12-30},
#> }
```

## Appendix B: CFF key: `type` values

From Druskat et al. ([2019](#ref-druskat2019)), Table 4: complete list
of CFF reference types for key `type`. Only a subset of these types is
actively used in the proposed crosswalk.

| Reference type string | Description |
|:---|:---|
| `art` | A work of art, e.g., a painting |
| `article` |  |
| `audiovisual` |  |
| `bill` | A legal bill |
| `blog` | A blog post |
| `book` | A book or e-book |
| `catalogue` |  |
| `conference` |  |
| `conference-paper` |  |
| `data` | A data set |
| `database` | An aggregated or online database |
| `dictionary` |  |
| `edited-work` | An edited work, e.g., a book |
| `encyclopedia` |  |
| `film-broadcast` | A film or broadcast |
| `generic` | The fallback type |
| `government-document` |  |
| `grant` | A research or other grant |
| `hearing` |  |
| `historical-work` | A historical work, e.g., a medieval manuscript |
| `legal-case` |  |
| `legal-rule` |  |
| `magazine-article` |  |
| `manual` | A manual |
| `map` | A geographical map |
| `multimedia` | A multimedia file |
| `music` | A music file or sheet music |
| `newspaper-article` |  |
| `pamphlet` |  |
| `patent` |  |
| `personal-communication` |  |
| `proceedings` | Conference proceedings |
| `report` |  |
| `serial` |  |
| `slides` | Slides, i.e., a published slide deck |
| `software` | Software |
| `software-code` | Software source code |
| `software-container` | A software container (e.g., a docker container) |
| `software-executable` | An executable software, i.e., a binary/artifact |
| `software-virtual-machine` | A virtual machine/vm image |
| `sound-recording` |  |
| `standard` |  |
| `statute` |  |
| `thesis` | An academic thesis |
| `unpublished` |  |
| `video` | A video recording |
| `website` |  |

Table 23: Complete list of CFF reference types

## References

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, et al. 2021.
*Citation File Format*. Version 1.2.0. Zenodo.
<https://doi.org/10.5281/zenodo.5171937>.

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, Robert Haines, and
James Baker. 2019. *Citation File Format (CFF) - Specifications*.
Versions 1.0.3-4. Zenodo. <https://doi.org/10.5281/zenodo.3515946>.

Haines, Robert, and The Ruby Citation File Format Developers. 2022.
*Ruby CFF Library*. Version 1.0.1. Zenodo.
<https://doi.org/10.5281/zenodo.7294987>.

Hernangómez, Diego. 2021. “cffr: Generate Citation File Format Metadata
for R Packages.” *Journal of Open Source Software* 6 (67): 3900.
<https://doi.org/10.21105/joss.03900>.

Kime, Philip, Moritz Wemheuer, and Philipp Lehman. 2025. *The biblatex
Package*.
<https://osl.ugr.es/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf>.

Patashnik, Oren. 1988. *BIBTEXing*.
<https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.

Patashnik, Oren. 2010. *CTAN: Package Bibtex*. Version 0.99e.
<https://ctan.org/pkg/bibtex>.

R Core Team. 2026. *R: A Language and Environment for Statistical
Computing*. R Foundation for Statistical Computing.
<https://doi.org/10.32614/R.manuals>.

Rees, Clea F. 2017. *BibLaTeX Cheat Sheet*.
<https://osl.ugr.es/CTAN/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf>.

[^1]: See a complete list of possible values of CFF `type` in [Appendix
    B](#appendix_cff_type)

[^2]: This software performs only the mapping from CFF to BibTeX, but
    **cffr** can perform the mapping in both directions.

[^3]: Note that BibLaTeX ([Kime et al. 2025](#ref-biblatexpack)) handles
    **@inbook** differently, see [Appendix A](#appendix_inbook).

[^4]: See [Appendix B](#appendix_cff_type) for all possible values.
    Information extracted from Druskat et al.
    ([2019](#ref-druskat2019)).

[^5]: See Rees ([2017](#ref-biblatexcheatsheet)) for a preview of the
    accepted BibLaTeX fields.

[^6]: As proposed on [*How to deal with unknown individual
    authors?*](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#how-to-deal-with-unknown-individual-authors),
    **(Guide to Citation File Format schema version 1.2.0)**.
