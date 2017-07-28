#!/bin/bash

PERL_SELECTION="$(perlbrew list)"
PERL_VERSION=${PERL_SELECTION#\* }
perlbrew switch $PERL_VERSION

