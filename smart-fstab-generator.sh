#!/sbin/sh
#
# This script wants to be a simple solution to generate a fstab for Mako
# 
# Script parse its own name and write every partition entry into f2fs filesystem.
#
# Creator: ffigue <arroba> gmail.com
#
#    License:
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Sources:
# https://android.googlesource.com/device/lge/mako/+/master/fstab.mako
# http://forum.xda-developers.com/showpost.php?p=51659075

basename=$(ps wwwwwwwwwwwww | grep -v grep | grep -o -E "/tmp/updater(.*)")
echo "Parsing basename for fstab.mako: $basename"
fstabfile="/tmp/ramdisk/fstab.mako"

# Start fstab generator
# Writting /system
if echo $basename | grep -q system ; then
	echo "Changing /system to f2fs"
	sed -e '/by-name\/system/c\\/dev\/block\/platform\/msm_sdcc.1\/by-name\/system       \/system         f2fs    ro,noatime,nosuid,nodev,discard,nodiratime,inline_xattr,errors=recover    wait' -i $fstabfile
fi

# Writting /cache
if echo $basename | grep -q cache ; then
	echo "Changing /cache to f2fs"                                                                                                                                      
	sed -e '/by-name\/cache/c\\/dev\/block\/platform\/msm_sdcc.1\/by-name\/cache        \/cache          f2fs    noatime,nosuid,nodev,discard,nodiratime,inline_xattr,errors=recover       wait,check' -i $fstabfile
fi

# Writting /data
if echo $basename | grep -q data ; then
	echo "Changing /data to f2fs"
	sed -e '/by-name\/userdata/c\\/dev\/block\/platform\/msm_sdcc.1\/by-name\/userdata     \/data           f2fs    noatime,nosuid,nodev,discard,nodiratime,inline_xattr,errors=recover       wait,check,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata' -i $fstabfile
fi

