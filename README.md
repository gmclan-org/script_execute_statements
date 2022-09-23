# script_execute_statements()

function which executes only non-function parts of scripts.

### How it works?

Since GameMaker Studio 2.3+ update, functions were added, and scripts started to work as files with code, which can not only contain more than one function, but can also contain code executed on game start, which is not a part of any functions.

To keep backward-compatibility, YYG decided, that if script contains function with same name as script, that will cause calling that function, but otherwise it will call all non-function part of script. Sounds complicated? Take a look at example:


**Legacy Script:**<br>
Script name: `SCR_A`<br>
Contents:
```gml
<some statement>; // this will be executed on Game Start

function SCR_A() {} // this have same name as script, so calling SCR_A() will execute this function
function SCR_B() {} // this have different name as script, so calling SCR_B() will execute this function, but calling SCR_A() will not use it
```
Calling `SCR_A()` in above case, will only call `SCR_A()` *function*, not `SCR_A()` *script*.


**Non-legacy Script:**<br>
Script name: `MY_SCRIPT`<br>
Contents:
```gml
<some statement>; // this will be executed on Game Start, and when MY_SCRIPT() called

function SCR_A() {} // this have same name as script, so calling SCR_A() will execute this function, but calling MY_SCRIPT() will not use it
function SCR_B() {} // this have different name as script, so calling SCR_B() will execute this function, but calling MY_SCRIPT() will not use it
```

So, when calling `MY_SCRIPT` if there's no function with same name, you can execute normal statements (which aren't inside any function body) during game as many times as you wish.<br>
But there's no way to call `SCR_A` statements this way.

What's worse `script_execute()` will also execute functions only in case of Legacy Scripts, but will execute statements in case of scritps which have unique name (modern 2.3+ way).

Function `script_execute_statements(scr_name)` solves that, by doing a big loop on all GM scripts and functions, searching for pointer for scripts which have same name as functions - and always executes scripts in a new way.
This function have no other arguments, as scripts cannot have arguments too - only functions have them.
