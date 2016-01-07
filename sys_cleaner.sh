#!/bin/bash

#remove configuration files of uninstalled programs
dpkg -P $(dpkg -l | grep '^rc' | awk '{print $2}')
