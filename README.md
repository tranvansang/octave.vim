# Octave.vim

*Github version of: http://www.vim.org/scripts/script.php?script_id=3600*

This file provides syntax highlighting for the GNU Octave programming language.

### Features
* Highlights entire Octave grammar (endwhile, endfor, etc.), not just Matlab keywords
* Updated to highlight all core Octave functions as of version 4.2.0
* Highlights user functions and anonymous functions [@(...)] from within the .m file being edited
* Use-dependent highlighting of Octave system variables
   When querying system variables, keyword is highlighted as a constant.  For example, var = true, highlights 'true' as a constant.
   When setting variables or otherwise invoking keyword as a function, keyword is highlighted as a function.  For example, var = true (2,4), highlights 'true' as a function.
* Support for multi-line strings with line continuation characters as well as escaped quotes (\" or \') within string.
* Support for multi-line block comments
* Support for highlighting numbers that use hex (0x) or binary (0b) syntax
* Error highlighting for bad number syntax, bad structure variable names, bad block comments, bad line continuations.
* Optional support for highlighting operators (+, -, \*, etc.), user variables, or tabs

### Errata
* Occasionally anonymous functions are highlighted as a function even though the instance is of the name as a variable.  This is too difficult to correct without writing a full parser.

### OMNIFUNC
* The syntax file has a list of every valid function in Octave which makes it useful as an auto-completion dictionary for use with ViM's omnifunc function.  Once installed, type a few letters of the name of a function and then use Ctrl-X Ctrl-O to bring up a list of possible matches.

### Addenda

This script owes some debt to the two existing Octave syntax scripts:
- http://www.vim.org/scripts/script.php?script_id=1241
- http://www.vim.org/scripts/script.php?script_id=1591

However, it has been thoroughly rewritten and expanded considerably.

### Install
With [vim-plug](https://github.com/junegunn/vim-plug)
- Append `Plug 'tranvansang/octave.vim'` to your `.vimrc`
- Restart vim or run `:source ~/.vimrc`
- Run `:PlugInstall`
