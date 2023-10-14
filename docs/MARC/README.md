# MARC based tips


## Convertion between MARC21 and RIS

- Use [MarkEdit](https://marcedit.reeset.net/) to convert between line based (.mrk) and ISO.2709 (.mrc)
- Use [marc2ris](http://manpages.ubuntu.com/manpages/trusty/man1/marc2ris.1.html) (Ubuntu) for converting .mrc to RIS

### LOC to marc2ris 
- Line start= `=`
- `-` to `\`

- Record start `=LDR`
- Fieldseparator `|` to `$`
- Fieldtag followed `\t` to `  ` (two blanks)

## References
- https://marcedit.reeset.net/
- http://manpages.ubuntu.com/manpages/trusty/man1/marc2ris.1.html
- http://www.loc.gov/marc/makrbrkr.html works only on 16 bit systems

