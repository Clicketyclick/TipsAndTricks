### Rename using Multi-rename tool

Reference: https://www.ghisler.ch/wiki/index.php/Multi-rename_tool

Mask: ISO8601
- Filename: `[N].[Y]-[M]-[D]T[hms]`
  - or `[N].[d]T[t]`
- Extension: `[E]`

### Default rename mask in Multi-rename tool


> Is there a way to redefine the default rename mask in Totalcmd's Multi-rename tool?

Not by overwriting Total Commander’s built-in **`<Default>`** entry. That entry resets the Multi-Rename Tool to “no changes to the names.”  ([ghisler.ch](https://www.ghisler.ch/wiki/index.php/Multi-rename_tool "Multi-rename tool - TotalcmdWiki")[^1])

The practical way is to save your preferred rename mask as a preset, then tell Total Commander to load that preset whenever the Multi-Rename Tool opens.

<!--
Yes, you can redefine the default rename mask in Total Commander's Multi-Rename Tool.
-->
**Methods:**

1. **Save as profile**: Configure your desired mask in the Multi-Rename Tool, then press **F2 → Save settings** to save it as a named profile.

2. **Set as default**: Add this line to your `wincmd.ini` under `[Configuration]`:
   ```
   [Configuration]
   MultiRenameLoadSettings=YourProfileName
   ```
   This will automatically load your saved mask every time you open the Multi-Rename Tool.

3. **Toolbar button**: Create a button with command `MULTIRENAME YourProfileName` to always open the tool with your custom mask.


`MultiRenameLoadSettings` defines what settings the Multi-Rename Tool starts with: empty means last-used settings, a valid name loads that saved preset, and an unknown name loads the built-in defaults. ([ghisler.ch](https://ghisler.ch/board/viewtopic.php?t=49044 "9.12: multi file rename, lower cases as default setting? - Total Commander")[^2])

The saved MRT presets themselves are stored in `wincmd.ini` under the `[rename]` section, unless that section has been redirected to another file. ([ghisler.ch](https://www.ghisler.ch/board/viewtopic.php?t=84251 "Is there a way to make the rename forget? - Total Commander")[^3])

### Alternative: button or shortcut only

Instead of changing global MRT startup behavior, you can create a button/user command with:

```text
MULTIRENAME MyDefault
```

That opens MRT with your saved preset without changing how plain `Ctrl+M` behaves. The `MULTIRENAME <profile_name>` command is the standard way to launch MRT with a saved rename profile. ([ghisler.ch](https://ghisler.ch/board/viewtopic.php?t=42942 "Multi Rename Tool: change the defaults settings - Total Commander")[^4])


---
[^1]: https://www.ghisler.ch/wiki/index.php/Multi-rename_tool "Multi-rename tool - TotalcmdWiki"
[^2]: https://ghisler.ch/board/viewtopic.php?t=49044 "9.12: multi file rename, lower cases as default setting? - Total Commander"
[^3]: https://www.ghisler.ch/board/viewtopic.php?t=84251 "Is there a way to make the rename forget? - Total Commander"
[^4]: https://ghisler.ch/board/viewtopic.php?t=42942 "Multi Rename Tool: change the defaults settings - Total Commander"


<!--
Total Commander's Multi-Rename Tool (MRT) lets you save a set of settings (including the rename mask) and then load that set automatically every time MRT opens.

**Steps:**

1. Open MRT (Ctrl+M) and set up the mask and options exactly how you want them by default.
2. Click **F2 → Save settings**, and give it a name, e.g. `mrt_default`.
3. Open `wincmd.ini` (Total Commander stores this — you can find its path via **Help → About Total Commander → INI-Files**, or edit it directly via **Configuration → Change Settings Files Directly**).
4. Under the `[Configuration]` section, add or edit this line:
   ```
   MultiRenameLoadSettings=mrt_default
   ```
5. Save the file. From now on, every time you open MRT, it will start with the mask/settings you saved as `mrt_default` instead of remembering the last-used mask.

**Notes:**
- If `MultiRenameLoadSettings=` is left empty, MRT starts with the last used settings (the normal behavior).
- You can also use the special value `<default>` to always reset MRT to Total Commander's built-in clean defaults on every launch: `MultiRenameLoadSettings=<default>`.
- The saved presets themselves live in `wincmd.ini` under the `[rename]` section (unless redirected elsewhere with `RedirectSection=`), so if you use a portable install, they travel with your ini file.
- If you want different masks available on demand rather than always-on, you can instead create toolbar buttons or hotkeys using the command `MULTIRENAME <settingsname>`, which opens MRT pre-loaded with a specific saved preset without changing the global default.

-->
