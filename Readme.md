# Baithook
![](baithook_text.png)

# Installation
## Environment
You need a container to run CentOS.  
As for me, I chose Docker with image `centos:8`.  
*make sure your yum source is available*  
## Build
1. uncompress the zip file(of course in container).  
2. `sudo chmod u+x build.sh`  
3. `sudo ./build.sh`  
When everything is done, you will have a `/run.sh` file.  
# Usage
For re-exec, use `/run.sh` is ok.  
Dictionary will be at `/dict.txt`, and ip-address file will be at `/addr.txt`.  
## format
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