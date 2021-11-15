#!/bin/bash
# Adapted from https://github.com/lorenzwalthert/precommit/blob/main/inst/bin/readme-rmd-rendered
MSG="use 'git commit --no-verify' to override this check"

# No CITATION.cff
if [[ ! -f "CITATION.cff" ]]; then
  exit 0
fi

# Check commit

CITATION=($(git diff --cached --name-only | grep -Ei '^CITATION\.cff$'))
DESC=($(git diff --cached --name-only | grep -Ei '^DESCRIPTION$'))
CIT=($(git diff --cached --name-only | grep -Ei '^inst\/CITATION$'))

# If DESCRIPTION staged but not CITATION.cff
if [[ ! -z "$DESC" && -z "$CITATION" ]]; then
  if [[ DESCRIPTION -nt CITATION.cff ]]; then
    echo -e "CITATION.cff may be outdated; please use cff_write()\n$MSG"
    exit 1
  elif [[ CITATION.cff -nt DESCRIPTION ]]; then
    echo -e "Remember to stage both CITATION.cff and DESCRIPTION\n$MSG"
    exit 1
  fi
fi

# If inst/CITATION staged but not CITATION.cff
if [[ ! -z "$CIT" && -z "$CITATION" ]]; then
  if [[ inst/CITATION -nt CITATION.cff ]]; then
    echo -e "CITATION.cff may be outdated; please use cff_write()\n$MSG"
    exit 1
  elif [[ CITATION.cff -nt inst/CITATION ]]; then
    echo -e "Remember to stage both CITATION.cff and inst/CITATION\n$MSG"
    exit 1
  fi
fi
