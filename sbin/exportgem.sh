#!/bin/sh
#Copy up to rubygem.org

#ensure the github code is up to date, and tagged as a release version
. version
git add .
git commit -m "#{PROJECT} release ${VERSION}"
git tag -a ${VERSION} -m "#{PROJECT} release ${VERSION}"
git push origin

chdir gitdoc
git tag -a ${VERSION} -m "#{PROJECT} Doc release ${VERSION}"
git add .
git commit -m "Autogen Yard Docs"
git push --set-upstream origin gh-pages

chdir ..
/usr/local/bin/rake release VERSION=${VERSION} #--trace
