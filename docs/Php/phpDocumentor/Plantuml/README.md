## Adding PlantUML to phpDocumentor

Source: https://chatgpt.com/c/6add0aa6-291c-83eb-a4bd-586215bcd945

> How can I set a windows based phpdocumentor to generate plantuml diagrams?

To generate PlantUML class diagrams automatically from PHP source code using phpDocumentor on Windows 11, you need phpDocumentor 3, PlantUML, and Java.

The essential option is:

```
--setting=graphs.enabled=true
```

For example:

```
php phpDocumentor.phar run -d "C:\dev\ByteMARC\src" -t "C:\dev\ByteMARC\docs\api" --setting=graphs.enabled=true
```

phpDocumentor supports PlantUML-generated class diagrams, but diagram generation must be enabled explicitly. Since phpDocumentor 3.7.0, you can also specify the PlantUML executable using the `PHPDOC_PLANTUML_BIN` environment variable.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.phpdoc.org\&sz=32)

docs.phpdoc.org

+1



## 1. Install the required components

| Component          | Purpose                                  | Download                                                                           |
| ------------------ | ---------------------------------------- | ---------------------------------------------------------------------------------- |
| PHP 8.1.2+         | Runs phpDocumentor                       | [PHP for Windows](https://windows.php.net/download/?utm_source=chatgpt.com)        |
| phpDocumentor 3.7+ | Analyzes PHP and generates documentation | [phpDocumentor PHAR](https://phpdoc.org/phpDocumentor.phar?utm_source=chatgpt.com) |
| Java               | Runs PlantUML                            | [Eclipse Temurin](https://adoptium.net/?utm_source=chatgpt.com)                    |
| PlantUML           | Generates UML diagrams                   | [PlantUML download](https://plantuml.com/download?utm_source=chatgpt.com)          |

I suggest this directory layout:

```
C:\tools\
    phpdocumentor\
        phpDocumentor.phar

    plantuml\
        plantuml.jar
        plantuml.cmd
```

Verify Java and PHP from Windows CMD:

```
php -v
java -version
php -m | findstr /I "mbstring"
```

The `mbstring` extension must be enabled for phpDocumentor.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.phpdoc.org\&sz=32)

docs.phpdoc.org



## 2. Configure PlantUML on Windows

Download the PlantUML JAR and save it as:

`C:\tools\plantuml\plantuml.jar`

Create `C:\tools\plantuml\plantuml.cmd` containing:

```

@echo off
java -Djava.awt.headless=true -jar "C:\tools\plantuml\plantuml.jar" %*

```

Test the executable:

```
C:\tools\plantuml\plantuml.cmd -version
C:\tools\plantuml\plantuml.cmd -testdot
```

The second command checks Graphviz support. Recent versions of PlantUML can provide a bundled Graphviz executable on Windows, so a separate Graphviz installation is not always needed.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://plantuml.com\&sz=32)

PlantUML.com



Now tell phpDocumentor where to find PlantUML:

```
set "PHPDOC_PLANTUML_BIN=C:\tools\plantuml\plantuml.cmd"
```

This setting applies to the current CMD session.

You can verify it with:

```
echo %PHPDOC_PLANTUML_BIN%
```

## 3. Generate the documentation and diagrams

From the project directory:

```
php C:\tools\phpdocumentor\phpDocumentor.phar run ^
    -d "." ^
    -t "docs\api" ^
    --setting=graphs.enabled=true
```

The generated documentation should include class diagrams showing inheritance and interface relationships, provided your source contains relevant classes.

## 4. Make the configuration permanent

Instead of specifying `graphs.enabled` every time, add this to the project's `phpdoc.dist.xml`:

```

<?xml version="1.0" encoding="UTF-8"?>
<phpdocumentor
    configVersion="3"
    xmlns="https://www.phpdoc.org">

    <title>ByteMARC API Documentation</title>

    <paths>
        <output>docs/api</output>
        <cache>docs/cache</cache>
    </paths>

    <version number="6.4">
        <api>
            <source dsn=".">
                <path>lib</path>
                <path>actions</path>
            </source>
        </api>
    </version>

    <setting name="graphs.enabled" value="true"/>

</phpdocumentor>

```

Adjust the source paths to match your project. With this configuration, the command becomes:

```
php C:\tools\phpdocumentor\phpDocumentor.phar run
```

The XML configuration and custom settings are supported by phpDocumentor 3.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.phpdoc.org\&sz=32)

docs.phpdoc.org



## 5. Alternative: Use the PlantUML server

If local PlantUML execution fails, phpDocumentor 3.7+ can use a remote rendering server:

```
set "PHPDOC_PLANTUML=plantuml-server"
set "PHPDOC_PLANTUML_SERVER=https://www.plantuml.com/plantuml/svg/"
```

Run phpDocumentor normally afterward.

The public server has limitations on diagram size, and UML descriptions are transmitted to an external service. For local development, I recommend the locally installed version.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.phpdoc.org\&sz=32)

docs.phpdoc.org



## 6. What diagrams will you get?

phpDocumentor's built-in automatic diagrams focus on PHP class structure:

- Class inheritance (`extends`)
- Implemented interfaces (`implements`)
- Class, interface and trait relationships

It does not automatically reconstruct sequence diagrams, database ER diagrams or complete application control flow.

For your ByteMARC project, it can be useful for documenting relationships among the PHP classes in `lib/`.

The generated documentation includes rendered UML graphics (typically SVG), rather than functioning as a general-purpose exporter of editable `.puml` files.

Official references: [phpDocumentor diagram generation](https://docs.phpdoc.org/guide/guides/generate-diagrams.html?utm_source=chatgpt.com) and [Class diagram directives](https://docs.phpdoc.org/guide/hand-written-docs/directives.html?utm_source=chatgpt.com).
