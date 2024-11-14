#!/bin/bash

read -p "Dependency to install: " dependency
read -p "Do you want to install $dependency as a dev dependency? (y/n): " is_dev
read -p "Do you want to install the $dependency inside a group? (y/n): " add_to_group

dev_flag=""
group_flag=""

if [ "$is_dev" == "y" ]; then
  dev_flag="-d"
fi

if [ "$add_to_group" == "y" ]; then
  read -p "Group name: " group_name
  group_flag="-G $group_name"
fi

pdm add $dev_flag $group_flag $dependency