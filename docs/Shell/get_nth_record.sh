#! /usr/bin/bash
## 
 #  @file      get_nth_record.sh
 #  @brief     Get Nth occurence of a pattern from a file
 #  
 #  @details   Using awk to extract a specific record from dump file
 #  
 #  $@param [in] $1     File
 #  $@param [in] $2     Occurence   [Default 1]
 #  $@param [in] $3     Pattern     [Default "=LDR\s+"]
 #  $@param [in] $3     Diff        if "-v" [Default ""]
 #
 #  @example    bash ./getnth.sh >out ; wc -l out
 #  @example    bash ./getnth.sh sourcefile Lineno "=TDR " -v >out
 #  
 #  @see       https://stackoverflow.com/a/13281580/7485823
 #  
 #  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 #  @author    Erik Bachmann <BIT@bib.sdu.dk>
 #  @since     2024-09-02T11:41:56 / erba
 #  @version   2024-09-02T16:30:13
 ##

# Print header
grep -E '^[ ]*#  @' $0 | cut -f2- -d @ | awk '$0="#*** "$0  "."' >&2
echo

_FILE="${1:-SDUB45_hold_001_2024-08-26.txt}"
_NO=${2:-1}
_PATTERN="${3:-=LDR\s+}"
_DIFF="${4:-}"

echo Extract ocurence ${_NO} of [${_PATTERN}] from ${_FILE} [${_DIFF}] >&2

# bash ./getnth.sh SDUB45_hold_001_2024-08-26.txt 3
#awk -v n=${_NO} "/^=${_PATTERN}/{l++} l==n" "${_FILE}" 

awk -v n=${_NO} "/^${_PATTERN}/{l++} l==n" "${_FILE}" | tr -d '\r' | tee  org

wc -l org >&2

if [ '-v' = "${_DIFF}"  ]; then
    echo Checking for control characters >&2
    # Remove carriage return
    awk -v n=${_NO} "/^${_PATTERN}/{l++} l==n" "${_FILE}" | tr -d '\r' > got
    # Expand control characters (except newline)
    ## Failing æøåÆØÅ
#|   awk '{$0=gensub(/\^M$/,"",1)}1' \
    awk -v n=${_NO} "/^${_PATTERN}/{l++} l==n" "${_FILE}" | cat -v     \
|   awk '
{   # Replace special characters
    gsub(/\^M$/,"", $0);        # Newline 
    gsub(/M-CM-&/,"æ", $0);     # æ 
    gsub(/M-CM-8/,"ø", $0);     # ø
    gsub(/M-CM-%/,"å", $0);     # å
    gsub(/M-CM-\^F/,"Æ", $0);   # Æ
    gsub(/M-CM-\^X/,"Ø", $0);   # Ø
    gsub(/M-CM-\^E/,"Å", $0);   # Å
    print $0;
}
' \
> exp

    diff got exp    >&2
    ls -ltr got exp >&2
#else
#  echo "try again"
fi

#*** EOF ***
