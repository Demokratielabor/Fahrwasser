#!/bin/sh

for p in /patches/lqfb-frontend/*.patch; do
	patch -p1 < "$p"
done
