#!/bin/bash

# ****************
# ** Navigation **
# ****************

# "l" is short for "ls"
alias l='ls'

# "ll" is short for detailed file lists, with "ls -l":
alias ll='ls -al'

# "lh" is short for detailed file lists with human-readable units:
alias lh='ls -Alh'

# Going up? :)
alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../..'
alias ..8='cd ../../../../../../../..'
alias ..9='cd ../../../../../../../../..'

# ***********
# **  SSH  **
# ***********

# psb:
#   psbuild-rhel7 is one of the most common hosts you will use.
#   This shortcut ``psb`` will allow you to quickly go to that host while
#   retaining your current working directory.
alias psb='sshcd psbuild-rhel7'

# *****************************
# ** Python and hutch-python **
# *****************************

# These are shortcuts for individual hutches to start hutch-python:
alias tmo3="hpy3 tmo"
alias txi3="hpy3 txi"
alias rix3="hpy3 rix"
alias xpp3="hpy3 xpp"
alias xcs3="hpy3 xcs"
alias mfx3="hpy3 mfx"
alias cxi3="hpy3 cxi"
alias mec3="hpy3 mec"

# Python 3 hutch python shortcuts
# hpy3
#   Quickly start a hutch-python session for a given hutch with ``hpy3 (hutchname)``
hpy3() {
    hutch="${1}"
    shift
    "/reg/g/pcds/pyps/apps/hutch-python/${hutch}/${hutch}python" "$@"
}


# ****************
# ** General    **
# ****************

# This allows for aliases to be passed through to sudo
alias sudo='sudo '


# ****************
# ** What now?  **
# ****************
#
# Add some more aliases or modify the ones above to fit your needs.
# Also, use shellcheck to see that you're writing scripts with good syntax.
# The tool shellcheck is available in our pcds Python environment.
#
# For bash help, see https://tldp.org/LDP/Bash-Beginners-Guide/html/
