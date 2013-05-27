#! /bin/bash

#
# Remove macports from this machine
#
# http://guide.macports.org/chunked/installing.macports.uninstalling.html


# Remove all the ports
sudo port -fp uninstall installed

# Remove all of the installation directories
sudo rm -rf \
    /opt/local \
    /Applications/DarwinPorts \
    /Applications/MacPorts \
    /Library/LaunchDaemons/org.macports.* \
    /Library/Receipts/DarwinPorts*.pkg \
    /Library/Receipts/MacPorts*.pkg \
    /Library/StartupItems/DarwinPortsStartup \
    /Library/Tcl/darwinports1.0 \
    /Library/Tcl/macports1.0 \
    ~/.macports


