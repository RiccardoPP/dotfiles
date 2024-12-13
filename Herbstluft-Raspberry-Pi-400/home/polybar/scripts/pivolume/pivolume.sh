#!/bin/bash

volume=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget PCM))
echo  $volume
