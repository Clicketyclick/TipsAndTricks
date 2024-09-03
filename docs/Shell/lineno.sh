#!/bin/bash       
## 
 #  @fn        lineno.sh
 #  @brief     Showing the use of variables LINENO and BASH_LINENO
 #  
 #  @return    VOID
 #  
 #  @details   Debug output showing LINENO (Current line) BASH_LINE_NO (back trace)
 #  
 #  @example   bash ./lineno.sh
 #  
 #  @todo      
 #  @bug       
 #  @warning   
 #  
 #  @see       https://stackoverflow.com/a/17804850/7485823
 #              answered Jul 23, 2013 at 8:16 / Deqing
 #  @since     2024-09-03T08:21:39 / erba
 ##
function log() {
    echo "LINENO: ${LINENO}"
    echo "BASH_LINENO: ${BASH_LINENO[*]}"
}

function foo() {
    log "$@"
}

foo "$@"
#*** EOF ***
