# Scilab IOT Module

This is an Internet of Things toolbox for Scilab. It enables you to push and pull data from several cloud platforms into Scilab.
It makes use of both Scilab built-in functions and external Java libraries.

## Getting Started


### Prerequisites

1. Scilab 6.0.x or Scilab 6.1.x

### Installing

The module could be easily install from the Scilab atoms portal by using command:

--> atomsInstall('bytecode_iot_module'); 

or the offline version by replacing the input argument to the zip file name.

If you prefer to build then module, download the source and unzip it, just type in scilab:

```
--> exec("bytecode_iot_module_Path/builder.sce")
```

If the module is place in the "contrib" folder, it could be loaded from the "Toolboxes" menu. Otherwise, just type in scilab:

``` 
--> exec("bytecode_iot_module_path/loader.sce"); 
```

bytecode_iot_module_Path is where this file is.

### EXAMPLES and DEMOS
 To see some examples type in scilab:

--> help 

## Features
* Supports numbers of IoT Gateway, namely:
1. ThingsBoard
2. FavorIoT
3. Ubidots
4. ThingSpeak

## Revisions

### REVISION NOTES 1.1
BUGS FIXED
* Bugs fixed and new xml features 

NEW FEATURES
* Scan tables from webpage


## Version

This is the Revision 1.1 of Scilab IoT Module for Scilab 6.0.x

## Authors
Joshua Teoh and Tan Chin Luh (ByteCode Malaysia)
 

## License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

