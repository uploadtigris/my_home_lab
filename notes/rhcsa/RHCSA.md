# Bash
grep
```bash
#search files or streams
grep "text" file.txt
```
egrep
```bash
#shortcut for grep -E
#deprecated on most modern systems
grep 't\(a\|e\)st' test.txt
#vs.
egrep 't(a|e)st' test.txt
#vs.
grep -E 't(a|e)st' test.txt
```
awk
```bash
# operates on each line of an input file

# BEGIN { …. initialization awk commands …}
# { …. awk commands for each line of the file…}
# END { …. finalization awk commands …}

ls -l | awk 'BEGIN {sum=0} {sum=sum+$5} END {print sum}'
# or...
ls -l | awk '{for (i=1;i<3;i++) {getline}; print NR,$0}'
```
sort
```bash
sort fruits.txt

# `-r` - Sort in reverse order
# `-n` - Sort numbers correctly
# `-k` - Sort by a specific column
# `-u` - Remove duplicate lines
# `-t` - Specify a delimiter for fields
```
uniq
```bash
# Searches adjacent lines for duplicates (need to sort first)
sort file.txt | uniq
```
diff 
```bash
# display specific lines that differ, returns exit code of 1 (0 if duplicates)
dif [options] file1 file2
```
cmp
```bash
# diff is text, while cmp is for txt and binaries
cmp file1 file2
```
wc
```bash
# word count
5 7 58 state.txt
# num lines, num words, num bytes
```
tar
```bash
# create, maintain, modify, and extract files from an archive file
# -c -- create
tar -cvf archive.tar file1 file2
# -x -- extract
tar -xvf archive.tar
# -t -- list
tar -tvf archive.tar
```
gzip
```bash
# in-place compression of files
# compress
gzip filename
# with tar
tar -czvf archive.tar.gz
```
gunzip
```bash
# decompression of files compressed with gzip
gunzip example.txt.gz
```
# System Administration

vi
- o -- new line (automatically in insert mode)
- wq -- save file
- dd -- remove the line
- u -- undo
- /(word) -- jump to word
sed
```bash
# replace a string in a file with a newstring
# find and delete a line
# remove empty lines
# replace tabs with spaces
# remove the first or n lines in a file
```
useradd
groupadd
usermod
userdel
groupdel
who
last
w
id
users
wall
write
setuid
setguid
sticky bit
Active Directory, LDAP, IDM, WinBIND, OpenLDAP, etc.
date, uptime, hostname, uname, which, cal, bc
systemctl
ps
top
kill
at
bg, fg, nice
df, dmesg, iostat 1, netstate, free, top
shutdown, init, reboot, halt
hostnamectl
uname, dmidecode
clear, exit, script
tmux
Shell Scripting
Commands

# Networking, Services, and System Updates

### Commands
ping, ifup, ifdown, netstat, tcpdump
ethtool
nmtui, nmcli, nm-connection-editor
ss
curl & ping
wget
rpm & yum
nslookup
dig
chronyd
timedatectl

# Disk Management and Run Levels

### Commands
run levels 0 thru 6
systemd-analyze
df, fdisk
pvcreate, vgcreate, lvcreate
xfs_info
fsck & xfs_repair
dd
