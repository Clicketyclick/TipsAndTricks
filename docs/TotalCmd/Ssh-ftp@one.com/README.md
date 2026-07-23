## Total Commander SFTP Setup 

### One.com

> I trying to connect to the ftp server ssh.XXX.service.one using Totalcommander. I works fine using Filezilla, but TC is refused access after entering username and password

The host `ssh.XXX.service.one` is an **SSH/SFTP server**, not a conventional FTP server. 
Total Commander’s normal **FTP Connect** dialog does not handle SFTP; SFTP requires the separate 
Total Commander SFTP file-system plugin. one.com also documents this server access specifically as SSH/SFTP. ([ghisler.com<img src="../../icons/Totalcmd.icon.png" width=16>](https://www.ghisler.com/plugins.htm?utm_source=chatgpt.com "Total Commander - Plugins")[^1])

## Configure Total Commander

1. Install the official **SFTP plugin** from Total Commander’s plugin page. The current Windows plugin is SFTP 3.10.
2. Do **not** use:
   `Net → FTP Connect` or <kbd>Ctrl</kbd>+<kbd>F</kbd>
3. Open the drive list with <kbd>Alt</kbd>+<kbd>F1</kbd> or <kbd>Alt</kbd>+<kbd>F2</kbd>.
4. Select **Network Neighborhood**: `\`
5. Open **Secure FTP**.
6. Choose `_F7=New Connection`, or press <kbd>F7</kbd> and enter a name for the connection. The SFTP configuration dialog appears after you enter the connection name. ([ghisler.ch<img src="../../icons/Totalcmd.icon.png" width=16>](https://www.ghisler.ch/board/viewtopic.php?t=37728 "SFTP Plugin: How to actually USE this plugin? - Total Commander")[^2])
   1. <kbd>Alt</kbd>+<kbd>Enter</kbd> for editing an entry 
8. Configure it approximately as follows:

```text
Connect to:  ssh.XXX.service.one
Port:        22
User name:   your exact SSH/SFTP username
Password:    your SSH/SFTP password
```

Enter only the hostname—not:

```text
sftp://ssh.XXX.service.one
```

Accept the server host fingerprint when prompted on the first connection.

## Important one.com detail

one.com has separate connection settings under:

```text
Control Panel
  → Advanced settings
  → SSH & SFTP
```

Use the username and password shown or created there. The SSH/SFTP password can 
differ from the ordinary FTP password. ([One.com Support](https://help.one.com/hc/en-us/articles/115005585689-Using-SFTP "Using SFTP – Support | one.com")[^3])

## Compare with FileZilla

Open FileZilla’s Site Manager and verify these fields:

```text
Protocol:   SFTP – SSH File Transfer Protocol
Host:       ssh.XXX.service.one
Port:       22
Logon type: Normal
User:       ...
```

Use those exact values in the Total Commander **Secure FTP** plugin. If 
FileZilla uses a private key rather than “Normal” password authentication, 
configure that same private key in the plugin.

The most likely cause of your current error is that Total Commander is 
attempting ordinary FTP—usually port 21—against an SFTP/SSH hostname on port 22.

[^1]: https://www.ghisler.com/plugins.htm?utm_source=chatgpt.com "Total Commander - Plugins"
[^2]: https://www.ghisler.ch/board/viewtopic.php?t=37728 "SFTP Plugin: How to actually USE this plugin? - Total Commander"
[^3]: https://help.one.com/hc/en-us/articles/115005585689-Using-SFTP "Using SFTP – Support | one.com"

---


