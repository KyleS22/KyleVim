# KyleVim
A Vim plugin in the style of Kyle

This is my first attempt at a vim plugin, and is mostly just a replicate of my ``.vimrc``.  Hopefully someday this will expand into something actually useful.

# Features

## Code Dark Colourscheme
A nice dark colourscheme that replicates that of Visual Studio Code.  

## Basic Customized Statusline
A statusline that displays:
	- The current filetype
	- The full path to the current file
	- Whether the current file has been modified
	- The Current Line number and total number of lines
	- The virtual Column Number
	- The current git repository status, if applicable

## Easy Tab Controls
- Easily switch between tabs using <C-Left> and <C-Right>
- Move tabs around with <A-Left> and <A-Right>

## TODO Search
Use <F3> to search the current project for TODO lines.  Easily navigate to them and edit. 

## Cursor Pattern Replacement
Use the pattern {% WORD %}to indicate a replacable item.  Then use ';;' to jump to the next occurance of the pattern and replace it.

## Fuzzy Search
Use Shift-F to initiate a fuzzy search for file names

## Auto Close Brackets and quotes
Automatically close opening brackets.  Double-tap the opening bracket to temporarily disable auto closing for this brace.

## Easily Disable Any of These Features

Don't like one of these features, but want the rest?  You can easily disable individual features from your .vimrc using something like this:

```
let g:KyleVim_Disable_Colours = 1
```

A full description on how to disable features is available in the [documentation](https://github.com/KyleS22/KyleVim/blob/1ec23fbfc9b3c8f3c4655e55149acf72bed20a7f/doc/KyleVim.txt#L28-L40).

# Installation
This plugin can be installed using [Vundle](https://github.com/VundleVim/Vundle.vim).  Simply add the following line to your vimrc

```
Other Vundle Plugins

" KyleVim 
Plugin 'KyleS22/KyleVim' 

```

Then start up vim and run `:PluginInstall`


# Testing Environment

There is a blank vimrc file called testenv.vimrc.  Start vim as follows to create a blank testing environment: ``vim -u testenv.vimrc``

