#!/bin/bash

# note - apparently there are newer compiled version of marathon via the apt repo than from marathon website
# this script is not complete. Basic instructions on how to repackage marathon is
# 1 - download from mesos apt repo the marathon debian package.
# 2 - extract meta data by doing dpkg -e <debname>.deb deb_meta_files/
# 2a - modify the version number in the deb_meta_files/control file
# 3 - extract the package content using dpkg -x <debname>.deb src/
# 4 - then run the fmp command below and put in the new version number in the -v param

OS_VERSION=ubuntu2004
OLD_OS_VERSION=ubuntu1604
VERSION=1.9.81-0.1.20190905233136

# you can also grab compiled code from website, and uncomment the following
#wget https://downloads.mesosphere.io/marathon/builds/${VERSION}/marathon-${VERSION}.${OLD_OS_VERSION}.tgz -O marathon.tgz
#tar xvf marathon.tgz
#cp -R marathon-${VERSION}/{bin,lib} marathon_pkg_template/usr/share/marathon/

sed -i "s/{{ VERSION }}//g" deb_meta_files/control > deb_meta_files/newcontrol

fpm -t deb -s dir -n "marathon" -v 1.9.81-0.1.20190905233136.ubuntu2004                      \
    --config-files deb_meta_files/conffiles --deb-custom-control deb_meta_files/newcontrol   \
    --pre-install deb_meta_files/preinst --post-install deb_meta_files/postinst              \
    --before-remove deb_meta_files/prerm --after-remove deb_meta_files/postrm                \
    -d default-jdk src/

