#!/bin/bash

# This script uses a database of languages, fonts, and translations to read in
# the template title pages and spit out translated title pages with the
# appropriate fonts set.  The generated title pages will need to be tweaked for
# font size and element positions.
#
# Author:
#   Kevin Godby <kevin@ubuntu-manual.org>

TEMPLATE_AFOUR="title_page_a4_template.svg"
TEMPLATE_AFOUR_RTL="title_page_a4_right-to-left_template.svg"
TEMPLATE_LETTER="title_page_letter_template.svg"

LOCALE_DATABASE="ubuntu-manual-locale.db"

TEMPLATE_TITLE_STRING="Getting Started with Ubuntu 10.04"
TEMPLATE_AUTHOR_STRING="The Ubuntu Manual Team"
TEMPLATE_EDITION_STRING="Second Edition"
TEMPLATE_FONT_STRING="Linux Biolinum O"

DEFAULT_SERIF_FONT="Linux Libertine O"
DEFAULT_SANS_FONT="Linux Biolinum O"
DEFAULT_MONO_FONT="Bera Sans Mono"
DEFAULT_PAPER_SIZE="a4"
DEFAULT_TEXT_DIR="ltr"

POFILES_DIR="../po/"
MOFILES_DIR="/tmp/ubuntu-manual/locale/"

export TEXTDOMAIN="ubuntu-manual"
export TEXTDOMAINDIR="$MOFILES_DIR"


# Compile the po files into mo files and store in MOFILES_DIR
echo "Removing $MOFILES_DIR..."
rm -fr $MOFILES_DIR
echo "Compiling po files into mo files..."
for POFILE in $POFILES_DIR/*.po; do
    LANGCODE=$(basename $POFILE .po)
    mkdir -p "$MOFILES_DIR/$LANGCODE/LC_MESSAGES/"
    msgfmt -o "$MOFILES_DIR/$LANGCODE/LC_MESSAGES/$TEXTDOMAIN.mo" "$POFILE"
done

# Generate the title pages
for POFILE in $POFILES_DIR/*.po; do
    LANGCODE=$(basename $POFILE .po)
    TITLE_STRING=$(LANGUAGE=$LANGCODE gettext -d $TEXTDOMAIN -s "$TEMPLATE_TITLE_STRING")
    AUTHOR_STRING=$(LANGUAGE=$LANGCODE gettext -d $TEXTDOMAIN -s "$TEMPLATE_AUTHOR_STRING")
    EDITION_STRING=$(LANGUAGE=$LANGCODE gettext -d $TEXTDOMAIN -s "$TEMPLATE_EDITION_STRING")
    SERIF_FONT=$(echo "SELECT serif_font FROM locale WHERE language_code=\"$LANGCODE\";" | sqlite3 $LOCALE_DATABASE)
    SANS_FONT=$(echo "SELECT sans_font FROM locale WHERE language_code=\"$LANGCODE\";" | sqlite3 $LOCALE_DATABASE)
    MONO_FONT=$(echo "SELECT mono_font FROM locale WHERE language_code=\"$LANGCODE\";" | sqlite3 $LOCALE_DATABASE)
    PAPER_SIZE=$(echo "SELECT paper_size FROM locale WHERE language_code=\"$LANGCODE\";" | sqlite3 $LOCALE_DATABASE)
    TEXT_DIR=$(echo "SELECT direction FROM locale WHERE language_code=\"$LANGCODE\";" | sqlite3 $LOCALE_DATABASE)
    if [ -z "$SERIF_FONT" ]; then SERIF_FONT=$DEFAULT_SERIF_FONT; fi
    if [ -z "$SANS_FONT" ]; then SANS_FONT=$DEFAULT_SANS_FONT; fi
    if [ -z "$MONO_FONT" ]; then MONO_FONT=$DEFAULT_MONO_FONT; fi
    if [ -z "$PAPER_SIZE" ]; then PAPER_SIZE=$DEFAULT_PAPER_SIZE; fi
    if [ -z "$TEXT_DIR" ]; then TEXT_DIR=$DEFAULT_TEXT_DIR; fi
    echo "[$LANGCODE] Title: $TITLE_STRING"
    echo "[$LANGCODE] Author: $AUTHOR_STRING"
    echo "[$LANGCODE] Edition: $EDITION_STRING"
    echo "[$LANGCODE] Serif font: $SERIF_FONT"
    echo "[$LANGCODE] Sans font: $SANS_FONT"
    echo "[$LANGCODE] Mono font: $MONO_FONT"
    echo "[$LANGCODE] Paper size: $PAPER_SIZE"
    echo "[$LANGCODE] Text direction: $TEXT_DIR"

    # Use text figures if possible
    TITLE_STRING=$(echo "$TITLE_STRING" | sed -e "s/10.04/./g")

    SVG_TEMPLATE=$TEMPLATE_AFOUR
    if [ "$PAPER_SIZE" == "letter" ]; then SVG_TEMPLATE=$TEMPLATE_LETTER; fi
    if [ "$PAPER_SIZE" == "a4" -a "$TEXT_DIR" == "rtl" ]; then SVG_TEMPLATE=$TEMPLATE_AFOUR_RTL; fi

    SVG_FILE="titlepage-$LANGCODE.svg"

    echo "[$LANGCODE] Generated translated title page..."
    sed -e "s/$TEMPLATE_TITLE_STRING/$TITLE_STRING/g" \
        -e "s/$TEMPLATE_AUTHOR_STRING/$AUTHOR_STRING/g" \
        -e "s/$TEMPLATE_EDITION_STRING/$EDITION_STRING/g" \
        -e "s/$DEFAULT_SERIF_FONT/$SERIF_FONT/g" \
        -e "s/$DEFAULT_SANS_FONT/$SANS_FONT/g" \
        -e "s/$DEFAULT_MONO_FONT/$MONO_FONT/g" \
        $SVG_TEMPLATE > $SVG_FILE
    echo ""
done

exit 0

