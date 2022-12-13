## 
#  @file      trim.sh
#  @brief     Functions for trimming strings for whitespace
#  
#  @details   
#  
#  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
#  @since     2022-12-13T08:00:12 / erba
#  @version   2022-12-13T10:44:15
#  
#-----------------------------------------------------------------------

## 
#  @fn        trim, ltrim, rtrim
#  @brief     trim leading and trailing whitespace from string
#  
#  @param [in] mix      String to be trimmed
#  @return    Trimmed string
#  
#  @details   Trimming string using sed
#  
#  @example   
#       . "./trim.sh"
#       mix="  123 456  "
#       echo "mix[$mix]"
#       echo "trim1[`trim "$mix"`]"
#       
#       mix="  123 456  "
#       trim=`trim "$mix"`
#       echo "trim2[$trim]"
#       
#       mix="  123 456  "
#       trim=`ltrim "$mix"`
#       echo "ltrim[$trim]"
#       
#       mix="  123 456  "
#       trim=`rtrim "$mix"`
#       echo "rtrim[$trim]"
#   
#   Should give:
#       mix[  123 456  ]
#       trim1[123 456]
#       trim2[123 456]
#       ltrim[123 456  ]
#       rtrim[  123 456]
#               
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://stackoverflow.com/a/3232433
#  @since     2022-12-13T08:00:42 / erba
#  
ltrim()
{
    local FOO_NO_LEAD_SPACE="$(echo -e "${1}" | sed -e 's/^[[:space:]]*//')"
    echo -e "${FOO_NO_LEAD_SPACE}"
}   # ltrim()

#-----------------------------------------------------------------------

rtrim()
{
    local FOO_NO_TRAIL_SPACE="$(echo -e "${1}" | sed -e 's/[[:space:]]*$//')"
    echo -e "${FOO_NO_TRAIL_SPACE}"
}   # rtrim()

#-----------------------------------------------------------------------

trim()
{
    local FOO_NO_EXTERNAL_SPACE="$(echo -e "${1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    echo -e "${FOO_NO_EXTERNAL_SPACE}"
}   # trim()

#-----------------------------------------------------------------------

#*** End of File ***
