![baithook](baithook_text.png)  
Get username and password dictionary from ssh brute-force attacks.
# How it works
We replace the important function `auth_password()` (in openssh source code) with a specialized one.  
So, when brute-force attack comes, it will refuse all connections and record username & password to file.  
**IMPORTANT: This can NOT be a common ssh server, it will Refuse All Connections!**
# Installation
Or... [docker image](https://hub.docker.com/r/catium/baithook)?
## Environment
You need a container to run CentOS.  
As for me, I chose Docker with image `centos:8`.  
*make sure your yum source is available*  
## Build
1. uncompress the zip file(of course in container).  
2. `sudo chmod u+x build.sh`  
3. `sudo ./build.sh`  
When everything is done, you will have a `/run.sh` file and some other file in `${installDir}`.  
### Customize installation
edit `build.sh`, there are two variables.
+ `${openssh}` default is `openssh-9.0p1`
+ `${installDir}` default is `/baithook`
# Usage
For example, you can make your network like this:  
![example](example.png)  
This will make attack goes into Baithook, so that Baithook can record dictionary.  
## Commonly
For re-exec, use `/run.sh` is ok.  
Dictionary file will be at `/dict.txt`, and ip-address file will be at `/addr.txt`.  
## For docker
`docker run -p 22:22 -itd catium/baithook:latest`  
Make sure port `22` is forwarded.  
## File format
+ Dictionary file format is like this:
```
username pa$$w0rd
admin admin114514
nginx nginx
```
+ ip-address file format is like this(ipv6 is never tested):
```
127.0.0.1
192.168.4.5
6.7.8.9
```
# Licence
[Licence of OpenSSH](LICENCE)