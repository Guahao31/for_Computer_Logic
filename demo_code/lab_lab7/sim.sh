#!/bin/bash

list=$(find . -name '*_tb.v')
module_list=""
for i in $list; do
  module=${i:2}
  module=${module%_tb.v*}
  # echo $module
  echo "Module: $module"
  if test -r ${module}.v; then
    echo "iverilog -o ${module}.vvp ${module}.v ${module}_tb.v"
    iverilog -o ${module}.vvp ${module}.v ${module}_tb.v
    echo "vvp ${module}.vvp"
    vvp ${module}.vvp
    echo
  else
    echo -e "\e[100m"$module".v not found\e[0m"
  fi
done