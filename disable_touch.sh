#!/bin/bash
foo=$(xinput --list | grep Finger | grep -o "id=.." | grep -Eo "[0-9]{1,4}")
xinput disable $foo

