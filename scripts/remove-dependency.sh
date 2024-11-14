#!/bin/bash

read -p "Dependency to remove: " dependency
read -p "Is $dependency a dev dependency? (y/n): " is_dev
read -p "Does $dependency belong to a group? (y/n): " belongs_to_group

dev_flag=""
group_flag=""

if [ "$is_dev" == "y" ]; then
  dev_flag="-d"
fi

if [ "$belongs_to_group" == "y" ]; then
  read -p "Group name: " group_name
  group_flag="-G $group_name"
fi

pdm remove $dev_flag $group_flag $dependency