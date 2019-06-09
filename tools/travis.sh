#!/bin/bash
#
# Run the build mode specified by the BUILD variable, defined in
# .travis.yml. When the variable is unset, assume we should run the
# standard test suite.

rootdir=$(dirname $(dirname $0))

# Show the commands being run.
set -x

# Exit on any error.
set -e

case "$BUILD" in
    docs)
        sphinx-build -W -b html doc/source doc/build;
        sphinx-build -b json doc/source doc/build;
        sphinx-build -b latex doc/source doc/build;
        sphinx-build -b epub doc/source doc/build;;
    linter)
        flake8 sphinxcontrib setup.py;;
    *)
        python setup.py test \
               --coverage \
               --coverage-package-name=sphinxcontrib.datatemplates \
               --slowest \
               --testr-args="$@";
        coverage report --show-missing;;
esac
