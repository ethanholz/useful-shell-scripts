#!/usr/bin/env python3
import re
import urllib.request
from pathlib import Path


def main():
    aibin = Path.home() / "aibin"
    if not aibin.exists():
        aibin.mkdir()
    neovim_url = (
        "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
    )
    aiu_url = "https://github.com/AppImage/AppImageUpdate/releases/download/continuous/AppImageUpdate-x86_64.AppImage"
    appimages = {neovim_url: "nvim", aiu_url: "aiu"}
    for url in appimages:
        filename = re.search("([^/]+)$", url).group(0)
        path = aibin / filename
        link = aibin / appimages[url]
        if not path.exists():
            urllib.request.urlretrieve(url, path)
            path.chmod(0o755)
        if not link.is_symlink():
            link.symlink_to(path)


if __name__ == "__main__":
    main()
