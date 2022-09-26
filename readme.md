<html>
    <h1 align='center'>
        org-dead-refs
    </h1>
    <p align='center'>
        find refs to non-existent org nodes
        <br>
        <pre align='center'>sudo curl https://raw.github.com/yumiris/org-dead-refs/master/org-dead-refs.sh -o /usr/local/bin/org-dead-refs
sudo chmod +x /usr/local/bin/org-dead-refs</pre>
    </p>
</html>

# Introduction

This nimble Bash script will print out all of the references in your `.org` files which point to non-existent Org/Org-Roam nodes. A practical use for this is to remove links to a file or node you've deleted!

To use it, simply `cd` into your Org/Org-Roam directory and invoke the script. If you want to be fancy, you can install the script to your `/usr/local/bin` directory!

```sh
#!/bin/bash

# org-dead-refs.sh --- Find refs to non-existent Org nodes.
#
# Filename: org-dead-refs.sh
# Description: Find refs to non-existent Org nodes.
# Author: Emilian Roman
# Created: Mon, 26 Sep 2022
# Version: 0
# URL: https://github.com/yumiris/org-dead-refs.git

UUID='[[:xdigit:]]{8}(-[[:xdigit:]]{4}){3}-[[:xdigit:]]{12}'
LINK='id:'
NODE=':ID:.*'

comm -23 \
    <(grep -rhEwoa "${LINK}${UUID}" | sed 's/id://g' | sort -u) \
    <(grep -rhEwoa "${NODE}${UUID}" | sed 's/.* //g' | sort -u) \
    | xargs -I {} grep -ran {} # find context for known dead refs
```

# Logic

The script aims for speed, and works like so:

1. Recursively find all of the `[[id:<uuid>]]` in every text file. These are created by you!
2. Recursively find all of the `:ID:   <uuid>` in every text file. These are created by `org-id.el`.
3. Generate a list of UUIDs that were found in step 1, but not in step 2, then find all the text files containing these UUIDs.

The script took roughly *one second* to find all of the invalid links in a directory with nearly 3,000 `.org` files.

The contents range from tiny nuggets of notes, to biblical streams of consciousness which no deity could ever hope to finish reading.
