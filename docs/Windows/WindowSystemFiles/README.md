# Windows System Icons

Source: [answers.microsoft.com](https://answers.microsoft.com/en-us/windows/forum/all/want-to-know-where-icons-are-hidden-stored-in/5f79cf5a-02a5-4faa-bf04-7af401cb5083)

Most Icons Windows 10 uses are actually located in `C:\Windows\System32\`

The two primary locations are:

- `C:\Windows\System32\shell32.dll`
- `C:\Windows\System32\imageres.dll`

Plus a few in 
- `C:\Windows\System32\imagesp1.dll`
- `C:\Windows\System32\filemgmt.dll`

These locations are "Libraries" that are only accessible when using a "Change Icon" setting of some type...

More extended list
- [Windows icons](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/)
