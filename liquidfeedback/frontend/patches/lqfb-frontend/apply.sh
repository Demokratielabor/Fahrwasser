#!/bin/sh

for p in /patches/*.patch; do
	patch -p1 < "$p"
done
