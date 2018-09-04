#Install the rpmfusion repo, note only "nonfree" is required, as the Broadcom Driver is proprietry: http://rpmfusion.org/
su -c 'dnf install -y http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

#Then install the akmods and kernel-devel packages
sudo dnf install -y akmods "kernel-devel-uname-r == $(uname -r)"

#Finally install broadcom-wl package from the rpmfusion repo, which will install kmod-wl, akmod-wl, and other dependencies.
sudo dnf install -y broadcom-wl

#Next run akmods to rebuild the kernel extension in the broadcom-wl package:
sudo akmods
