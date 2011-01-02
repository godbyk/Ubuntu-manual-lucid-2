#!/bin/bash

# This script verifies that all the LaTeX-related dependencies have been installed and helps install any missing dependencies.

LOGFILE=install-pkgs.log

#
# Useful functions
#


# Define some pretty colors
BLACK='\E[30m'
RED='\E[31m'
GREEN='\E[32m'
YELLOW='\E[33m'
BLUE='\E[34m'
MAGENTA='\E[35m'
CYAN='\E[36m'
WHITE='\E[37m'

NORMAL='NORMAL'
ERROR=$RED
WARNING=$YELLOW
OKAY=$GREEN
STATUS=''

# Prints a colored message to the screen.
#
# Parameters:
#   $1 ANSI color code
#   $2 message
#
# Returns nothing of import.
cecho () {
    if [ "$1" != "$NORMAL" ]; then
        echo -ne $1 # echo ANSI color code
    fi
    echo $2 # print message
    echo $2 >> $LOGFILE # log message
    tput sgr0 # reset colors
    return
}

# Checks to see if a TeX package (.sty file) is installed.
#
# Parameters:
#   $1 package name
#
# Returns 0 if package is installed, 1 otherwise.
check_tex_pkg () {
    echo -n "Checking $1 TeX file..." 2>&1 | tee --append $LOGFILE
    TEX_PKG_INSTALLED=$(kpsewhich $1)
    if [ -z "$TEX_PKG_INSTALLED" ]; then
        cecho $ERROR "not installed!"
        return 1
    else
        cecho $OKAY "installed!"
        return 0
    fi
}

# Checks to see if an Ubuntu package is installed.
#
# Parameters:
#   $1 package name
#
# Returns 0 if package is installed, 1 otherwise.
check_ubuntu_pkg () {
    echo -n "Checking $1 Ubuntu package..." 2>&1 | tee --append $LOGFILE
    dpkg-query -s $1 >> $LOGFILE 2>&1
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -ne 0 ]; then
        cecho $ERROR "not found."
        return 1
    else
        cecho $OKAY "installed."
        return 0
    fi
}

# Checks for the existence of executable files in the path.
#
# Parameters:
#   $1 executeable filename
#
# Returns 0 if executable is found, 1 otherwise.
check_exec_file() {
    echo -n "Checking for executable file $1..." 2>&1 | tee --append $LOGFILE
    which $1 >> $LOGFILE 2>&1
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -ne 0 ]; then
        cecho $ERROR "not found."
        return 1
    else
        cecho $OKAY "found."
        return 0
    fi
}

# Unzips a file (overwriting existing files).
#
# Parameters:
#   $1 zip file name
#
# Returns 0 if zip file is successfully unzipped, 1 otherwise.
unzip_file() {
    unzip -o $1 >> $LOGFILE 2>&1 || (cecho $ERROR "Error unzipping $1. See $LOGFILE for details."; exit 1)
    return 0
}

# Run LaTeX against an .ins file.
#
# Parameters:
#   $1 the .ins filename
#
# Returns 0 if ins file is successfully LaTeX'd, 1 otherwise.
latex_file() {
    yes | latex $1 >> $LOGFILE 2>&1 || (cecho $ERROR "Error running LaTeX against $1.  See $LOGFILE for details."l; exit 1)
    return 0
}

# Create a directory path.
#
# Parameters:
#   $1 directory path
#
# Returns 0 if path was successfully created, 1 otherwise.
mkpath() {
    mkdir -pv $1 >> $LOGFILE 2>&1 || (cecho $ERROR "Error creating directory $1. See $LOGFILE for details."; exit 1)
    return 0
}

# Copies a file.
#
# Parameters:
#   $1 source file
#   $2 destination
#
# Returns 0 if file was successfully copied, 1 otherwise.
install_file() {
    cp -v $1 $2 >> $LOGFILE 2>&1 || (echo $ERROR "Error copy $1 to $2. See $LOGFILE for details."; exit 1)
    return 0
}

# Installs the ccicons package.
install_ccicons () {
    cecho $STATUS "Installing ccicons package..."
    cecho $STATUS "Unpacking ccicons TeX package..."
    unzip_file ccicons.zip

    cecho $STATUS "Generating ccicons style and font files..."
    cd ccicons; latex_file ccicons.ins; cd ..

    cecho $STATUS "Creating local TEXMF directory tree for ccicons..."
    mkpath ~/texmf/doc/latex/ccicons
    mkpath ~/texmf/fonts/enc/dvips/ccicons
    mkpath ~/texmf/fonts/map/dvips/ccicons
    mkpath ~/texmf/fonts/tfm/public/ccicons
    mkpath ~/texmf/fonts/type1/public/ccicons
    mkpath ~/texmf/tex/latex/ccicons

    cecho $STATUS  "Installing ccicons TeX package..."
    install_file ccicons/ccicons.pdf   ~/texmf/doc/latex/ccicons
    install_file ccicons/ccicons-u.enc ~/texmf/fonts/enc/dvips/ccicons
    install_file ccicons/ccicons.map   ~/texmf/fonts/map/dvips/ccicons
    install_file ccicons/ccicons.tfm   ~/texmf/fonts/tfm/public/ccicons
    install_file ccicons/ccicons.pfb   ~/texmf/fonts/type1/public/ccicons
    install_file ccicons/ccicons.sty   ~/texmf/tex/latex/ccicons
    install_file ccicons/uccicons.fd   ~/texmf/tex/latex/ccicons

    rm -fr ccicons || (cecho $ERROR "Error removing extracted ccicons files. See $LOGFILE for details."; exit 1)

    cecho $STATUS "Adding ccicons font to TeX's index (this may take a while)..."
    updmap --enable Map ccicons.map >> $LOGFILE 2>&1 || (cecho $ERROR "Error updating LaTeX font mapping.  See $LOGFILE for details."; exit 1)

    REINDEX_REQUIRED=1
}

# Reindex the TEXMF directory.
reindex_texmf() {
    if [ $REINDEX_REQUIRED -ne 0 ]; then
        cecho $STATUS "Indexing local TEXMF directory (this may take a while)..."
        mktexlsr >> $LOGFILE 2>&1 || (cecho $ERROR "Error updating TEXMF index.  See $LOGFILE for details."; exit 1)
    #else
    #    cecho $NORMAL "No need to index the local TEXMF directory."
    fi
    return
}

# Determines the version of TeX Live that is installed
# Returns 0 if TeX Live 2009 is installed,
#         1 if an oldver version of TeX Love 2009 is installed,
#         2 if no version of TeX Live is installed.
check_tex_live_version() {
    echo -n "Checking TeX Live version..." 2>&1 | tee --append $LOGFILE
    TEXLIVE_VERSION="0"
    (dpkg-query -s texlive-base 2>&1 | grep "^Status: install" && dpkg-query -s texlive-base 2>&1 | grep "^Version: 2007" 2>&1) && TEXLIVE_VERSION="2007"
    (dpkg-query -s texlive-base 2>&1 | grep "^Status: install" && dpkg-query -s texlive-base 2>&1 | grep "^Version: 2009" 2>&1) && TEXLIVE_VERSION="lucid-2009"
    which tlmgr > /dev/null && TEXLIVE_VERSION="2009"
    case $TEXLIVE_VERSION in
        0)
            cecho $WARNING "No version of TeX Live was detected."
            return 2
            ;;
        2007)
            cecho $WARNING "TeX Live 2007 detected."
            return 1
            ;;
        lucid-2009)
            cecho $WARNING "TeX Live 2009 Lucid package detected."
            return 3
            ;;
        2009)
            cecho $OKAY "TeX Live 2009 detected."
            return 0
            ;;
        *)
            cecho $ERROR "Unexpected outcome in TeX Live detection routine: TEXLIVE_VERSION=\"$TEXLIVE_VERSION\""
            exit 1
            ;;
    esac
}

#
# Main loop
#

# Clear any old logfiles.
if [ -e $LOGFILE ]; then
    rm -f $LOGFILE
    echo $(basename $0 .sh).log $(date) > $LOGFILE
    echo "" >> $LOGFILE
fi

# Check to see which version of TeX Live is installed.
check_tex_live_version
TEXLIVE_VERSION_STATUS=$?

case $TEXLIVE_VERSION_STATUS in
    0)
        # 2009 is installed
        # We'll keep running the script
        ;;
    1)
        # 2007 is installed
        echo "It appears that you have TeX Live 2007 installed.  Unfortunately, you can not "
        echo "compile the Ubuntu Manual with TeX Live 2007.  Please remove TeX Live 2007 and "
        echo "install TeX Live 2009.  See the Ubuntu Manual website for instructions:"
        echo ""
        echo "   http://ubuntu-manual.org/getinvolved/authors#install-tl2009"
        echo ""
        exit 1
        ;;
    2)
        # no version is installed
        echo "It appears that you do not have TeX Live 2009 installed.  Please follow the"
        echo "installation instructions on the Ubuntu Manual wiki to install TeX Live 2009:"
        echo ""
        echo "   http://ubuntu-manual.org/getinvolved/authors#install-tl2009"
        echo ""
        exit 1
        ;;
    3)
        # 2009 Lucid package is installed
        echo "It appears that you have TeX Live 2009 installed from the Lucid repositories. "
        echo "Unfortunately, you can not compile the Ubuntu Manual with TeX Live 2009 from "
        echo "the Lucid repositories.  Please remove the TeX Live 2009 packages and install "
        echo "TeX Live 2009 from upstream.  See the Ubuntu Manual website for instructions:"
        echo ""
        echo "   http://ubuntu-manual.org/getinvolved/authors#install-tl2009"
        echo ""
        exit 1
        ;;
esac


# Check for missing TeX packages
echo $NORMAL "Checking installed TeX packages..."
TEX_PACKAGES=""
REQURED_TEX_PACKAGES="xkeyval xifthen etex ifmtarg ifxetex xcolor wrapfig setspace geometry listings url graphics fancyhdr titlesec makeidx eso-pic atbegshi.sty,oberdiek paralist comment multicol pifont.sty,psnfss textcase substr ccicons hyperref siunitx amstext.sty,amsmath array.sty,tools xltxtra fontspec eu1enc.def,euenc xunicode metalogo polyglossia etoolbox csquotes tipa babel xmpincl microtype rpzdr.tfm,zapfding rpsyr.tfm,collection-fontsrecommended lmroman10-regular.otf,lm beramono.sty,bera libertine glossaries xfor todonotes enumitem tufte-book.cls,tufte-latex changepage soul natbib bidi optparams.sty,sauerj placeins lipsum hyphenat "
for PKG in $REQURED_TEX_PACKAGES; do
    STYLE=$PKG.sty
    TEXPKG=$PKG
    echo "$PKG" | grep -q ','
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -eq 0 ]; then
        STYLE=$(echo $PKG | sed -e 's/,.*$//')
        TEXPKG=$(echo $PKG | sed -e 's/^.*,//')
    fi
    check_tex_pkg $STYLE || TEX_PACKAGES="$TEX_PACKAGES $TEXPKG"
done

REQUIRED_TEX_BINARIES="xindy"
for PKG in $REQUIRED_TEX_BINARIES; do
    TEXEXEC=$PKG
    TEXPKG=$PKG
    echo "$PKG" | grep -q ','
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -eq 0 ]; then
        TEXEXEC=$(echo $PKG | sed -e 's/,.*$//')
        TEXPKG=$(echo $PKG | sed -e 's/^.*,//')
    fi
    check_exec_file $TEXEXEC || TEX_PACKAGES="$TEX_PACKAGES $TEXPKG"
done

if [ ! -z "$TEX_PACKAGES" ]; then
    cecho $STATUS "Installing required TeX packages..."
    for PKG in $TEX_PACKAGES; do
        cecho $STATUS "  Installing $PKG TeX package..."
        sudo tlmgr install $PKG >> $LOGFILE 2>&1
        EXIT_STATUS=$?
        if [ $EXIT_STATUS -ne 0 ]; then
            cecho $ERROR "Error installing TeX packages.  See $LOGFILE for details."
            exit 1
        else
            cecho $OKAY "done!"
        fi
    done
else
    cecho $OKAY "Required TeX packages are already installed."
fi


# Make sure the Ubuntu packages are installed first.
cecho $NORMAL "Checking installed Ubuntu packages..."
REQUIRED_UBUNTU_PACKAGES="python-enchant inkscape make po4a ttf-kacst ttf-arabeyes ttf-bengali-fonts ttf-devanagari-fonts ttf-telugu-fonts ttf-thai-arundina ttf-thai-tlwg ttf-linux-libertine ttf-dejavu ttf-dejavu-core ttf-dejavu-extra ttf-sil-scheherazade ttf-farsiweb ttf-sazanami-mincho"
UBUNTU_PACKAGES=""
for PKG in $REQUIRED_UBUNTU_PACKAGES; do
    check_ubuntu_pkg $PKG || UBUNTU_PACKAGES="$UBUNTU_PACKAGES $PKG"
done

if [ ! -z "$UBUNTU_PACKAGES" ]; then
    cecho $STATUS "Installing required Ubuntu packages..."
    sudo apt-get install $UBUNTU_PACKAGES --assume-yes >> $LOGFILE 2>&1 || (cecho $ERROR "Error installing Ubuntu packages.  See $LOGFILE for details."; exit 1)
else
    cecho $OKAY "Required Ubuntu packages are already installed."
fi

# Now install the ccicons package.
#check_tex_pkg ccicons || install_ccicons

# If required, reindex the TEXMF directory.
#reindex_texmf

cecho $OKAY "Done!  You should now be able to compile the Ubuntu manual!"

