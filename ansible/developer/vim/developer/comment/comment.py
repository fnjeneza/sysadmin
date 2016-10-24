#!/usr/bin/python3
from vim import *

"""
program to add a comment with vim editor
"""

__author__ = "njeneza"


def add_comment(symb, start, end):
    for b in range(start, end+1):
        vim.command(':'+ str(b))
        vim.current.line = symb + vim.current.line

def remove_comment(symb, start, end):
    for b in range(start, end+1):
        vim.command(':'+ str(b))

        if vim.current.line.startswith(symb):
            s = len(symb)
            vim.current.line = vim.current.line[s:]

        elif vim.current.line.startswith(symb.strip()):
            s = len(symb)
            vim.current.line = vim.current.line[s:]

ran = vim.current.range
start = ran.start
end = ran.end

# if filetype is python:
symb = "# "

filetype = vim.eval("&filetype")

if filetype == "cpp":
    symb = "// "

(row, col) = vim.current.window.cursor

if vim.current.line.startswith(symb):
    remove_comment(symb, start+1, end+1)

else:
    add_comment(symb, start+1, end+1)

# selection
#vim.command(":" + str(start+1) + "v" + str(start-end) + "j")
# put the cursor to the line
vim.current.window.cursor = (row, col)
