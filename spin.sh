#!/bin/bash

function spin::chars() {
  local chosen_value=""
  [[ $1 == "moon" ]]      && chosen_value="☾☽"
  [[ $1 == "dice" ]]      && chosen_value="⚀⚄⚃"
  [[ $1 == "domino" ]]    && chosen_value="🀸🀹🀲🀱🀸🀹🀲🀱"
  [[ $1 == "triangles" ]] && chosen_value="‣▸‣▸"
  [[ $1 == "lines" ]]     && chosen_value="⎽⎽⎼⎼⎻⎻⎺⎺⎻⎼⎽⎽⎽⎼⎼⎻⎻⎺⎺⎻⎼⎽"
  [[ $1 == "dots" ]]      && chosen_value="˛¸.˛¸.˛¸."
  [[ $1 == "updots" ]]    && chosen_value="˙´\`˙´\`"
  [[ $1 == "uptris" ]]    && chosen_value="´ˆ\`ˆ´ˆ\`ˆ´ˆ\`ˆ"
  echo $chosen_value
}

function spin::usage() {
  echo "Usage: spin <spinner>"
  echo "spinners:"
  echo "    moon      ☾"
  echo "    dice      ⚀"
  echo "    domino    🀸"
  echo "    triangles ‣"
  echo "    lines     ⎽"
  echo "    dots      ˛"
  echo "    updots    ˙"
  echo "    uptris    ´"
}

function spin::step() {
  local chars="$1"
  echo -e "\r${chars:0:1} \c"
}

function spin::rotate() {
  local chars="$1"
  echo "${chars:1}${chars:0:1}"
}

function spin() {
  if [[ "$#" -ne 1 || -z $(spin::chars $1) ]]; then
    spin::usage
    return
  fi

  local chars=$(spin::chars $1)
  local framerate="`echo "scale=2; 1/${#chars}" | bc`"

  while true; do
    spin::step $chars
    chars=$(spin::rotate $chars)
    sleep $framerate
  done
}

