Irssi Reordering
----------------

This script munges the output of the [irssi reorder][1] sript in to the input of
the [irssi reorder][1] based on how often out talk in a channel.

In irssi:

    /script load reorder
    /layout_save nightly

In shell:

    sh ./ircreorder.sh

in Irssi

    /layout_load reordered

This may make some assumptions about log formats, and locations that I may be
unaware of. On my system logs are stored in the following directory structure:

    ~/irclogs/$NETWORK/$CHANNEL.log

and that is the format that I expect. Change the script to suit your needs. :)

[1]: http://scripts.irssi.org/html/reorder.pl.html
