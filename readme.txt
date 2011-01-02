< Last Edited: 17th January 2010 by Kevin Godby />


Hello and welcome to the Ubuntu Manual Project. Before you start editing files,
please make sure you are familiar with the procedure on the wiki, and also read
the rest of this readme.

Technical Help with LaTeX and bzr can be found here: https://wiki.ubuntu.com/ubuntu-manual/Help

You will need to install some LaTeX packages that don't come with Ubuntu (and
some that do).  To do this, go to the pkgs/ directory and run the
install-pkgs.sh script:

  $ cd pkgs
  $ ./install-pkgs.sh

The script may ask for your password if it needs to install any Ubuntu packages
(via apt-get).

Once all the packages are installed, you can compile the manual by typing:

  $ make

===

Please add comments wherever applicable to make your intentions obvious to
other users.

LaTeX comments start with % and extend to the end of the line. To insert a
literal %, use \%. Certain other characters need escaping too. See
http://www.ctan.org/tex-archive/info/symbols/comprehensive/ for a big list.

There should always be comments at the start of the file, and they 
should include all relevant details about that particular file. In the case of
chapters, please include things like whether they have screenshots that need to
be inserted, or any special formatting for the editors/formatters.

If you add new comments, don't overwrite old ones unless you're updating that
specific thing - add a new line and make sure you add - <your name> to the end
of it so we know who added it.

Each folder should have an images folder inside it where images are stored,
and images should be referred to from the root directory, ie:

  /chapter2/images/ubuntu-manual.png

To insert a picture, use the \includegraphics command:

  \begin{center} % put the image centred on the page
    \includegraphics[width=\textwidth]{chapter2/images/ubuntu-manual.eps}
  \end{center}

Note that you have to change the .png extension on the image file to .eps.
This appears to make the build sysem work.

To insert bullet points, use the "itemize" environment.
eg:

  \begin{itemize}
    \item .... .... 
    \item .. . ... .. 
    \item .. .. .. 
  \end{itemize}

Numbered lists are available via the "enumerate" environment.

Double quotations are written ``like this'' and single quotes `like this'.

Also all images/screenshots should be in .png format to keep the resulting
file size down when release comes around.

To insert a marginnote use \marginnote{Text in here}

To insert a definition note, use \notecallout{Text in here}

To build the PDF using make, just type "make". If you want to build it and
open it in a PDF viewer, type "make show". Other documentation for building
can be accessed via "make help | less".

Some excellent LaTeX documentation:

http://en.wikibooks.org/wiki/LaTeX/
