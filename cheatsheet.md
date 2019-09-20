# Variables
[Microsofts page about variables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-6)
## Define a new variable

Variables are defined by prefixing the name with a dollar-sign `$`
```posh
$VARNAME = EXPRESSION/DATA
```

To ensure that a variable doesn't get misinterpreted, it's recommended to always enclose the variable with curly braces `{}`
```posh
${VARNAME} = EXPRESSION/DATA
```
From here on out, everytime I reference a variable, I will be using this form since it's the safest way of referencing variables.
If we're not using the curly braces, there can be situations where Powershell won't be able to distinguish between the variable name and other characters.
You could also create variables with whitespace in them if you use curly braces, but refrain from doing so since it could make it harder to find the rows containing only your variables, it could easily match "regular text".

## Using a defined variable

To use a variable together with other applications or functions, just type it out in the same way as when you defined it.
```posh
${VARNAME} = "C:\myPath\Here"
Get-ChildItem -Path ${VARNAME}
```

# Objects

## Listing a objects properties

Almost all things in Powershell comes with **Properties** thanks to it's **Object Oriented** design.
This enables us to quickly access a lot of different information easily about anything we encounter.

The line below will 
1. List all objects in the current working directory 
1. Then it sends the objects it found to the method `Select-Object` (done through a **pipe**, which here is represented by the `|` character )
1. We then tell `Select-Object` to list all properties it finds (by using the wildcard `*`)
```posh
Get-ChildItem | Select-object -Property *
```

## Accessing a objects/variables properties 

Since Powershell is **Object Oriented**, your variables will often inherit **Properties** based on the type of objects you've stored in the variable, you can also give your variables properties you've define yourself.

This examples does the following:
1. create a variable to store all the file-extensions I wish to find
1. create a second variable to store the results from a search (using my first variable to define what files I want to find)
1. Output to the terminal the contents of the variable, but only the FullName property of all it's objects.
```posh
${FileExtension} = (".exe", ".dll")
${Files} = Get-ChildItem -Recurse -Path .\ -Include ${FileExtension}

Write-Output ${Files}.FullName
```
