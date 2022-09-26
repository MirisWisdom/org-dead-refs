#!/bin/bash

# org-dead-refs.sh --- Find links to non-existent Org nodes.
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