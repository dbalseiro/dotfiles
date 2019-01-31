# Link to specification or issue number
https://github.com/plow-technologies/all/issues/664

# Focus areas for review

* Removed  the anchor in the result column.
* Made the row clickable to mimic the behavior of the old anchor
* Added a new function in ReasonML to remove the exponent in the result similar to https://github.com/plow-technologies/all/blob/a96e18922825033a2a025fb29fd6ca68d4360b4e/onping2.0/onping-static/js_custom/onping-util.js#L29 and reproduced the tests from https://github.com/plow-technologies/all/blob/a96e18922825033a2a025fb29fd6ca68d4360b4e/onping2.0/onping-static/js_custom/onping-util-spec.js#L19

# UI Screenshots

![image](https://user-images.githubusercontent.com/2053849/51848362-765d5d80-22eb-11e9-90f2-62c43f981c29.png)
![image](https://user-images.githubusercontent.com/2053849/51848438-9725b300-22eb-11e9-8986-d8867de669f4.png)


# UI Screenshots Mobile

# Tasks for PR creator

## Version
* [x] Update **version** in all projects with changes

## Changelog
* [x] Add changelog entry
* [x] Mention **breaking** changes
* [x] Mention **serialization** changes

## Build
* [x] **`-Werror`** is enabled in all projects
* [x] **Tests** are being run in build script
* [x] **Documentation** is being generated in build script

## Comments
* [x] Description at top of each **module**. [Example.](https://www.haskell.org/haddock/doc/html/ch03s03.html)
* [x] **How** to use common functions and data types
* [x] **Why** functions and data types are written the way they are

# Tasks for PR reviewer
* Carefully review **focus areas**
* **Ask for clarification** of confusing code
* Check for **dropped errors**
* Check for **readability** of variables and other names

# First PR Checklist
These are items that should be checked on the first time a PR is made

## Enable warnings
* [x] `-Wall`
* [x] `-Werror`
* [x] `-Wincomplete-uni-patterns`
* [x] `-Wincomplete-record-updates`
