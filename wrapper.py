#!/usr/bin/env python3

import sys
import subprocess
import shlex

cmd = None

if sys.argv[1] == "weather":
    cmd = "wget -nv -O - wttr.in"

elif sys.argv[1] == "whatsmyip":
    cmd = "wget -qO - icanhazip.com"

elif sys.argv[1] == "clean":
    cmd = "sudo dpkg -P $(dpkg -l | grep '^rc' | awk '{print $2}')"
    print(cmd)
    exit()

cmd = shlex.split(cmd)
ret = subprocess.run(cmd)
if ret.returncode:
    print(ret.returncode)
