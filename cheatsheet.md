= Variables =

== Define a new variable ==

Variables are defined by prefixing the name with a dollar-sign (`$`)
```posh
$VARNAME = EXPRESSION/DATA
```

To ensure that a variable doesn't get misinterpreted, it's recommended to always enclose the variable with curly braces (`{ }`)
```posh
${VARNAME} = EXPRESSION/DATA
```
From here on out, everytime I reference a variable, I will be using this form since it's the safest way of referencing variables.

== Using a defined variable ==

To use a variable together with other applications or functions, just type it out in the same way as when you defined it
```posh
Get-ChildItem -Path ${VARNAME}
```
