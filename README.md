# homebrew-osvr
This is a HEAD-only tap for [OSVR](http://www.osvr.org) (Open Source Virtual Reality). It is very much in development, and breakage should be expected!

To install, simply run:
```
brew tap OSVR/osvr

brew install jsoncpp --HEAD # Release version is too old for us
brew install osvr-core --HEAD
```

To install the SteamVR-OSVR plugin, run:
```
brew install steamvr-osvr --HEAD```
Be sure to follow the post-install instructions so that SteamVR can find the plugin.

In order for these packages to work with games such as Team Fortress 2, SteamVR-OSVR, OSVR-Core, and the dependencies need to be build as universal binaries (which can be done with the --universal flag for Homebrew). Unfortunately, due to a [bug in CMake](https://cmake.org/Bug/view.php?id=15835) this will currently fail.
