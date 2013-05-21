" DBGp client: a remote debugger interface/client to the DBGp protocol
"
"=============================================================================
" Script Info and Documentation
"=============================================================================
" Name Of File: debugger.vim, debugger.py
"  Description: remote debugger client/interface to DBGp protocol
"  Maintainer:  Jared Cobb <github <at> jaredcobb.com>
"  Last Change: February 23rd 2013
"          URL: https://github.com/jaredcobb/DBGp-Remote-Debugger-Interface
"      Version: 1.0.3.3
"				
"				Changelog for 1.0.3.3
"				- Removed hard coded breakpoint colors, using a default scheme
"
"				Changelog for 1.0.3.2
"				- Added default mappings back, but wrapping them in global flag
"				- Added global flag to disable the help screen
"				
"				Changelog for 1.0.3.1
"				- Made python script loader relative to plugin
"				
"				Changelog for 1.0.3
"				- Fixed bug in viewing associative array names / children
"				- Fixed bug in restoring MiniBufExplorer on quit
"				- Removed mappings in .vim file for function keys (use your own)
"				- Added plugin folder support for Pathogen setups (assuming folder name)
"
"				Forked by Hadi Zeftin <slack.dna <at> gmail.com>
"				Changed on January 7, 2009
"				at https://github.com/vim-scripts/DBGp-Remote-Debugger-Interface
"				
"               Originally written by Seung Woo Shin <segv <at> sayclub.com>
"               at	http://www.vim.org/scripts/script.php?script_id=1152
"               
"				Developed by Sam Ghods <sam <at> box.net>
"               at http://www.vim.org/scripts/script.php?script_id=1929
"        Usage: 
"
"				Map your preferred shortcuts to the following plugin functions
"				(copy/paste the mappings below into your .vimrc, some people like 
"				function keys, I preferred leader keys)
"
"				Then you can disable the default function key mappings (used in this 
"				plugin) by setting the following flag in your vimrc:
"				
"				  let g:debuggerDisableDefaultMappings = 1
"				
"			  	  map <leader>1 :python debugger_resize()<cr>
"				  map <leader>2 :python debugger_command('step_into')<cr>
"				  map <leader>3 :python debugger_command('step_over')<cr>
"				  map <leader>4 :python debugger_command('step_out')<cr>
"				  map <leader>5 :python debugger_run()<cr>
"				  map <leader>6 :python debugger_quit<cr>
"				  map <leader>9 :python debugger_context()<cr>
"				  map <leader>0 :python debugger_property()<cr>
"				  map <leader>9 :python debugger_watch_input("context_get")<cr>A<cr>
"				  map <leader>0 :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>
"				  map <leader>b :Bp<cr>
"				  map <leader>e :python debugger_watch_input("eval")<cr>A
"				
"				By default, the following keys are mapped automatically
"				
"				  map <F1> :python debugger_resize()<cr>
"				  map <F2> :python debugger_command('step_into')<cr>
"				  map <F3> :python debugger_command('step_over')<cr>
"				  map <F4> :python debugger_command('step_out')<cr>
"				  map <F5> :python debugger_run()<cr>
"				  map <F6> :python debugger_quit()<cr>
"				  map <F11> :python debugger_context()<cr>
"				  map <F12> :python debugger_property()<cr>
"				  map <F11> :python debugger_watch_input("context_get")<cr>A<cr>
"				  map <F12> :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>
"				  nnoremap ,e :python debugger_watch_input("eval")<cr>A
"
"               To disable the help pane from showing (since you've memorized your 
"				shortcuts and want more screen real estate) set this flag:
"				
"				 let g:debuggerDisableHelpPane = 1
"
"               To customize your breakpoint and current line highlighting
"				simply define your highlighting in your vimrc like so and set
"				the global flag useCustomColors = 1. (These are the defaults, 
"				see :help hi for more info on what colors are possible)
"
"				 let g:useCustomColors = 1
"				 hi DbgCurrent term=reverse ctermfg=White ctermbg=Red gui=reverse
"				 hi DbgBreakPt term=reverse ctermfg=White ctermbg=Green gui=reverse
"				
"				 let g:debuggerDisableHelpPane = 1
"				
"				To set the socket waiting time before timeout(default 
"               10 second) use :
"               
"                 let g:debuggerTimeout = 10
"
"               By default the script will create a dedicated tab for each 
"               debugging session, 
"
"                 let g:debuggerDedicatedTab = 1
"
"               If you don't want a dedicated tab for each debugging session
"               change it to 0, remember you will lose undo history on that
"               tab!
"
"               Note : 
"               If you are using gVim/vim.gui and want to use a dedicated tab 
"               make sure to always show tab
"
"               if has("gui_running")
"                 if has("gui_gtk2")
"                   set showtabline=2
"                 endif
"               endif
"
"               Put the snippet above on your ~/.vimrc file, this is
"               regarding the resize bug on vim with gtk
"
"
"
"               Wrote by Sam Ghods :
"
"               This file should reside in the plugins directory along
"               with debugger.py and be automatically sourced.
"
"               By default, the script expects the debugging engine to connect
"               on port 9000. You can change this with the g:debuggerPort
"               variable by putting the following line your vimrc:
"
"                 let g:debuggerPort = 10001
"
"               where 10001 is the new port number you want the server to
"               connect to.
"
"               There are three maximum limits you can set referring to the
"               properties (variables) returned by the debugging engine.
"
"               g:debuggerMaxChildren (default 32): The max number of array or
"               object children to initially retrieve per variable.
"               For example:
"
"                 let g:debuggerMaxChildren = 64
"
"               g:debuggerMaxData (default 1024 bytes): The max amount of
"               variable data to retrieve.
"               For example:
"
"                 let g:debuggerMaxData = 2048
"
"               g:debuggerMaxDepth (default 1): The maximum depth that the
"               debugger engine may return when sending arrays, hashs or
"               object structures to the IDE.
"               For example:
"
"                 let g:debuggerMaxDepth = 10
"
"               Finally, if you use the Mini Buffer Explorer vim plugin,
"               minibufexpl.vim, running the debugger may mess up your window
"               setup. As a result the script has support to close and open
"               the explorer when you enter and quit debugging sessions. To
"               enable this support, add the following line to your vimrc:
"
"                 let g:debuggerMiniBufExpl = 1
"
"      History: 1.0.1 o create a dedicated tab for debugging for every new
"                       debugging session, to retain undo history for other tab
"                       contributed by Michael Bahnmiller
"               1.0   o add tab-page support for Vim 7.x from Sam Ghods latest script
"                       at http://www.vim.org/scripts/script.php?script_id=1929
"      
" Known Issues: o if you are using gVim, makesure the showtabline options set to
"                 2 (always show tab) before start a new debugging session, 
"                 this is a known problem to the gtk/gnome build about
"                 gui window resizing.
"               o there are possibility after each debugging session ends, the
"                 folding, coloring, etc goes weird. this may occur if you're using 
"                 a custom syntax file, so you might wanna re-source your syntax
"                 file after each debugging session
"
"         Todo: so many to do, but first thing first, revamp the python script
"
"=============================================================================


"=============================================================================
" check that everything is OK
"=============================================================================
if !has("python")
    finish
endif

if filereadable(expand("<sfile>:p:h")."/debugger.py")
  execute "pyfile " . expand("<sfile>:p:h")."/debugger.py"
elseif filereadable($VIMRUNTIME."/plugin/debugger.py")
  pyfile $VIMRUNTIME/plugin/debugger.py
elseif filereadable($HOME."/.vim/plugin/debugger.py")
  pyfile $HOME/.vim/plugin/debugger.py
elseif filereadable($VIM."/vimfiles/plugin/debugger.py")
  pyfile $VIM/vimfiles/plugin/debugger.py
else
  call confirm('debugger.vim: Unable to find debugger.py. Place it in either your home vim directory or in the Vim runtime directory.', 'OK')
endif

"=============================================================================
" Initialization
"=============================================================================
command! -nargs=? Bp python debugger_mark('<args>')
command! -nargs=0 Up python debugger_up()
command! -nargs=0 Dn python debugger_down()

sign define current text=->  texthl=DbgCurrent linehl=DbgCurrent
sign define breakpt text=B>  texthl=DbgBreakPt linehl=DbgBreakPt

if !exists('g:debuggerPort')
  let g:debuggerPort = 9000
endif 
if !exists('g:debuggerMaxChildren')
  let g:debuggerMaxChildren = 32
endif
if !exists('g:debuggerMaxData')
  let g:debuggerMaxData = 1024
endif
if !exists('g:debuggerMaxDepth')
  let g:debuggerMaxDepth = 1
endif
if !exists('g:debuggerMiniBufExpl')
  let g:debuggerMiniBufExpl = 0
endif
if !exists('g:debuggerTimeout')
    let g:debuggerTimeout = 10
endif
if !exists('g:debuggerDedicatedTab')
    let g:debuggerDedicatedTab = 1
endif
if !exists('g:debuggerDebugMode')
    let g:debuggerDebugMode = 0
endif
if !exists('g:debuggerDisableDefaultMappings')
	let g:debuggerDisableDefaultMappings = 0
endif
if !exists('g:debuggerDisableHelpPane')
	let g:debuggerDisableHelpPane = 0
endif
if !exists('g:useCustomColors')
  hi DbgCurrent term=reverse ctermfg=White ctermbg=Red gui=reverse
  hi DbgBreakPt term=reverse ctermfg=White ctermbg=Green gui=reverse
endif

"=============================================================================
" Setup default mappings if applicable
"=============================================================================
if g:debuggerDisableDefaultMappings == 0
	map <F1> :python debugger_resize()<cr>
	map <F2> :python debugger_command('step_into')<cr>
	map <F3> :python debugger_command('step_over')<cr>
	map <F4> :python debugger_command('step_out')<cr>
	map <F5> :python debugger_run()<cr>
	map <F6> :python debugger_quit()<cr>
	map <F11> :python debugger_context()<cr>
	map <F12> :python debugger_property()<cr>
	map <F11> :python debugger_watch_input("context_get")<cr>A<cr>
	map <F12> :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>
	nnoremap ,e :python debugger_watch_input("eval")<cr>A
endif

"=============================================================================
" Init Debugger python script
"=============================================================================

python debugger_init()
