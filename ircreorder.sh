#!/bin/bash

function get_network {
 echo -e "$@" | sed "s/.*:\(.*\)/\1/"
}

function get_channel {
 echo -e "$@" | sed "s/.*\t\(.*\):.*/\1/"
}

function log_location {
  echo "~/irclogs/$(echo $NETWORK | tr '[A-Z]' '[a-z]')/$(echo $CHANNEL| tr '[A-Z]' '[a-z]').log"
}

function get_win_location {
  echo -e "$1"
}

while read line
do
  WINLOCATION=$(get_win_location "$line")
  CHANNEL=$(get_channel "$line")
  NETWORK=$(get_network "$line")

  LOCATION=$(log_location)

  USAGESCORE=$(cat $LOCATION | grep "rrix>" | wc -l)

  if [[ -n "$(echo ${CHANNEL} | grep '^#')" ]]
  then
    USAGESCORE=$USAGESCORE
  else
    USAGESCORE=$(($USAGESCORE - 100))
  fi

  ORDERING="$ORDERING\n$USAGESCORE $CHANNEL:$NETWORK"

done < ~/.irssi/nightly.layout

FINALLIST="1\t(status)"
N="1"
SORTED=$(echo -e $ORDERING|sort -nr)

while IFS= read
do
  N=$(($N+1))
  E=$(echo $REPLY | awk '{print $2}')

  FINALLIST="$FINALLIST\n$N\t$E"
done <<< "$SORTED"

echo -e "$FINALLIST" |tee ~/.irssi/reordered.layout

