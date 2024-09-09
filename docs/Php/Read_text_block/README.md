## readTextBlock.php

Read a block of text from file delimited by string as a record delimited

The delimiter can either be prefixed, suffixed - or removed


### Example

Given the data:

```
01
02
###
04
05
###
07
08
```

```php
$delimiter  = '###';
$direction  = -1;    // Default: prefixed
$fp = @fopen("readTextBlock.txt", "r");
while( $record = get_text_block( $fp, $delimiter, $direction ) )  // Get each record
{
    echo "[$record]\n";
}
fclose($fp);
```

Output:

#### Direction: -1   // Suffix

Delimiter will be at the end of record (Suffixed)

```
[01     02      ###     ]
[04     05      ###     ]
[07     08      ]
```

#### Direction: 0   // None

Delimiter will be removed from record

```
[01     02      ]
[04     05      ]
[07     08      ]
```

#### Direction: 1   // Prefix

Delimiter will be at the start of record (Prefixed)
```
[01     02      ]
[###    04      05      ]
[###    07      08      ]
```

## Files

- [readTextBlock.php](readTextBlock.php) module file - Read a block of text from file delimited by string
- [readTextBlock__test.php](readTextBlock__test.php) - Testing: Read a block of text from file delimited by string
- [readTextBlock.txt](readTextBlock.txt) - test data
