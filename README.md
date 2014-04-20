cpfb
====

Config Parser For Bash

### What?
The point of cpfb is to provide a config syntax parsable by bash, that maps directly to useful bash structures. It should read in to the basics:
* Standard key/value pairs, written in bash as ```MyVar=Value```
* Standard arrays, written in bash as ```MyArray=( "Index1" "Index2" )```
* Associative arrays, written in bash as ```declare -A MyArray=( [key]=value [key2]=value2 )```

Keys and values should be sanitised so they can be read directly, without comprimising your script security. 

### Dependencies
Currently cpfb depends on the following:
* Bash 4.2
* sed

### Examples
The example.conf should speak for itself, but here is the low down. I'll show a snippet and then the equivalent bash code.
Each variable type is defined in blocks, with the name of the block being the key for the variable and the lines beneath it being the values.

Key/value pair blocks are defined with the '::' string. They combine the block key and the line key and assign values to it with an = sign, as so:
```
::Name
    Item = Value
```
=> ```NameItem=Value```

Array blocks are defined with the '--' string. They use the block key, assigning values for each following line item, as so:
```
--MyArray
    FirstItem
    SecondItem
```
=> ```MyArray=( "FirstItem" "SecondItem" )```

Associatove array blocks are defined (similarly to standard arrays) with the '==' string. They use the block key, assigning key/value pairs for each item split by an = sign, as so:
```
==AnotherArray
    first = Thing
    second = More?
```
=> ```declare -A AnotherArray=( [first]=Thing [second]="More?" )```

### Usage
The tests script should show you all you need to know, but here it is anyways. You have to source cpfb in to your bash script, so keep it somewhere in your path. Then call the 'parseConfig' function, passing it the config file to parse.
```
. cpfb
parseConfig example.conf
echo "${MyArray[0]}"
```
