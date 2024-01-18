#!/bin/bash

dconf_path=`realpath ../config/dconf.txt`
dconf load / < $dconf_path
