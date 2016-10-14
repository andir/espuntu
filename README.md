# espuntu

Handy shell alias:

```
function espfrickel() {
	#newgrp docker
	if [ -e /dev/ttyUSB0 ]; then
		docker run --rm --device=/dev/ttyUSB0:/dev/ttyUSB0:rwm -v $(pwd):/data -it andir/espuntu
	else
		docker run --rm -v $(pwd):/data -it andir/espuntu
	fi
}
```
