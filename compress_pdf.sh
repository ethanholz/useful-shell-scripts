#!/bin/bash

while getopts i:o:s: flag
do
    case "${flag}" in
        i) input_file=${OPTARG};;
        o) output_file=${OPTARG};;
        s) size=${OPTARG};;
    esac
done

if [ ! $# -eq 6 ]
then
    echo "Incorrect argument count"
    return
fi

if [ ! -f "$input_file" ]
then
    echo "Input file not found"
    return
fi

case $size in
    medium)
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output_file" "$input_file"
        ;;
    small)
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output_file" "$input_file"
esac
