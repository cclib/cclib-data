#!/usr/bin/env python

"""sort_regressionfiles_yaml.py: Check and see if the entries in
regressionfiles.yaml are sorted by filename, producing the diff to standard
out that should make them sorted.

You should probably call the shell script, which wraps this Python code.
"""


if __name__ == "__main__":
    import sys
    import subprocess as sp

    from ruamel.yaml import YAML

    yaml = YAML(pure=True, typ="safe")
    yaml.default_flow_style = False
    yaml.indent(mapping=2, sequence=4, offset=2)

    with open("regressionfiles.yaml", encoding="utf-8") as handle:
        contents = yaml.load(handle)

    contents_sorted = {"regressions": sorted(contents["regressions"], key=lambda x: x["loc_entry"])}

    # Since the original regressionfiles.yaml has comments, we need to strip
    # those out before generating the diff, since we can't yet generated
    # sorted output that contains comments.

    with open("regressionfiles_nocomments.yaml", "w", encoding="utf-8") as handle:
        yaml.dump(contents, handle)

    with open("regressionfiles_sorted.yaml", "w", encoding="utf-8") as handle:
        yaml.dump(contents_sorted, handle)

    result = sp.run(
        [
            "diff",
            "-u",
            "regressionfiles_nocomments.yaml",
            "regressionfiles_sorted.yaml",
        ]
    )
    if result.returncode:
        sys.exit(result.returncode)
