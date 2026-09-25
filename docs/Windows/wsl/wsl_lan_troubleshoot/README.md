Source: [Chatgpt](https://chatgpt.com/c/6ab65077-f304-83ed-a8ef-a9ae1f5de749)

## User
Installed wsl ubuntu on win 11.  cannot access lan from bash

## Assistant
On Windows 11, WSL2 normally can access your LAN through Windows NAT. If Ubuntu can reach the internet but cannot reach machines on your local network, the usual causes are the Windows firewall, VPN/security software, or WSL's networking mode.

First, from Ubuntu, test these separately:

```bash
# Check the WSL network
ip addr
ip route

# Internet by IP
ping -c 3 1.1.1.1

# Internet by DNS
ping -c 3 google.com

# Your Windows host as seen from WSL
ip route | grep default

# A LAN device — substitute a real LAN IP
ping -c 3 192.168.1.10
```

The important distinction is whether `192.168.1.10` fails while `1.1.1.1` works.

### Windows 11: try mirrored networking

Recent WSL versions work better on LANs with **mirrored networking** rather than the older NAT configuration.

On Windows, create or edit:

```text
C:\Users\<your-user>\.wslconfig
```

with:

```ini
[wsl2]
networkingMode=mirrored
```

Then from PowerShell:

```powershell
wsl --shutdown
```

Start Ubuntu again and test:

```bash
ping -c 3 192.168.1.10
```

Mirrored mode is particularly useful when you need WSL to access SMB servers, NAS devices, printers, web servers, SSH hosts, etc. on the same LAN.

### Check what version of WSL you have

In PowerShell:

```powershell
wsl --version
wsl --status
```

Also:

```powershell
wsl -l -v
```

You should see Ubuntu running as version **2**, for example:

```text
NAME      STATE     VERSION
Ubuntu    Running   2
```

If you have an old WSL installation, update it:

```powershell
wsl --update
wsl --shutdown
```

### If LAN access still fails

Try a specific TCP service instead of relying on `ping`, because Windows or the target device may block ICMP.

For example:

```bash
curl http://192.168.1.10/
```

or:

```bash
ssh user@192.168.1.10
```

or for SMB:

```bash
nc -vz 192.168.1.10 445
```

Also check the route:

```bash
ip route
```

With traditional NAT you might see something like:

```text
default via 172.25.64.1 dev eth0
172.25.64.0/20 dev eth0 proto kernel scope link src 172.25.70.123
```

That is normal; WSL does **not** need a `192.168.x.x` address to access a `192.168.x.x` LAN when using NAT.

If you paste the output of these four commands, I can identify exactly where it is failing:

```bash
ip addr
ip route
ping -c 2 1.1.1.1
ping -c 2 <IP-of-one-of-your-LAN-devices>
```
