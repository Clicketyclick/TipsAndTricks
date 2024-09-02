## Get Doxy header in batch


```shell
#!/bin/sh
##
#  @file      Filename.sh
#  @brief     Brief description
#  
#  @details   More details
#  
#  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
#  @since     2024-06-11T13:50:44 / erba
#  @version   2024-06-13 10:12:50
#

# Print header
grep -E '^#  @' $0 
# grep -E '^#  @' $0 | cut -f2 -d @ 
#
```

Should give:

```console
#  @file      Filename.sh
#  @brief     Brief description
#  @details   More details
#  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
#  @since     2024-06-11T13:50:44 / erba
#  @version   2024-06-13 10:12:50
```


