#!/bin/bash -e

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi


if ! grep -E "^uinput:" /etc/group > /dev/null ; then
  echo 'groupadd uinput'
  groupadd uinput
fi

if grep -E "^xkeysnail:" /etc/passwd > /dev/null; then
  echo 'userdel xkeysnail'
  userdel xkeysnail
fi

echo 'useradd xkeysnail'
useradd -G input,uinput -M -s /bin/false xkeysnail
echo 'KERNEL=="uinput", GROUP="uinput"' > /etc/udev/rules.d/input.rules
echo 'uinput' > /etc/modules-load.d/uinput.rules
udevadm control --reload-rules && udevadm trigger

echo 'Add line to /etc/sudoers'
unroot_user="${SUDO_USER:-$USER}"
sudoers_line="$unroot_user ALL=(xkeysnail) NOPASSWD: /usr/local/bin/xkeysnail"
if ! grep -x "$sudoers_line" /etc/sudoers > /dev/null 2>&1 ; then
  echo "$sudoers_line" | EDITOR='tee -a' visudo > /dev/null
fi
