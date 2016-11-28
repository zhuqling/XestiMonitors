#!/bin/sh

set -e

gituser=eBardX
module="XestiMonitors"
podspec="$module.podspec"
scheme="$module"
workspace="Example/$module.xcworkspace"
version=$(sed -En "/s.version[[:space:]]*=/s/^.*\\'(.*)\\'.*$/\1/gp" $podspec)

if git rev-parse "v$version" >/dev/null 2>&1; then
    # Use the tagged commit when we have one
    ref="v$version"
else
    # Otherwise, use the current commit.
    ref="$(git rev-parse HEAD)"
fi

jazzy --author "J. G. Pusey"                                                \
      --author_url "http://ebardx.tumblr.com/"                              \
      --clean                                                               \
      --copyright "© 2016 J. G. Pusey"                                      \
      --github_url "https://github.com/$gituser/$module"                    \
      --github-file-prefix "https://github.com/$gituser/$module/tree/$ref"  \
      --module "$module"                                                    \
      --module-version "$version"                                           \
      --output Documentation                                                \
      --readme README.md                                                    \
      --root-url "https://$gituser.github.io/$module/reference/"            \
      --skip-undocumented                                                   \
      --theme apple                                                         \
      --xcodebuild-arguments "-workspace,$workspace,-scheme,$scheme"