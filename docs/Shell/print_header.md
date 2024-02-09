## Print script header

```sh
#/**
# *  @file      filename.sh
# *  @brief     Dummy header
# *  
# *  @details   $(More details)
# *  
# *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
# *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
# *  @since     2024-01-10T09:21:19 / erba
# *  @version   2024-01-10T09:21:19
# *  
# */
```

```sh
# Print header
function print_header() {
	printf -- '-%.0s' {1..80}
  echo
  grep '#\s*\*\s*@' $0 | cut -d@ -f2-
  printf -- '-%.0s' {1..80}
  echo
}	#*** print_header() ***
print_header
```
Will print

```console
--------------------------------------------------------------------------------
file      filename.sh
brief     Dummy header
details   $(More details)
copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
since     2024-01-10T09:21:19 / erba
version   2024-01-10T09:21:19
--------------------------------------------------------------------------------
```
