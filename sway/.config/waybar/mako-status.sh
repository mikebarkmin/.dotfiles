#!/bin/bash

if pgrep -x mako >/dev/null; then
  echo '{"text":"On","class":"on","alt":"on"}'
else
  echo '{"text":"Off","class":"off","alt":"off"}'
fi
