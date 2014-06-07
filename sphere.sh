#!/bin/bash

# removing old files.
rm -f sphere.g
rm -f rt*

rt=rtsphere

cat <<EOF | mged -c sphere.g
in sph1.s sph 4 4 0 4
in sph2.s sph 4 4 4 4
r cut.r u sph2.s - sph1.s
mater cut.r plastic 12 164 220 0
B cut.r
ae 25 35
saveview $rt
EOF

# give executable permissions to raytrace file.
chmod 755 $rt

# executing raytrace file. This will produce raw image in .pix format
# and a log
#file.
sh $rt

# converting .pix file to png image using BRLCAD commands.
pix-png < $rt.pix > $rt.png

# open png image in a frame buffer. Currently not required.
#env /usr/brlcad/bin/png-fb $rt.png

shotwell $rt.png
