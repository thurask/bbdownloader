git-archive
===========
This should be the prefix directory for your git archive output.

For a simple archive (from the bbdownloader root directory):

    $ git archive -o git-archive/latest.zip HEAD

This produces a zipped copy of the current local revision in the git-archive directory as latest.zip.

For fancier types:

    $ lastcommit=$(git log -1 --format="%h") && git archive -o git-archive/$lastcommit.zip HEAD
	
This grabs the latest commit short hash and uses it for the title of the saved zip file. Handy.