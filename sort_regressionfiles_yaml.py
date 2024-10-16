#!/usr/bin/env python


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

    with open("regressionfiles_nocomments.yaml", "w", encoding="utf-8") as handle:
        yaml.dump(contents, handle)

    with open("regressionfiles_sorted.yaml", "w", encoding="utf-8") as handle:
        yaml.dump(contents_sorted, handle)

    result = sp.run(
        [
            "git",
            "diff",
            "--no-index",
            "regressionfiles_nocomments.yaml",
            "regressionfiles_sorted.yaml",
        ]
    )
    if result.returncode:
        sys.exit(result.returncode)
