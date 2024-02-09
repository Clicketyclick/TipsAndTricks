
@@Iptc_logo@@

# Image tagging



## Supplemental Categories

Supplemental Categories can hold references to external structures like lists of people. 

I use this field for cross referencing people on pictures with my genealogy database.

### Geosetter

Supplemental Categories are stored in
`"%USERPROFILE%\AppData\Roaming\GeoSetter\config.ini"`
in the section `[Edit\History\34]` and numbered with 3 digits and a `u` as key

```
[Edit\History\34]
001u=Erik Bachmann Pedersen (00001)
002u=Ellen Herdis Bachmann Jørgensen (00004)
```

### XnViewMP - Suplemental Categories

Templates for IPTC can be stored directly in configuration using:
`"%USERPROFILE%\AppData\Roaming\XnViewMP\iptc.ini"`

IPTC fields `020` holds templates for **Suplemental categories** as a comma separated list
```
[General]
20=Erik Bachmann Pedersen (00001), ...
```

Note that extended characters must be escaped:


Reference: [Re: XMP and/or IPTC: set some required metadata fields...](https://newsgroup.xnview.com/viewtopic.php?p=184140&sid=f6550db958fbb77eeb31df96b239b1ac#p184140)

More complex data sets can be stored as XML in `iptc` files: Luxor.iptc

<fieldset>

<legend>
Warning! &#x26A0;
</legend>

Loading an `iptc` template will overwrite ALL dataelements in the picture.
<br>
You cannot pick and choose.

</fieldset>

<details>
    <summary>Example: Luxor.uptc</summary>

```
<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE iptc_template><iptc_template version="1.0">
    <tag_5/>
    <tag_7>
        <value>Favorit</value>
    </tag_7>
    <tag_15/>
    <tag_20>
        <list>
            <value>Erik Bachmann Pedersen (00001)</value>
            <value>Tove Juul Hansen (00002)</value>
        </list>
    </tag_20>
    <tag_22/>
    <tag_25>
        <list>
            <value>Egypten</value>
            <value>Luxor</value>
            <value>Morgenstemning</value>
        </list>
    </tag_25>
    <tag_26/>
    <tag_27>
        <list/>
    </tag_27>
    <tag_40/>
    <tag_55>
        <value>20230404</value>
    </tag_55>
    <tag_60>
        <value>055916</value>
    </tag_60>
    <tag_65/>
    <tag_70/>
    <tag_80>
        <value>ERIK BACHMANN</value>
    </tag_80>
    <tag_85/>
    <tag_90>
        <value>Luxor</value>
    </tag_90>
    <tag_92>
        <value>Luxor</value>
    </tag_92>
    <tag_95>
        <value>Luxor</value>
    </tag_95>
    <tag_100>
        <value>EGY</value>
    </tag_100>
    <tag_101>
        <value>Egypt</value>
    </tag_101>
    <tag_103/>
    <tag_105>
        <value>Ballonopstigning over Nilens vestbred</value>
    </tag_105>
    <tag_110>
        <value>Erik Bachmann</value>
    </tag_110>
    <tag_115/>
    <tag_116>
        <value>ERIK BACHMANN</value>
    </tag_116>
    <tag_118>
        <list/>
    </tag_118>
    <tag_120>
        <value>Morgenstemning i Luxor</value>
    </tag_120>
    <tag_122>
        <value>Erik Bachmann</value>
    </tag_122>
</iptc_template>
```

</details>
