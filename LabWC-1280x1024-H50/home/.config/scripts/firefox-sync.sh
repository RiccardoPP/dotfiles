#!/bin/sh

static=static-$1
link=$1
volatile=/dev/shm/firefox-$1-$USER

IFS=
set -efu

cd ~/.mozilla/firefox

if [ ! -r $volatile ]; then
	mkdir -m0700 $volatile
fi

if [ "$(readlink $link)" != "$volatile" ]; then
	mv $link $static
	ln -s $volatile $link
fi

if [ -e $link/.unpacked ]; then
	rsync -av --delete --exclude .unpacked ./$link/ ./$static/
else
	rsync -av ./$static/ ./$link/
	touch $link/.unpacked
fi
