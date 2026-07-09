
##     Default rename mask in Multi-rename tool


> Is there a way to redefine the default rename mask in Totalcmd's Multi-rename tool?

<!--
Yes, you can redefine the default rename mask in Total Commander's Multi-Rename Tool.
-->
**Methods:**

1. **Save as profile**: Configure your desired mask in the Multi-Rename Tool, then press **F2 → Save settings** to save it as a named profile.

2. **Set as default**: Add this line to your `wincmd.ini` under `[Configuration]`:
   ```
   MultiRenameLoadSettings=YourProfileName
   ```
   This will automatically load your saved mask every time you open the Multi-Rename Tool.

3. **Toolbar button**: Create a button with command `MULTIRENAME YourProfileName` to always open the tool with your custom mask.

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
