#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# *******************************
# ** Prompt and basic settings **
# *******************************

# The following sets up your prompt to show at least the host
export PS1='\[\e[0;31m\][\u@\h  \W]\$\[\e[m\] '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'

# Your default editor will be set to vim.
#  * Having trouble using it? Try running `vimtutor`.
#  * Having trouble exiting it? Type ":wq!" to save and quit.
export EDITOR=vim

# If you have aliases and functions defined, let's use them:
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
# If you have additional aliases to add, put them in this file!

[ -f "$HOME/.bash_functions" ] && source "$HOME/.bash_functions"
# If you have additional functions to add, put them in this file!

# *****************************
# ** Python and hutch-python **
# *****************************

# Setup happi
export HAPPI_CFG=/cds/group/pcds/pyps/apps/hutch-python/device_config/happi.cfg

# **************************************************
# ** External scripts with common useful settings **
# **************************************************

# This includes tokens for accessing typhos / confluence resources:
source /cds/group/pcds/pyps/conda/.tokens/typhos.sh

# This includes settings for EPICS channel access:
source /cds/group/pcds/setup/epics-ca-env.sh
#  * Essential variables such as EPICS_CA_ADDR_LIST are set here.
#  * Aliases are configured:
#     - Archiver (open firefox to the archiver management interface)
#     - ArchiveViewer (open firefox to the archive viewer)

# Configure the latest EPICS environment.
# As of the time of writing, this is a shortcut to: epicsenv-7.0.2-2.0.sh
source /cds/group/pcds/setup/epicsenv-cur.sh

# The above includes the following common shortcuts, like find_pv and all
# of the per-hutch screen shortcuts like "lfe" or "cxi".
#
# ---> source /cds/group/pcds/setup/pcds_shortcuts.sh
#
# Documentation of these shortcuts can be found here:
#    https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=295099127
#
# Separately, pcds_shortcuts.sh also ensures that ensures that files you create
# in shared locations will be editable by others in your group if they are
# editable for you.  This can be important when working on shared EPICS IOCs,
# modules, etc.
#
# This is done by way of:
#   $ umask 0002
# If you type `umask -S` you will see that this corresponds to:
#   $ umask -S
#   u=rwx,g=rwx,o=rx
# Or read-write-execute for you and your group, and just read-execute for all
# others.

# ********************
# ** Tab completion **
# ********************

# Enable tab completion for common commands:
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
# This includes things like ssh, git, and so on.
# The commands which have tab completion can be found here:
#    /usr/share/bash-completion/completions/
# You may also add your own completions in ~/.bash_completion, which will be
# automatically sourced by the above script.

# The following customize tab completion in certain ways.  If you don't like the functionality
# they add, comment or remove them:

# Ignore lower/uppercase letters when using tab completion (TMUX[tab] and tmux[tab] are equivalent).
bind "set completion-ignore-case on"

# Treat dashes/hyphens and underscores as equivalent (use_dotfiles[tab] is the same as use-dotfiles[tab]).
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press.
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories.
bind "set mark-symlinked-directories on"


# **********************
# ** History settings **
# **********************

# Did you know that commands you type are tracked in ~/.bash_history ?
# This section configures how history is stored and displayed.

# Append to the history file, don't overwrite it.
shopt -s histappend

# Save multi-line commands as one command.
shopt -s cmdhist

# Record each line as it gets issued.
# We don't need "export PROMPT_COMMAND" here as only bash cares about this.
PROMPT_COMMAND='history -a'

# Keep a long list of history lines, because it's convenient and we have the
# space.  Default is normally 500.
HISTSIZE=500000
HISTFILESIZE=100000

# Do not add duplicate entries to the history.
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands in our history. Add more by including :cmdname:
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Show useful timestamps in our history.  See `man strftime` for what the parts
# mean.
# For example:
#    800   2022-03-10 11:37:50 $ command that_I_ran
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S $ '

# ***********************
# ** Per-host settings **
# ***********************


# Configure web proxy settings on a per-host basis.
# Tools like ``wget`` or ``curl`` will use the environment variable settings to
# proxy requests through the host "psproxy.pcdsn".
case $(hostname -s) in
    # Hosts with direct Internet access
	psbuild-* | pslogin* | cent7* )
        unset http_proxy;
        unset https_proxy;
		;;

    # Hosts with no access to psproxy.pcdsn
	 mcclogin | lcls-* )
        unset http_proxy;
        unset https_proxy;
		;;

    # Other hosts likely do not have direct Internet access
    * )
        export http_proxy=http://psproxy.pcdsn:3128;
        export https_proxy=http://psproxy.pcdsn:3128;
        ;;
esac

# ***********************
# ** PATH modification **
# ***********************

# ``pathmunge`` is a utility which will modify your PATH.
pathmunge /reg/common/tools/bin
# /reg/common/tools/bin contains scripts such as:
#  * Tools for inspecting or interacting with released EPICS modules:
#     - epics-checkout
#     - epics-release
#     - epics-versions (and other eco_tools)
#     - svnIocToGit
#     - svnModuleToGit
#  * Tools for inspecting or modifying networking configuration:
#     - netconfig
#     - digiconfig
#     - psipmi

pathmunge /reg/g/pcds/engineering_tools/latest-released/scripts
# /reg/g/pcds/engineering_tools/latest-released/scripts
#  * General tools of use to ECS engineers
#    For documentation, see: https://github.com/pcdshub/engineering_tools


# *************************
# ** Navigation settings **
# *************************

# If you type just a directory name, assume that you want to cd into that
# directory.  Otherwise, you would just see the message
#     "-bash: ./the_directory: Is a directory"
shopt -s autocd 2> /dev/null

# This allows you to bookmark your favorite places across the file system.
# Define a variable containing a path and you will be able to cd into it
# regardless of the directory you're in
shopt -s cdable_vars

# Examples:
# If you keep your git repositories in $HOME/Repos, you could do the following:
#    export repos="$HOME/Repos"
# Then:
#    $ $repos/pcdsdevices
#    $ $repos/lightpath
#
# Also consider adding:
#   export dotfiles="$HOME/dotfiles"


# ****************************
# ** Miscellaneous settings **
# ****************************

# Update window size after every command.
shopt -s checkwinsize

# Automatically trim long paths in the prompt.
PROMPT_DIRTRIM=2

# Enable history expansion with space.
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space


# ***************
# ** Now what? **
# ***************
#
# * Do you want to add your own scripts directory? You could use:
#
#   mkdir $HOME/bin
#   pathmunge $HOME/bin
#
# * Do you want to automatically use the latest conda environment?
#
#   [ -d /cds/group/pcds ] && source /cds/group/pcds/pyps/conda/pcds_conda
#
# * Do you want to set up a development area for Python code?
#
#   See the "Testing packages" sections for recommended workflows.
#   https://confluence.slac.stanford.edu/display/PCDS/PCDS+Conda+Python+Environments
