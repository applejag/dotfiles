# X11 configs

## Intel graphics freezing programs fix

The `./20-intel.conf` file contains fix for Intel graphics bug with X11 where
programs graphically freeze when left alone for a while (~5min), forcing me to
restart them to be able to interact with them.

To apply the fix do the following:

1. Copy the file into your `xorg.conf.d` folder, and give ownership to `root`

   ```sh
   sudo cp -vn ./20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf
   sudo chown root:root /usr/share/X11/xorg.conf.d/20-intel.conf
   sudo chmod 644 /usr/share/X11/xorg.conf.d/20-intel.conf
   ```

2. Restart your machine.

3. :tada:
