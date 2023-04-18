# About

I don't like how Lightspeed makes their macOS packages. Here's the main reasons:

* They don't properly version their packages within a distribution package
* They needlessly use Ruby in pkg scripts
* They embed a configuration file in the outer DMG and the pkg scripts expect to be able to access it

This repo contains a script to rebuild Lightspeed's pkg into a more MacAdmin friendly version using [munki-pkg](https://github.com/munki/munki-pkg). The new pkg will be properly versioned and will contain the configuration file in the package itself. It also cleans up older versions of Smart Agent

# Building

* Clone this repo and `cd` into it
* Download your SmartAgent.dmg file name it SmartAgent-$VERSION.dmg (e.g. SmartAgent-2.2.0.dmg)
* Update build-info.json and build.sh with the same $VERSION from the step above
* Run `./build.sh`
* The pkg will be built at ./build/relay-smart-agent-$VERSION.pkg

# Caveats

* This package will not handle certificate deployment. You should handle that with your MDM
* This package currently requires a restart after installation to properly filter devices in most cases
    * The package itself doesn't force a restart; you should handle that with whatever system you use to deploy it
    * This may be fixable after more investigation into the various services used by Relay
