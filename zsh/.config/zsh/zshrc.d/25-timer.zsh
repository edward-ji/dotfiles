#!/usr/bin/env zsh
# shellcheck shell=bash disable=SC2004,SC2034

################################################################################
# ZSH Execution Timer                                                          #
# This script utilizes the zsh pre-execute and pre-command functions to keep   #
# track of the execution time of interactive commands. The result will be      #
# printed out in seconds if it is greater than a set threshold.                #
#                                                                              #
# Environment variables                                                        #
# TIMER_MINIMUM -- only prints the elapsed time if it is greater than this     #
#   threshold, defaults to 3                                                   #
################################################################################

preexec_timer() {
    _timer=${_timer:-$SECONDS}
}

precmd_timer() {
    if [[ $_timer ]]
    then
        # Retrieve timer start
        local -i elapsed=$(( SECONDS - _timer ))
        unset _timer
        [[ $elapsed -le $TIMER_MINIMUM ]] && return

        # Convert to more readable time up to days
        local -i seconds=$(( elapsed % 60 ))
        local -i minutes=$(( elapsed / 60 % 60 ))
        local -i hours=$(( elapsed / 60 / 60 % 24 ))
        local -i days=$(( elapsed / 60 / 60 / 24 ))

        # Display the execution time
        printf "󱎫 "
        [[ $days -gt 0 ]] && printf "%dd " $days
        [[ $hours -gt 0 ]] && printf "%dh " $hours
        [[ $minutes -gt 0 ]] && printf "%dm " $minutes
        [[ $seconds -gt 0 ]] && printf "%ds" $seconds
        printf "\n"
    fi
}

[[ -z $TIMER_MINIMUM ]] && export TIMER_MINIMUM=3

preexec_functions+=(preexec_timer)
precmd_functions+=(precmd_timer)
