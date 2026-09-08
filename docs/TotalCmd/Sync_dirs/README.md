
## Synchronize directories

### Ignore specific subdirectories

Yes. In **Total Commander → Commands → Synchronize Dirs**, use the file filter field between the two directory paths. Put exclusions after a vertical bar `|`.

For example:

```text
*.* | .git\ node_modules\ cache\
```

This synchronizes everything except directories named `.git`, `node_modules`, or `cache`. The trailing `\` is important—it tells Total Commander that the pattern is a **directory**, not a file. These names are excluded wherever they occur in the directory tree. ([Ghisler][1])

You can also exclude directories by their position:

```text
*.* | \temp\
```

excludes `temp` only directly under the synchronization root, while:

```text
*.* | project\data\temp\
```

excludes only that particular relative path. ([Ghisler][2])

So, for a typical development tree I might use:

```text
*.* | .git\ node_modules\ vendor\ .idea\ .vscode\
```

You can **save this as part of a Synchronize Dirs profile**, so you don't need to enter it each time. ([Ghisler][2])

If you tell me the exact subdirectories you want ignored, I can give you the precise filter expression—including cases where a directory should be excluded only at a specific level.

[1]: https://ghisler.ch/board/viewtopic.php?p=399155&utm_source=chatgpt.com "Way to ignore directories for FTP and synchronize - Total Commander"
[2]: https://ghisler.ch/board/viewtopic.php?p=263382&utm_source=chatgpt.com "Save/Restore Synchronize directories settings - Total Commander"


### Save profile

In **Synchronize directories**, configure everything first: left/right directories, your filter such as

```text
*.* | .git\ node_modules\ cache\
```

and options such as **Subdirs**, **Asymmetric**, etc.

Then click the **small yellow folder icon with a star** in the **upper-left corner** of the Synchronize directories window. Alternatively, press **F2**. This opens the saved-settings dialog. Choose **Add current directories/settings**, give the configuration a name, for example `MyProject`, and save it. Total Commander can save the paths, synchronization options, display options, and—importantly—the wildcard/exclusion filter. ([Ghisler][1])

To use it later, open **Synchronize directories**, click that same folder icon (or press **F2**), and select `MyProject`.

You can also make a **Total Commander toolbar button that opens the saved profile directly**. Modern TC versions support:

```text
SYNCOPEN MyProject
```

as the button command. ([Ghisler][2])

That is particularly convenient if you have profiles such as `Backup`, `WebServer`, and `SourceCode`, each with different directory exclusions.

[1]: https://ghisler.ch/board/viewtopic.php?t=36633&utm_source=chatgpt.com "Save/Restore Synchronize directories settings - Total Commander"
[2]: https://www.ghisler.ch/board/viewtopic.php?t=76014&utm_source=chatgpt.com "Sticky filter option for Synchronize directories - Total Commander"


