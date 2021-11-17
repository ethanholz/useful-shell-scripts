#!/usr/bin/env python3
import os
import sys
from PIL import Image


def compress_file(file, quality_val=50):
    filepath = os.path.abspath(file)
    dir, filename = os.path.split(filepath)
    print(quality_val)
    try:
        picture = Image.open(filepath)
        picture.save(f"{dir}/compressed_{filename}", optimize=True, quality=quality_val)
    except Exception as err:
        print(err)
    return


def main():
    if not len(sys.argv) > 1:
        print("Please provide at least a file")
        return
    print(len(sys.argv))
    file = sys.argv[1]
    if len(sys.argv) > 2 and sys.argv[2].lower() == "-q":
        quality_val = int(sys.argv[3])
        compress_file(file, quality_val=quality_val)
    else:
        compress_file(file)
    print(os.path.getsize(file))


if __name__ == "__main__":
    main()
