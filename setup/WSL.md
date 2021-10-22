= Some WSL Live-Hacks

== Optimize Storage

WSL do not free disk storage automatically, so in an admin powershell execute:

```
wsl.exe --shutdown
cd C:\Users\dzunke\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState\
optimize-vhd -Path .\ext4.vhdx -Mode full
```
