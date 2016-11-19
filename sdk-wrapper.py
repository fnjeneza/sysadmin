#!/usr/bin/env python3

import sys
import os
import subprocess
import shlex
import readline

command = sys.argv[0]
wd = os.getcwd()
CONF_FILE = ".project.user.py"

def recursive_find(file_name , stop_path = None):
    if not stop_path:
        stop_path = os.path.expanduser('~')

    _wd = os.getcwd()

    while(stop_path in _wd):
        if file_name in os.listdir(_wd):
            path = os.path.join(_wd, file_name)
            if os.path.isfile(path):
                return path

        os.chdir("..")
        _wd = os.getcwd()

    return None

def cmake_or_ninja():
    """
    Run a cmake or ninja command depending on user's input
    """
    path = recursive_find(CONF_FILE)
    container = None
    full_cmd = " ".join(sys.argv[2:])
    source_dir = None
    if path:
        with open(path) as conf:
            _values = eval(conf.read());
            cb = _values["current_build"]
            build = _values["list_build"][cb]
            wd = build["build_dir"]
            container = build["container"]
            source_dir = build["source_dir"]



    if  sys.argv[1] == 'cmake':
        full_cmd = "/usr/bin/cmake "+full_cmd
        if source_dir:
            full_cmd = full_cmd +" "+ source_dir

    elif sys.argv[1] == 'ninja':
        full_cmd = "/usr/bin/ninja " + full_cmd

    full_cmd = "bash -c 'cd {0} && {1}'".format(wd, full_cmd)

    if container:
        full_cmd = "lxc exec {0} -- {1}".format(container, full_cmd)


    args = shlex.split(full_cmd)
    print('*'*20)
    print(args)
    print('*'*20)
    #ret = subprocess.run(args, universal_newlines=True)

def init():
    """
    project_name: doe
    current_build: x86
    list_build: [
        arm : {
            source_dir : /path/source
            build_dir : /path/build
            container : device-armhf
        }
        x86: {
            source_dir : /path/source
            build_dir : /path/build
            container :
        }
    ]
    """

    path = recursive_find(CONF_FILE)
    dict_build = {}
    list_build_name = []
    current_build = None
    if path:
        print("\"%s\" already exists" % CONF_FILE)
        override = input("\nOverride? [y/n] ")
        if override == 'n' or None:
            return

    project_name = input("Project name: ")
    add_build = None
    while add_build != 'y':
        add_build = input("add build kit? [y/n] ")

    while add_build == 'y':

        build_name = input("architecture[x86_64, armhf] (default x86_64): ")
        if not build_name:
            build_name="x86_64"

        if ' ' in build_name:
            print("no space character allowed\nabort")
            exit()
        source_dir = input("\tsource directoy(default, current directory): ")
        if not source_dir:
            source_dir = os.getcwd()
        path = os.path.join(os.path.expanduser('~'), "workspace",
                "build_"+project_name+"_"+build_name)
        build_dir = input("\tbuild directory(default, %s): " % path)
        container = input("\tcontainer(default, empty): ")
        build = {"build_dir":build_dir, "source_dir":source_dir,
                "container":container}
        dict_build[build_name] = build

        add_build = input("\nadd another build? [y/n]")

    if len(dict_build) > 1:
        i = 1
        a = ""
        for _ in list_build_name:
            a = a + str(i) + " "
            i=+1
        index = input("Default build kit " + a)
        current_build = list_build_name[index]

    abs_name = os.path.join(source_dir, CONF_FILE)
    with open(abs_name, 'w') as conf:
        out = {"project_name":project_name, "current_build": current_build,
                "list_build": dict_build}
        conf.write(str(out))
        print("%s generated" % CONF_FILE)


if __name__ == "__main__":
    if 'init' == sys.argv[1]:
        init()
    else:
        cmake_or_ninja()
