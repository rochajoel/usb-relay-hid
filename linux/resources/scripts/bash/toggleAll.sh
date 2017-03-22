#!/bin/bash

function toggle() {
    sudo ./hidusb-relay-cmd ID=$1 $( [ "$3" == "ON" ] && echo OFF || echo ON ) $2
}

function toggle_board() {
    sudo ./hidusb-relay-cmd ID=$1 state | sed 's/.*: R\(.*\) R/\1 /' | sed 's/ /\n/g' | while read -r rLine
    do
        toggle $1 $( echo $rLine | sed 's/=/ /' )
    done
}

sudo ./hidusb-relay-cmd enum | sed 's/.*\[\(.*\)\].*/\1/' | while read -r line
do
    toggle_board $line
done
