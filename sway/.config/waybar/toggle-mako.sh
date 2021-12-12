#!/bin/bash

if pgrep -x mako >/dev/null;
then
  pkill --signal SIGINT mako
else
  mako
fi;
