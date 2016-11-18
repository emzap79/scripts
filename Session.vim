let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <C-S-Tab> =UltiSnips#ListSnippets()
inoremap <silent> <S-Tab> =UltiSnips#ExpandSnippet()
inoremap <Nul> 
inoremap <F10> :call ToggleYCM()
inoremap <C-F9> :call ToggleFoldColumn()
inoremap <F9> :call ToggleTextwidth()
inoremap <M-S-F8> :call AutoCorrect()
inoremap <M-F8> :w !detex | wc -w
inoremap <C-F8> :w!:!/usr/bin/aspell --dont-backup --dont-tex-check-comments check %:e! %
inoremap <F8> :call ToggleSpell()
inoremap <F6> :cd %:p:h:echo expand('%:p')
inoremap <F5> :FufMruFile
inoremap <C-F4> :FufFile
inoremap <S-F4> :FufFileWithFullCwd
inoremap <F4> :FufFileWithCurrentBufferDir
inoremap <S-F3> :buffer
inoremap <F3> :FufBuffer
inoremap <silent> <F2> :silent! :mks!:Git add %:p:exe "w | so $MYVIMRC | if foldclosed(\".\") >= 0 | %foldo! | endif"
inoremap <F1> :echom "f2: save and source file | f3: bufferlist | f4: open file | f5: open mru file | f6: cd to curr | f7: language tool | f8: spell-check | f9: textwidth | f10: enable YCM"
nnoremap <silent>  :call AddSubtract("\", '')
snoremap <silent>  c
nnoremap  <Left>
nnoremap <NL> <Down>
nnoremap  <Up>
nnoremap  <Right>
nnoremap  :call CurPos("save")$p :call CurPos("restore")
snoremap  "_c
vnoremap  <Plug>(expand_region_shrink)
nnoremap  V
vnoremap S :aboveleft split
nnoremap S :aboveleft split
nnoremap <silent>  :call AddSubtract("\", '')
nnoremap <silent>  :nohl
nnoremap ß :b #
map  Htd <Plug>AM_Htd
map  rwp <Plug>RestoreWinPosn
map  swp <Plug>SaveWinPosn
nmap <silent>  ns :%!spamassassin -d  " removes all SpamAssassin markup from the message inside of *mutt*
nnoremap <silent>   :call AddSubtract("\", 'b')
nnoremap <silent>   :call AddSubtract("\", 'b')
nnoremap  m :'a,'s
vnoremap  p :'{,'}
nnoremap  p :'{,'}
vnoremap  v :'<,'>
vnoremap  gq gqip``
nnoremap  gq gqip``
nnoremap  pp :RunSilent xdg-open /tmp/vim-pandoc-out.pdf
nnoremap  cp :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %
vnoremap <silent>  cx :XeLatexCompilePDF
nnoremap <silent>  cx :silent! CompilePdfXeLaTeX
vnoremap <silent>  cl :CompilePdfLaTeX
nnoremap <silent>  cl :silent! CompilePdfLaTeX
vnoremap <silent>  ct :CompilePdfTeX
nnoremap <silent>  ct :silent! CompilePdfTeX
nnoremap <silent>  cr :silent! CompilePdfRnw
nnoremap <silent>  col :exe "'{,'}!column -t"
vnoremap  so :source $MYVIMRC
nnoremap  so :source $MYVIMRC
nnoremap  dos :call Unix2Dos()
vnoremap <silent>  it vip:s/^/\\item /g
nnoremap <silent>  it vip:s/^/\\item /g
nnoremap  fh :Mirror
nnoremap <silent>  uu mz :s/\<\w\+/\u\0/g:nohl`z
nnoremap <silent>  u^ :normal! mz^gUl`z:nohl
nnoremap <silent>  u :normal! mzlbgUl`z:nohl
nnoremap  exh :let @+=expand("%:p:h") " directory name (/something/src)
nnoremap  exf :let @+=expand("%:t")   " filename       (foo.txt)
nnoremap  exP :let @+=expand("%:p")   " absolute path  (/something/src/foo.txt)
nnoremap  exp :let @+=expand("%")     " relative path  (src/foo.txt)
vnoremap  cw :w !detex | wc -w
nnoremap  cw :w !detex | wc -w
nnoremap  cc xP:s/-/&/gn
vnoremap  ? ?\<\><Left><Left>
nnoremap  ? ?\<\><Left><Left>
vnoremap  / /\<\><Left><Left>
nnoremap  / /\<\><Left><Left>
nnoremap <silent>  da :%s/\s\s\+/ /g:nohl``
nnoremap <silent>  d$ :let _s=@/|:%s/\s\+$//e|:let @/=_s|:nohl``
nnoremap <silent>  d0 :'{,'}s/^\s\+//g:nohl``
vnoremap <silent>  dv :B s/\s\s\+/ /g:nohl
nnoremap <silent>  dP :'{,'}s/\s\s\+//g:nohl``
nnoremap <silent>  dp :'{,'}s/\s\s\+/ /g:nohl``
nnoremap <silent>  dd :exe '%g/^\(.*\)\(\r\?\n\1\)\+$/d | %!uniq'``
vnoremap  bb :g/^\_$\n\_^$/d
nnoremap  bb :g/^\_$\n\_^$/d
xnoremap  r :'{,'}s/\<=GetVisualSelection()\>/
xnoremap  R :%s/\<=GetVisualSelection()\>/
nnoremap  r :'{,'}s/\<=expand('<cWORD>')\>/
nnoremap  R :%s/\<=expand('<cWORD>')\>/
nnoremap  X #``cgN
nnoremap  x *``cgn
nmap  sS :exe "%s/\\s*\;\\s*/\\;/g | nohls"
nmap  ss :exe "s/\[^,\]\\zs\\s/\\; /g | nohls"
vnoremap <silent>  b# :s/-/#/g3
nnoremap <silent>  b# :s/-/#/g3
vnoremap  s :s/\<
nnoremap  s :s/\<
vnoremap  : :%s/
nnoremap  : :%s/
vnoremap  dt :r!othes =GetVisualSelection()
nnoremap  dt :exe "r!othes " . shellescape(expand("<cword>"))
vnoremap  di :!dict =GetVisualSelection()
nnoremap  di :exe "!dict " . shellescape(expand("<cword>"))
vnoremap  dg :!ding =GetVisualSelection()
nnoremap  dg :exe "!ding " . shellescape(expand("<cword>"))
nnoremap  as :let @/.='\|\<'.expand("<cword>").'\>'
nnoremap  fs :! firefox 'http://stackoverflow.com/search?q==StackOverflow()' 
nnoremap  ft :! firefox 'http://tex.stackexchange.com/search?q==Tex()' 
nnoremap  fg :! firefox 'http://google.de/search?q==Google()' 
nnoremap  fw :! firefox 'http://de.wikipedia.org/w/index.php?search==Wikipedia()' 
nnoremap <silent>  - :exe "vert resize " . (winwidth(0) * 2/3)
nnoremap <silent>  + :exe "vert resize " . (winwidth(0) * 3/2)
nnoremap  vb :lcd %:p:h:vertical sb 
nnoremap  v :'<,'>
nnoremap  ht :helptags ~/.vim/doc
nnoremap  vf :ldc %:p:h:vertical find 
nnoremap  e :lcd %:p:h:e 
vnoremap  wo :call Wipeout()
nnoremap  wo :call Wipeout()
vnoremap  sn :lcd %:p:h:so Session.vim
nnoremap  sn :lcd %:p:h:so Session.vim
nnoremap <silent>  pw :call DoWindowSwap()
nnoremap <silent>  mw :call MarkWindowSwap()
vnoremap <silent>  fk :normal pzf'a
nnoremap <silent>  fk :normal pzf'a
nnoremap <silent>  fl :normal yyma
vnoremap <silent>  yP :normal yygccp
nnoremap <silent>  yP :normal yygccp
vnoremap <silent>  yp :normal yyp
nnoremap <silent>  yp :normal yyp
nnoremap  bu :BundleInstall!
nnoremap  bi :BundleInstall
nnoremap  bc :BundleClean!
nnoremap  bl :BundleList
vnoremap <silent>  md :exe 'delm! | delm A-Z0-9 | echom "all marks removed!"'
nnoremap <silent>  md :exe 'delm! | delm A-Z0-9 | echom "all marks removed!"'
vnoremap <silent>  mn :NoShowMarks
nnoremap <silent>  mn :NoShowMarks
vnoremap <silent>  ms :DoShowMarks
nnoremap <silent>  ms :DoShowMarks
vnoremap <silent>  ob :Obsession 
nnoremap <silent>  ob :Obsession 
nnoremap  gpl :Dispatch! git pull
nnoremap  gps :Dispatch! git push
nnoremap  go :Git checkout 
nnoremap  gb :Git branch 
nnoremap  gm :Gmove 
nnoremap  grp :Ggrep 
nnoremap  gl :silent! Glog:bot copen
nnoremap  gw :Gwrite
nnoremap  gr :Gread
nnoremap  ge :Gedit
nnoremap  gd :exe "Gdiff | %foldo!"
nnoremap  gt :Gcommit -v -q %:p
nnoremap  gc :Gcommit -v -q
nnoremap  gs :Gstatus
nnoremap  gA :Git add -A %:p:h
nnoremap  ga :Git add %:p
vnoremap  fr :frisk =GetVisualSelection()
nnoremap  fr :frisk -
vnoremap  av :AlignCtrl v 
nnoremap  av :AlignCtrl v 
vnoremap  ag :AlignCtrl g 
nnoremap  ag :AlignCtrl g 
vnoremap  ac :AlignCtrl 
nnoremap  ac :AlignCtrl 
vnoremap  ap :'{,'}Align! p
nnoremap  ap :'{,'}Align! p
vnoremap  am :'<,'>Align! p
nnoremap  am :'a,'sAlign! p
vnoremap  al :%Align! p
nnoremap  al :%Align! p
nnoremap  slc :scalcvsplit
nnoremap  clc :calc
vnoremap <silent>  aM :Americanize
nnoremap <silent>  aM :Americanize
vnoremap  ab :Abolish! 
nnoremap  ab :Abolish! 
vnoremap  lt :call ListTrans_toggle_format('visual')
nnoremap  lt :call ListTrans_toggle_format()
nnoremap <silent>  ep :sp ~/.vim/vimrc_plugs
nnoremap <silent>  eab :sp ~/.vim/after/plugin/abbreviations.vim
nnoremap <silent>  eaa :sp ~/.vim/plugin/vim-autocorrect.vim
nnoremap <silent>  et :sp ~/.vim/ftplugin/tex.vim
nnoremap <silent>  er :sp ~/.vim/ftplugin/r.vim
nnoremap <silent>  em :sp ~/.vim/vimrc_mutt
nnoremap <silent>  eb :sp ~/.vim/vimrc_mappings
nnoremap <silent>  ec :sp ~/.vim/vimrc_colors
nnoremap <silent>  ef :sp ~/.vim/vimrc_foldexpr
nnoremap <silent>  ev :sp ~/.vim/vimrc_vimgolf
nnoremap <silent>  ee :sp ~/.vim/vimrc_general
nnoremap <silent>  es :UltiSnipsEdit
nnoremap <silent>  erc :sp ~/.vimrc
vnoremap  P "+P
nnoremap  P "+P
vnoremap  d "+d
vnoremap  y "+y
vnoremap <silent>    :wall!:echo 'all open buffers saved!'
nnoremap <silent>    :wall!:echo 'all open buffers saved!'
vnoremap <silent> # :call VisualSearch('b')
vnoremap <silent> * :call VisualSearch('f')
nnoremap ++ vip++
vnoremap <expr> ++ VMATH_YankAndAnalyse()
xmap <silent> ,tt :call AlignMaps#Vis("tt")
nmap ,tt <Plug>AM_tt
xmap <silent> ,tsq :call AlignMaps#Vis("tsq")
nmap ,tsq <Plug>AM_tsq
xmap <silent> ,tsp :call AlignMaps#Vis("tsp")
nmap ,tsp <Plug>AM_tsp
xmap <silent> ,tml :call AlignMaps#Vis("tml")
nmap ,tml <Plug>AM_tml
xmap <silent> ,tab :call AlignMaps#Vis("tab")
nmap ,tab <Plug>AM_tab
xmap <silent> ,m= :call AlignMaps#Vis("m=")
nmap ,m= <Plug>AM_m=
xmap <silent> ,tW@ :call AlignMaps#Vis("tW@")
nmap ,tW@ <Plug>AM_tW@
xmap <silent> ,t@ :call AlignMaps#Vis("t@")
nmap ,t@ <Plug>AM_t@
xmap <silent> ,t~ :call AlignMaps#Vis("t~")
nmap ,t~ <Plug>AM_t~
xmap <silent> ,t? :call AlignMaps#Vis("t?")
nmap ,t? <Plug>AM_t?
xmap <silent> ,w= :call AlignMaps#Vis("w=")
nmap ,w= <Plug>AM_w=
xmap <silent> ,ts= :call AlignMaps#Vis("ts=")
nmap ,ts= <Plug>AM_ts=
xmap <silent> ,ts< :call AlignMaps#Vis("ts<")
nmap ,ts< <Plug>AM_ts<
xmap <silent> ,ts; :call AlignMaps#Vis("ts;")
nmap ,ts; <Plug>AM_ts;
xmap <silent> ,ts: :call AlignMaps#Vis("ts:")
nmap ,ts: <Plug>AM_ts:
xmap <silent> ,ts, :call AlignMaps#Vis("ts,")
nmap ,ts, <Plug>AM_ts,
xmap <silent> ,t= :call AlignMaps#Vis("t=")
nmap ,t= <Plug>AM_t=
xmap <silent> ,t< :call AlignMaps#Vis("t<")
nmap ,t< <Plug>AM_t<
xmap <silent> ,t; :call AlignMaps#Vis("t;")
nmap ,t; <Plug>AM_t;
xmap <silent> ,t: :call AlignMaps#Vis("t:")
nmap ,t: <Plug>AM_t:
xmap <silent> ,t, :call AlignMaps#Vis("t,")
nmap ,t, <Plug>AM_t,
xmap <silent> ,t# :call AlignMaps#Vis("t#")
nmap ,t# <Plug>AM_t#
xmap <silent> ,t| :call AlignMaps#Vis("t|")
nmap ,t| <Plug>AM_t|
xmap <silent> ,T~ :call AlignMaps#Vis("T~")
nmap ,T~ <Plug>AM_T~
xmap <silent> ,Tsp :call AlignMaps#Vis("Tsp")
nmap ,Tsp <Plug>AM_Tsp
xmap <silent> ,Tab :call AlignMaps#Vis("Tab")
nmap ,Tab <Plug>AM_Tab
xmap <silent> ,TW@ :call AlignMaps#Vis("TW@")
nmap ,TW@ <Plug>AM_TW@
xmap <silent> ,T@ :call AlignMaps#Vis("T@")
nmap ,T@ <Plug>AM_T@
xmap <silent> ,T? :call AlignMaps#Vis("T?")
nmap ,T? <Plug>AM_T?
xmap <silent> ,T= :call AlignMaps#Vis("T=")
nmap ,T= <Plug>AM_T=
xmap <silent> ,T< :call AlignMaps#Vis("T<")
nmap ,T< <Plug>AM_T<
xmap <silent> ,T; :call AlignMaps#Vis("T;")
nmap ,T; <Plug>AM_T;
xmap <silent> ,T: :call AlignMaps#Vis("T:")
nmap ,T: <Plug>AM_T:
xmap <silent> ,Ts, :call AlignMaps#Vis("Ts,")
nmap ,Ts, <Plug>AM_Ts,
xmap <silent> ,T, :call AlignMaps#Vis("T,")
nmap ,T, <Plug>AM_T,
xmap <silent> ,T# :call AlignMaps#Vis("T#")
nmap ,T# <Plug>AM_T#
xmap <silent> ,T| :call AlignMaps#Vis("T|")
nmap ,T| <Plug>AM_T|
xmap <silent> ,anum :call AlignMaps#Vis("anum")
nmap ,anum <Plug>AM_anum
xmap <silent> ,aenum :call AlignMaps#Vis("aenum")
nmap ,aenum <Plug>AM_aenum
xmap <silent> ,aunum :call AlignMaps#Vis("aunum")
nmap ,aunum <Plug>AM_aunum
xmap <silent> ,afnc :call AlignMaps#Vis("afnc")
nmap ,afnc <Plug>AM_afnc
xmap <silent> ,adef :call AlignMaps#Vis("adef")
nmap ,adef <Plug>AM_adef
xmap <silent> ,adec :call AlignMaps#Vis("adec")
nmap ,adec <Plug>AM_adec
xmap <silent> ,ascom :call AlignMaps#Vis("ascom")
nmap ,ascom <Plug>AM_ascom
xmap <silent> ,aocom :call AlignMaps#Vis("aocom")
nmap ,aocom <Plug>AM_aocom
xmap <silent> ,adcom :call AlignMaps#Vis("adcom")
nmap ,adcom <Plug>AM_adcom
xmap <silent> ,acom :call AlignMaps#Vis("acom")
nmap ,acom <Plug>AM_acom
xmap <silent> ,abox :call AlignMaps#Vis("abox")
nmap ,abox <Plug>AM_abox
xmap <silent> ,a( :call AlignMaps#Vis("a(")
nmap ,a( <Plug>AM_a(
xmap <silent> ,a= :call AlignMaps#Vis("a=")
nmap ,a= <Plug>AM_a=
xmap <silent> ,a< :call AlignMaps#Vis("a<")
nmap ,a< <Plug>AM_a<
xmap <silent> ,a, :call AlignMaps#Vis("a,")
nmap ,a, <Plug>AM_a,
xmap <silent> ,a? :call AlignMaps#Vis("a?")
nmap ,a? <Plug>AM_a?
noremap ,' :s:::cg<Left><Left><Left><Left>
noremap ,, :s:::g<Left><Left><Left>
noremap ,; :%s:::g<Left><Left><Left>
xnoremap ?? ?=vis#VisBlockSearch()
xnoremap <silent> <expr> A targets#e('A')
onoremap <silent> ALh :call targets#o('hLA', v:count1)
onoremap <silent> ANh :call targets#o('hNA', v:count1)
onoremap <silent> AL| :call targets#o('|LA', v:count1)
onoremap <silent> AN| :call targets#o('|NA', v:count1)
onoremap <silent> Al| :call targets#o('|lA', v:count1)
onoremap <silent> An| :call targets#o('|nA', v:count1)
onoremap <silent> A| :call targets#o('|cA', v:count1)
onoremap <silent> AL\ :call targets#o('\LA', v:count1)
onoremap <silent> AN\ :call targets#o('\NA', v:count1)
onoremap <silent> Al\ :call targets#o('\lA', v:count1)
onoremap <silent> An\ :call targets#o('\nA', v:count1)
onoremap <silent> A\ :call targets#o('\cA', v:count1)
onoremap <silent> AL/ :call targets#o('/LA', v:count1)
onoremap <silent> AN/ :call targets#o('/NA', v:count1)
onoremap <silent> Al/ :call targets#o('/lA', v:count1)
onoremap <silent> An/ :call targets#o('/nA', v:count1)
onoremap <silent> A/ :call targets#o('/cA', v:count1)
onoremap <silent> AL* :call targets#o('*LA', v:count1)
onoremap <silent> AN* :call targets#o('*NA', v:count1)
onoremap <silent> Al* :call targets#o('*lA', v:count1)
onoremap <silent> An* :call targets#o('*nA', v:count1)
onoremap <silent> A* :call targets#o('*cA', v:count1)
onoremap <silent> AL_ :call targets#o('_LA', v:count1)
onoremap <silent> AN_ :call targets#o('_NA', v:count1)
onoremap <silent> Al_ :call targets#o('_lA', v:count1)
onoremap <silent> An_ :call targets#o('_nA', v:count1)
onoremap <silent> A_ :call targets#o('_cA', v:count1)
onoremap <silent> AL~ :call targets#o('~LA', v:count1)
onoremap <silent> AN~ :call targets#o('~NA', v:count1)
onoremap <silent> Al~ :call targets#o('~lA', v:count1)
onoremap <silent> An~ :call targets#o('~nA', v:count1)
onoremap <silent> A~ :call targets#o('~cA', v:count1)
onoremap <silent> AL- :call targets#o('-LA', v:count1)
onoremap <silent> AN- :call targets#o('-NA', v:count1)
onoremap <silent> AL+ :call targets#o('+LA', v:count1)
onoremap <silent> AN+ :call targets#o('+NA', v:count1)
onoremap <silent> Al+ :call targets#o('+lA', v:count1)
onoremap <silent> An+ :call targets#o('+nA', v:count1)
onoremap <silent> A+ :call targets#o('+cA', v:count1)
onoremap <silent> AL: :call targets#o(':LA', v:count1)
onoremap <silent> AN: :call targets#o(':NA', v:count1)
onoremap <silent> Al: :call targets#o(':lA', v:count1)
onoremap <silent> An: :call targets#o(':nA', v:count1)
onoremap <silent> A: :call targets#o(':cA', v:count1)
onoremap <silent> AL; :call targets#o(';LA', v:count1)
onoremap <silent> AN; :call targets#o(';NA', v:count1)
onoremap <silent> Al; :call targets#o(';lA', v:count1)
onoremap <silent> An; :call targets#o(';nA', v:count1)
onoremap <silent> A; :call targets#o(';cA', v:count1)
onoremap <silent> AL. :call targets#o('.LA', v:count1)
onoremap <silent> AN. :call targets#o('.NA', v:count1)
onoremap <silent> Al. :call targets#o('.lA', v:count1)
onoremap <silent> An. :call targets#o('.nA', v:count1)
onoremap <silent> A. :call targets#o('.cA', v:count1)
onoremap <silent> ALc :call targets#o('cLA', v:count1)
onoremap <silent> ANc :call targets#o('cNA', v:count1)
onoremap <silent> Alc :call targets#o('clA', v:count1)
onoremap <silent> Anc :call targets#o('cnA', v:count1)
onoremap <silent> Ac :call targets#o('ccA', v:count1)
onoremap <silent> AL, :call targets#o(',LA', v:count1)
onoremap <silent> AN, :call targets#o(',NA', v:count1)
onoremap <silent> Al, :call targets#o(',lA', v:count1)
onoremap <silent> An, :call targets#o(',nA', v:count1)
onoremap <silent> A, :call targets#o(',cA', v:count1)
onoremap <silent> ALt :call targets#o('tLA', v:count1)
onoremap <silent> ANt :call targets#o('tNA', v:count1)
onoremap <silent> AL` :call targets#o('`LA', v:count1)
onoremap <silent> AN` :call targets#o('`NA', v:count1)
onoremap <silent> AL' :call targets#o('''LA', v:count1)
onoremap <silent> AN' :call targets#o('''NA', v:count1)
onoremap <silent> Al' :call targets#o('''lA', v:count1)
onoremap <silent> An' :call targets#o('''nA', v:count1)
onoremap <silent> A' :call targets#o('''cA', v:count1)
onoremap <silent> ALd :call targets#o('dLA', v:count1)
onoremap <silent> ANd :call targets#o('dNA', v:count1)
onoremap <silent> Ald :call targets#o('dlA', v:count1)
onoremap <silent> And :call targets#o('dnA', v:count1)
onoremap <silent> Ad :call targets#o('dcA', v:count1)
onoremap <silent> AL" :call targets#o('"LA', v:count1)
onoremap <silent> AN" :call targets#o('"NA', v:count1)
onoremap <silent> Al" :call targets#o('"lA', v:count1)
onoremap <silent> An" :call targets#o('"nA', v:count1)
onoremap <silent> A" :call targets#o('"cA', v:count1)
onoremap <silent> Alh :call targets#o('hlA', v:count1)
onoremap <silent> Anh :call targets#o('hnA', v:count1)
onoremap <silent> Ah :call targets#o('hcA', v:count1)
onoremap <silent> Al- :call targets#o('-lA', v:count1)
onoremap <silent> An- :call targets#o('-nA', v:count1)
onoremap <silent> A- :call targets#o('-cA', v:count1)
onoremap <silent> Alt :call targets#o('tlA', v:count1)
onoremap <silent> Ant :call targets#o('tnA', v:count1)
onoremap <silent> At :call targets#o('tcA', v:count1)
onoremap <silent> Al` :call targets#o('`lA', v:count1)
onoremap <silent> An` :call targets#o('`nA', v:count1)
onoremap <silent> A` :call targets#o('`cA', v:count1)
onoremap <silent> Ala :call targets#o('alA', v:count1)
onoremap <silent> Ana :call targets#o('anA', v:count1)
onoremap <silent> Aa :call targets#o('acA', v:count1)
onoremap <silent> Al> :call targets#o('>lA', v:count1)
onoremap <silent> An> :call targets#o('>nA', v:count1)
onoremap <silent> A> :call targets#o('>cA', v:count1)
onoremap <silent> Al< :call targets#o('<lA', v:count1)
onoremap <silent> An< :call targets#o('<nA', v:count1)
onoremap <silent> A< :call targets#o('<cA', v:count1)
onoremap <silent> Alr :call targets#o('rlA', v:count1)
onoremap <silent> Anr :call targets#o('rnA', v:count1)
onoremap <silent> Ar :call targets#o('rcA', v:count1)
onoremap <silent> Al] :call targets#o(']lA', v:count1)
onoremap <silent> An] :call targets#o(']nA', v:count1)
onoremap <silent> A] :call targets#o(']cA', v:count1)
onoremap <silent> Al[ :call targets#o('[lA', v:count1)
onoremap <silent> An[ :call targets#o('[nA', v:count1)
onoremap <silent> A[ :call targets#o('[cA', v:count1)
onoremap <silent> AlB :call targets#o('BlA', v:count1)
onoremap <silent> AnB :call targets#o('BnA', v:count1)
onoremap <silent> AB :call targets#o('BcA', v:count1)
onoremap <silent> Al} :call targets#o('}lA', v:count1)
onoremap <silent> An} :call targets#o('}nA', v:count1)
onoremap <silent> A} :call targets#o('}cA', v:count1)
onoremap <silent> Al{ :call targets#o('{lA', v:count1)
onoremap <silent> An{ :call targets#o('{nA', v:count1)
onoremap <silent> A{ :call targets#o('{cA', v:count1)
onoremap <silent> Alb :call targets#o('blA', v:count1)
onoremap <silent> Anb :call targets#o('bnA', v:count1)
onoremap <silent> Ab :call targets#o('bcA', v:count1)
onoremap <silent> Al) :call targets#o(')lA', v:count1)
onoremap <silent> An) :call targets#o(')nA', v:count1)
onoremap <silent> A) :call targets#o(')cA', v:count1)
onoremap <silent> Al( :call targets#o('(lA', v:count1)
onoremap <silent> An( :call targets#o('(nA', v:count1)
onoremap <silent> A( :call targets#o('(cA', v:count1)
vnoremap <expr> D DVB_Duplicate()
nnoremap D d$
xnoremap <silent> <expr> I targets#e('I')
onoremap <silent> ILh :call targets#o('hLI', v:count1)
onoremap <silent> INh :call targets#o('hNI', v:count1)
onoremap <silent> IL| :call targets#o('|LI', v:count1)
onoremap <silent> IN| :call targets#o('|NI', v:count1)
onoremap <silent> Il| :call targets#o('|lI', v:count1)
onoremap <silent> In| :call targets#o('|nI', v:count1)
onoremap <silent> I| :call targets#o('|cI', v:count1)
onoremap <silent> IL\ :call targets#o('\LI', v:count1)
onoremap <silent> IN\ :call targets#o('\NI', v:count1)
onoremap <silent> Il\ :call targets#o('\lI', v:count1)
onoremap <silent> In\ :call targets#o('\nI', v:count1)
onoremap <silent> I\ :call targets#o('\cI', v:count1)
onoremap <silent> IL/ :call targets#o('/LI', v:count1)
onoremap <silent> IN/ :call targets#o('/NI', v:count1)
onoremap <silent> Il/ :call targets#o('/lI', v:count1)
onoremap <silent> In/ :call targets#o('/nI', v:count1)
onoremap <silent> I/ :call targets#o('/cI', v:count1)
onoremap <silent> IL* :call targets#o('*LI', v:count1)
onoremap <silent> IN* :call targets#o('*NI', v:count1)
onoremap <silent> Il* :call targets#o('*lI', v:count1)
onoremap <silent> In* :call targets#o('*nI', v:count1)
onoremap <silent> I* :call targets#o('*cI', v:count1)
onoremap <silent> IL_ :call targets#o('_LI', v:count1)
onoremap <silent> IN_ :call targets#o('_NI', v:count1)
onoremap <silent> Il_ :call targets#o('_lI', v:count1)
onoremap <silent> In_ :call targets#o('_nI', v:count1)
onoremap <silent> I_ :call targets#o('_cI', v:count1)
onoremap <silent> IL~ :call targets#o('~LI', v:count1)
onoremap <silent> IN~ :call targets#o('~NI', v:count1)
onoremap <silent> Il~ :call targets#o('~lI', v:count1)
onoremap <silent> In~ :call targets#o('~nI', v:count1)
onoremap <silent> I~ :call targets#o('~cI', v:count1)
onoremap <silent> IL- :call targets#o('-LI', v:count1)
onoremap <silent> IN- :call targets#o('-NI', v:count1)
onoremap <silent> IL+ :call targets#o('+LI', v:count1)
onoremap <silent> IN+ :call targets#o('+NI', v:count1)
onoremap <silent> Il+ :call targets#o('+lI', v:count1)
onoremap <silent> In+ :call targets#o('+nI', v:count1)
onoremap <silent> I+ :call targets#o('+cI', v:count1)
onoremap <silent> IL: :call targets#o(':LI', v:count1)
onoremap <silent> IN: :call targets#o(':NI', v:count1)
onoremap <silent> Il: :call targets#o(':lI', v:count1)
onoremap <silent> In: :call targets#o(':nI', v:count1)
onoremap <silent> I: :call targets#o(':cI', v:count1)
onoremap <silent> IL; :call targets#o(';LI', v:count1)
onoremap <silent> IN; :call targets#o(';NI', v:count1)
onoremap <silent> Il; :call targets#o(';lI', v:count1)
onoremap <silent> In; :call targets#o(';nI', v:count1)
onoremap <silent> I; :call targets#o(';cI', v:count1)
onoremap <silent> IL. :call targets#o('.LI', v:count1)
onoremap <silent> IN. :call targets#o('.NI', v:count1)
onoremap <silent> Il. :call targets#o('.lI', v:count1)
onoremap <silent> In. :call targets#o('.nI', v:count1)
onoremap <silent> I. :call targets#o('.cI', v:count1)
onoremap <silent> ILc :call targets#o('cLI', v:count1)
onoremap <silent> INc :call targets#o('cNI', v:count1)
onoremap <silent> Ilc :call targets#o('clI', v:count1)
onoremap <silent> Inc :call targets#o('cnI', v:count1)
onoremap <silent> Ic :call targets#o('ccI', v:count1)
onoremap <silent> IL, :call targets#o(',LI', v:count1)
onoremap <silent> IN, :call targets#o(',NI', v:count1)
onoremap <silent> Il, :call targets#o(',lI', v:count1)
onoremap <silent> In, :call targets#o(',nI', v:count1)
onoremap <silent> I, :call targets#o(',cI', v:count1)
onoremap <silent> ILt :call targets#o('tLI', v:count1)
onoremap <silent> INt :call targets#o('tNI', v:count1)
onoremap <silent> IL` :call targets#o('`LI', v:count1)
onoremap <silent> IN` :call targets#o('`NI', v:count1)
onoremap <silent> IL' :call targets#o('''LI', v:count1)
onoremap <silent> IN' :call targets#o('''NI', v:count1)
onoremap <silent> Il' :call targets#o('''lI', v:count1)
onoremap <silent> In' :call targets#o('''nI', v:count1)
onoremap <silent> I' :call targets#o('''cI', v:count1)
onoremap <silent> ILd :call targets#o('dLI', v:count1)
onoremap <silent> INd :call targets#o('dNI', v:count1)
onoremap <silent> Ild :call targets#o('dlI', v:count1)
onoremap <silent> Ind :call targets#o('dnI', v:count1)
onoremap <silent> Id :call targets#o('dcI', v:count1)
onoremap <silent> IL" :call targets#o('"LI', v:count1)
onoremap <silent> IN" :call targets#o('"NI', v:count1)
onoremap <silent> Il" :call targets#o('"lI', v:count1)
onoremap <silent> In" :call targets#o('"nI', v:count1)
onoremap <silent> I" :call targets#o('"cI', v:count1)
onoremap <silent> Ilh :call targets#o('hlI', v:count1)
onoremap <silent> Inh :call targets#o('hnI', v:count1)
onoremap <silent> Ih :call targets#o('hcI', v:count1)
onoremap <silent> Il- :call targets#o('-lI', v:count1)
onoremap <silent> In- :call targets#o('-nI', v:count1)
onoremap <silent> I- :call targets#o('-cI', v:count1)
onoremap <silent> Ilt :call targets#o('tlI', v:count1)
onoremap <silent> Int :call targets#o('tnI', v:count1)
onoremap <silent> It :call targets#o('tcI', v:count1)
onoremap <silent> Il` :call targets#o('`lI', v:count1)
onoremap <silent> In` :call targets#o('`nI', v:count1)
onoremap <silent> I` :call targets#o('`cI', v:count1)
onoremap <silent> Ila :call targets#o('alI', v:count1)
onoremap <silent> Ina :call targets#o('anI', v:count1)
onoremap <silent> Ia :call targets#o('acI', v:count1)
onoremap <silent> Il> :call targets#o('>lI', v:count1)
onoremap <silent> In> :call targets#o('>nI', v:count1)
onoremap <silent> I> :call targets#o('>cI', v:count1)
onoremap <silent> Il< :call targets#o('<lI', v:count1)
onoremap <silent> In< :call targets#o('<nI', v:count1)
onoremap <silent> I< :call targets#o('<cI', v:count1)
onoremap <silent> Ilr :call targets#o('rlI', v:count1)
onoremap <silent> Inr :call targets#o('rnI', v:count1)
onoremap <silent> Ir :call targets#o('rcI', v:count1)
onoremap <silent> Il] :call targets#o(']lI', v:count1)
onoremap <silent> In] :call targets#o(']nI', v:count1)
onoremap <silent> I] :call targets#o(']cI', v:count1)
onoremap <silent> Il[ :call targets#o('[lI', v:count1)
onoremap <silent> In[ :call targets#o('[nI', v:count1)
onoremap <silent> I[ :call targets#o('[cI', v:count1)
onoremap <silent> IlB :call targets#o('BlI', v:count1)
onoremap <silent> InB :call targets#o('BnI', v:count1)
onoremap <silent> IB :call targets#o('BcI', v:count1)
onoremap <silent> Il} :call targets#o('}lI', v:count1)
onoremap <silent> In} :call targets#o('}nI', v:count1)
onoremap <silent> I} :call targets#o('}cI', v:count1)
onoremap <silent> Il{ :call targets#o('{lI', v:count1)
onoremap <silent> In{ :call targets#o('{nI', v:count1)
onoremap <silent> I{ :call targets#o('{cI', v:count1)
onoremap <silent> Ilb :call targets#o('blI', v:count1)
onoremap <silent> Inb :call targets#o('bnI', v:count1)
onoremap <silent> Ib :call targets#o('bcI', v:count1)
onoremap <silent> Il) :call targets#o(')lI', v:count1)
onoremap <silent> In) :call targets#o(')nI', v:count1)
onoremap <silent> I) :call targets#o(')cI', v:count1)
onoremap <silent> Il( :call targets#o('(lI', v:count1)
onoremap <silent> In( :call targets#o('(nI', v:count1)
onoremap <silent> I( :call targets#o('(cI', v:count1)
xmap S <Plug>VSurround
nnoremap <silent> U :normal! mzlbgUl`z:nohl
nnoremap V 
xmap X <Plug>(Exchange)
nnoremap Y y$
nnoremap <silent> ZD :call origami#DeleteFoldmarker()
nnoremap <silent> Zc :call origami#InsertFoldmarker("close", "nocomment", v:count)
nnoremap <silent> ZC :call origami#InsertFoldmarker("close", "comment"  , v:count)
nnoremap <silent> Zf :call origami#InsertFoldmarker("open" , "nocomment", v:count)
nnoremap <silent> ZF :call origami#InsertFoldmarker("open" , "comment"  , v:count)
nnoremap <silent> ZA :call origami#AlignFoldmarkers()
nnoremap <silent> Za :call origami#AlignFoldmarkers(v:count)
nmap [xx <Plug>unimpaired_line_xml_encode
xmap [x <Plug>unimpaired_xml_encode
nmap [x <Plug>unimpaired_xml_encode
nmap [uu <Plug>unimpaired_line_url_encode
xmap [u <Plug>unimpaired_url_encode
nmap [u <Plug>unimpaired_url_encode
nmap [yy <Plug>unimpaired_line_string_encode
xmap [y <Plug>unimpaired_string_encode
nmap [y <Plug>unimpaired_string_encode
nmap [p <Plug>unimpairedPutAbove
nnoremap [ov :set virtualedit+=all
nnoremap [ox :set cursorline cursorcolumn
nnoremap [od :diffthis
nnoremap [ob :set background=light
xmap [e <Plug>unimpairedMoveSelectionUp
nmap [e <Plug>unimpairedMoveUp
nmap [  <Plug>unimpairedBlankUp
omap [n <Plug>unimpairedContextPrevious
nmap [n <Plug>unimpairedContextPrevious
nmap [o <Plug>unimpairedOPrevious
nmap [f <Plug>unimpairedDirectoryPrevious
nmap <silent> [T <Plug>unimpairedTFirst
nmap <silent> [t <Plug>unimpairedTPrevious
nmap <silent> [ <Plug>unimpairedQPFile
nmap <silent> [Q <Plug>unimpairedQFirst
nmap <silent> [q <Plug>unimpairedQPrevious
nmap <silent> [ <Plug>unimpairedLPFile
nmap <silent> [L <Plug>unimpairedLFirst
nmap <silent> [l <Plug>unimpairedLPrevious
nmap <silent> [B <Plug>unimpairedBFirst
nmap <silent> [b <Plug>unimpairedBPrevious
nmap <silent> [A <Plug>unimpairedAFirst
nmap <silent> [a <Plug>unimpairedAPrevious
xmap [% [%m'gv``
nnoremap \ `m :ShowMarksOnce:foldo
nmap ]xx <Plug>unimpaired_line_xml_decode
xmap ]x <Plug>unimpaired_xml_decode
nmap ]x <Plug>unimpaired_xml_decode
nmap ]uu <Plug>unimpaired_line_url_decode
xmap ]u <Plug>unimpaired_url_decode
nmap ]u <Plug>unimpaired_url_decode
nmap ]yy <Plug>unimpaired_line_string_decode
xmap ]y <Plug>unimpaired_string_decode
nmap ]y <Plug>unimpaired_string_decode
nmap ]p <Plug>unimpairedPutBelow
nnoremap ]ov :set virtualedit-=all
nnoremap ]ox :set nocursorline nocursorcolumn
nnoremap ]od :diffoff
nnoremap ]ob :set background=dark
xmap ]e <Plug>unimpairedMoveSelectionDown
nmap ]e <Plug>unimpairedMoveDown
nmap ]  <Plug>unimpairedBlankDown
omap ]n <Plug>unimpairedContextNext
nmap ]n <Plug>unimpairedContextNext
nmap ]o <Plug>unimpairedONext
nmap ]f <Plug>unimpairedDirectoryNext
nmap <silent> ]T <Plug>unimpairedTLast
nmap <silent> ]t <Plug>unimpairedTNext
nmap <silent> ] <Plug>unimpairedQNFile
nmap <silent> ]Q <Plug>unimpairedQLast
nmap <silent> ]q <Plug>unimpairedQNext
nmap <silent> ] <Plug>unimpairedLNFile
nmap <silent> ]L <Plug>unimpairedLLast
nmap <silent> ]l <Plug>unimpairedLNext
nmap <silent> ]B <Plug>unimpairedBLast
nmap <silent> ]b <Plug>unimpairedBNext
nmap <silent> ]A <Plug>unimpairedALast
nmap <silent> ]a <Plug>unimpairedANext
xmap ]% ]%m'gv``
xnoremap <silent> <expr> a targets#e('a')
onoremap <silent> aLh :call targets#o('hLa', v:count1)
onoremap <silent> aNh :call targets#o('hNa', v:count1)
onoremap <silent> aL| :call targets#o('|La', v:count1)
onoremap <silent> aN| :call targets#o('|Na', v:count1)
onoremap <silent> al| :call targets#o('|la', v:count1)
onoremap <silent> an| :call targets#o('|na', v:count1)
onoremap <silent> a| :call targets#o('|ca', v:count1)
onoremap <silent> aL\ :call targets#o('\La', v:count1)
onoremap <silent> aN\ :call targets#o('\Na', v:count1)
onoremap <silent> al\ :call targets#o('\la', v:count1)
onoremap <silent> an\ :call targets#o('\na', v:count1)
onoremap <silent> a\ :call targets#o('\ca', v:count1)
onoremap <silent> aL/ :call targets#o('/La', v:count1)
onoremap <silent> aN/ :call targets#o('/Na', v:count1)
onoremap <silent> al/ :call targets#o('/la', v:count1)
onoremap <silent> an/ :call targets#o('/na', v:count1)
onoremap <silent> a/ :call targets#o('/ca', v:count1)
onoremap <silent> aL* :call targets#o('*La', v:count1)
onoremap <silent> aN* :call targets#o('*Na', v:count1)
onoremap <silent> al* :call targets#o('*la', v:count1)
onoremap <silent> an* :call targets#o('*na', v:count1)
onoremap <silent> a* :call targets#o('*ca', v:count1)
onoremap <silent> aL_ :call targets#o('_La', v:count1)
onoremap <silent> aN_ :call targets#o('_Na', v:count1)
onoremap <silent> al_ :call targets#o('_la', v:count1)
onoremap <silent> an_ :call targets#o('_na', v:count1)
onoremap <silent> a_ :call targets#o('_ca', v:count1)
onoremap <silent> aL~ :call targets#o('~La', v:count1)
onoremap <silent> aN~ :call targets#o('~Na', v:count1)
onoremap <silent> al~ :call targets#o('~la', v:count1)
onoremap <silent> an~ :call targets#o('~na', v:count1)
onoremap <silent> a~ :call targets#o('~ca', v:count1)
onoremap <silent> aL- :call targets#o('-La', v:count1)
onoremap <silent> aN- :call targets#o('-Na', v:count1)
onoremap <silent> aL+ :call targets#o('+La', v:count1)
onoremap <silent> aN+ :call targets#o('+Na', v:count1)
onoremap <silent> al+ :call targets#o('+la', v:count1)
onoremap <silent> an+ :call targets#o('+na', v:count1)
onoremap <silent> a+ :call targets#o('+ca', v:count1)
onoremap <silent> aL: :call targets#o(':La', v:count1)
onoremap <silent> aN: :call targets#o(':Na', v:count1)
onoremap <silent> al: :call targets#o(':la', v:count1)
onoremap <silent> an: :call targets#o(':na', v:count1)
onoremap <silent> a: :call targets#o(':ca', v:count1)
onoremap <silent> aL; :call targets#o(';La', v:count1)
onoremap <silent> aN; :call targets#o(';Na', v:count1)
onoremap <silent> al; :call targets#o(';la', v:count1)
onoremap <silent> an; :call targets#o(';na', v:count1)
onoremap <silent> a; :call targets#o(';ca', v:count1)
onoremap <silent> aL. :call targets#o('.La', v:count1)
onoremap <silent> aN. :call targets#o('.Na', v:count1)
onoremap <silent> al. :call targets#o('.la', v:count1)
onoremap <silent> an. :call targets#o('.na', v:count1)
onoremap <silent> a. :call targets#o('.ca', v:count1)
onoremap <silent> aLc :call targets#o('cLa', v:count1)
onoremap <silent> aNc :call targets#o('cNa', v:count1)
onoremap <silent> alc :call targets#o('cla', v:count1)
onoremap <silent> anc :call targets#o('cna', v:count1)
onoremap <silent> ac :call targets#o('cca', v:count1)
onoremap <silent> aL, :call targets#o(',La', v:count1)
onoremap <silent> aN, :call targets#o(',Na', v:count1)
onoremap <silent> al, :call targets#o(',la', v:count1)
onoremap <silent> an, :call targets#o(',na', v:count1)
onoremap <silent> a, :call targets#o(',ca', v:count1)
onoremap <silent> aLt :call targets#o('tLa', v:count1)
onoremap <silent> aNt :call targets#o('tNa', v:count1)
onoremap <silent> aL` :call targets#o('`La', v:count1)
onoremap <silent> aN` :call targets#o('`Na', v:count1)
onoremap <silent> aL' :call targets#o('''La', v:count1)
onoremap <silent> aN' :call targets#o('''Na', v:count1)
onoremap <silent> al' :call targets#o('''la', v:count1)
onoremap <silent> an' :call targets#o('''na', v:count1)
onoremap <silent> a' :call targets#o('''ca', v:count1)
onoremap <silent> aLd :call targets#o('dLa', v:count1)
onoremap <silent> aNd :call targets#o('dNa', v:count1)
onoremap <silent> ald :call targets#o('dla', v:count1)
onoremap <silent> and :call targets#o('dna', v:count1)
onoremap <silent> ad :call targets#o('dca', v:count1)
onoremap <silent> aL" :call targets#o('"La', v:count1)
onoremap <silent> aN" :call targets#o('"Na', v:count1)
onoremap <silent> al" :call targets#o('"la', v:count1)
onoremap <silent> an" :call targets#o('"na', v:count1)
onoremap <silent> a" :call targets#o('"ca', v:count1)
onoremap <silent> alh :call targets#o('hla', v:count1)
onoremap <silent> anh :call targets#o('hna', v:count1)
onoremap <silent> ah :call targets#o('hca', v:count1)
onoremap <silent> al- :call targets#o('-la', v:count1)
onoremap <silent> an- :call targets#o('-na', v:count1)
onoremap <silent> a- :call targets#o('-ca', v:count1)
onoremap <silent> alt :call targets#o('tla', v:count1)
onoremap <silent> ant :call targets#o('tna', v:count1)
onoremap <silent> at :call targets#o('tca', v:count1)
onoremap <silent> al` :call targets#o('`la', v:count1)
onoremap <silent> an` :call targets#o('`na', v:count1)
onoremap <silent> a` :call targets#o('`ca', v:count1)
onoremap <silent> ala :call targets#o('ala', v:count1)
onoremap <silent> ana :call targets#o('ana', v:count1)
onoremap <silent> aa :call targets#o('aca', v:count1)
onoremap <silent> al> :call targets#o('>la', v:count1)
onoremap <silent> an> :call targets#o('>na', v:count1)
onoremap <silent> a> :call targets#o('>ca', v:count1)
onoremap <silent> al< :call targets#o('<la', v:count1)
onoremap <silent> an< :call targets#o('<na', v:count1)
onoremap <silent> a< :call targets#o('<ca', v:count1)
onoremap <silent> alr :call targets#o('rla', v:count1)
onoremap <silent> anr :call targets#o('rna', v:count1)
onoremap <silent> ar :call targets#o('rca', v:count1)
onoremap <silent> al] :call targets#o(']la', v:count1)
onoremap <silent> an] :call targets#o(']na', v:count1)
onoremap <silent> a] :call targets#o(']ca', v:count1)
onoremap <silent> al[ :call targets#o('[la', v:count1)
onoremap <silent> an[ :call targets#o('[na', v:count1)
onoremap <silent> a[ :call targets#o('[ca', v:count1)
onoremap <silent> alB :call targets#o('Bla', v:count1)
onoremap <silent> anB :call targets#o('Bna', v:count1)
onoremap <silent> aB :call targets#o('Bca', v:count1)
onoremap <silent> al} :call targets#o('}la', v:count1)
onoremap <silent> an} :call targets#o('}na', v:count1)
onoremap <silent> a} :call targets#o('}ca', v:count1)
onoremap <silent> al{ :call targets#o('{la', v:count1)
onoremap <silent> an{ :call targets#o('{na', v:count1)
onoremap <silent> a{ :call targets#o('{ca', v:count1)
onoremap <silent> alb :call targets#o('bla', v:count1)
onoremap <silent> anb :call targets#o('bna', v:count1)
onoremap <silent> ab :call targets#o('bca', v:count1)
onoremap <silent> al) :call targets#o(')la', v:count1)
onoremap <silent> an) :call targets#o(')na', v:count1)
onoremap <silent> a) :call targets#o(')ca', v:count1)
onoremap <silent> al( :call targets#o('(la', v:count1)
onoremap <silent> an( :call targets#o('(na', v:count1)
onoremap <silent> a( :call targets#o('(ca', v:count1)
xmap a% [%v]%
nmap <silent> b <Plug>CamelCaseMotion_b
xmap <silent> b <Plug>CamelCaseMotion_b
omap <silent> b <Plug>CamelCaseMotion_b
nnoremap cov :set =(&virtualedit =~# "all") ? 'virtualedit-=all' : 'virtualedit+=all'
nnoremap cox :set =&cursorline && &cursorcolumn ? 'nocursorline nocursorcolumn' : 'cursorline cursorcolumn'
nnoremap cod :=&diff ? 'diffoff' : 'diffthis'
nnoremap cob :set background==&background == 'dark' ? 'light' : 'dark'
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nmap cr <Plug>Coerce
nmap cgc <Plug>ChangeCommentary
nmap cxx <Plug>(ExchangeLine)
nmap cxc <Plug>(ExchangeClear)
nmap cx <Plug>(Exchange)
nmap ds <Plug>Dsurround
nmap <silent> e <Plug>CamelCaseMotion_e
xmap <silent> e <Plug>CamelCaseMotion_e
omap <silent> e <Plug>CamelCaseMotion_e
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
nmap gcu <Plug>Commentary<Plug>Commentary
nmap gcc <Plug>CommentaryLine
omap gc <Plug>Commentary
nmap gc <Plug>Commentary
xmap gc <Plug>Commentary
xmap <silent> gcs :call CountSpaces(visualmode(), 1)
nmap <silent> gcs :set opfunc=CountSpacesg@
nnoremap gZ :exe "!firefox " . shellescape(expand("<cword>"))
nnoremap gm :call cursor(0, virtcol('$')/2)
nnoremap <silent> gzz :normal gz$
nnoremap gF :lcd %:p:h:e! ./<cfile>
noremap gV `[v`]
xnoremap <silent> <expr> i targets#e('i')
onoremap <silent> iLh :call targets#o('hLi', v:count1)
onoremap <silent> iNh :call targets#o('hNi', v:count1)
onoremap <silent> iL| :call targets#o('|Li', v:count1)
onoremap <silent> iN| :call targets#o('|Ni', v:count1)
onoremap <silent> il| :call targets#o('|li', v:count1)
onoremap <silent> in| :call targets#o('|ni', v:count1)
onoremap <silent> i| :call targets#o('|ci', v:count1)
onoremap <silent> iL\ :call targets#o('\Li', v:count1)
onoremap <silent> iN\ :call targets#o('\Ni', v:count1)
onoremap <silent> il\ :call targets#o('\li', v:count1)
onoremap <silent> in\ :call targets#o('\ni', v:count1)
onoremap <silent> i\ :call targets#o('\ci', v:count1)
onoremap <silent> iL/ :call targets#o('/Li', v:count1)
onoremap <silent> iN/ :call targets#o('/Ni', v:count1)
onoremap <silent> il/ :call targets#o('/li', v:count1)
onoremap <silent> in/ :call targets#o('/ni', v:count1)
onoremap <silent> i/ :call targets#o('/ci', v:count1)
onoremap <silent> iL* :call targets#o('*Li', v:count1)
onoremap <silent> iN* :call targets#o('*Ni', v:count1)
onoremap <silent> il* :call targets#o('*li', v:count1)
onoremap <silent> in* :call targets#o('*ni', v:count1)
onoremap <silent> i* :call targets#o('*ci', v:count1)
onoremap <silent> iL_ :call targets#o('_Li', v:count1)
onoremap <silent> iN_ :call targets#o('_Ni', v:count1)
onoremap <silent> il_ :call targets#o('_li', v:count1)
onoremap <silent> in_ :call targets#o('_ni', v:count1)
onoremap <silent> i_ :call targets#o('_ci', v:count1)
onoremap <silent> iL~ :call targets#o('~Li', v:count1)
onoremap <silent> iN~ :call targets#o('~Ni', v:count1)
onoremap <silent> il~ :call targets#o('~li', v:count1)
onoremap <silent> in~ :call targets#o('~ni', v:count1)
onoremap <silent> i~ :call targets#o('~ci', v:count1)
onoremap <silent> iL- :call targets#o('-Li', v:count1)
onoremap <silent> iN- :call targets#o('-Ni', v:count1)
onoremap <silent> iL+ :call targets#o('+Li', v:count1)
onoremap <silent> iN+ :call targets#o('+Ni', v:count1)
onoremap <silent> il+ :call targets#o('+li', v:count1)
onoremap <silent> in+ :call targets#o('+ni', v:count1)
onoremap <silent> i+ :call targets#o('+ci', v:count1)
onoremap <silent> iL: :call targets#o(':Li', v:count1)
onoremap <silent> iN: :call targets#o(':Ni', v:count1)
onoremap <silent> il: :call targets#o(':li', v:count1)
onoremap <silent> in: :call targets#o(':ni', v:count1)
onoremap <silent> i: :call targets#o(':ci', v:count1)
onoremap <silent> iL; :call targets#o(';Li', v:count1)
onoremap <silent> iN; :call targets#o(';Ni', v:count1)
onoremap <silent> il; :call targets#o(';li', v:count1)
onoremap <silent> in; :call targets#o(';ni', v:count1)
onoremap <silent> i; :call targets#o(';ci', v:count1)
onoremap <silent> iL. :call targets#o('.Li', v:count1)
onoremap <silent> iN. :call targets#o('.Ni', v:count1)
onoremap <silent> il. :call targets#o('.li', v:count1)
onoremap <silent> in. :call targets#o('.ni', v:count1)
onoremap <silent> i. :call targets#o('.ci', v:count1)
onoremap <silent> iLc :call targets#o('cLi', v:count1)
onoremap <silent> iNc :call targets#o('cNi', v:count1)
onoremap <silent> ilc :call targets#o('cli', v:count1)
onoremap <silent> inc :call targets#o('cni', v:count1)
onoremap <silent> ic :call targets#o('cci', v:count1)
onoremap <silent> iL, :call targets#o(',Li', v:count1)
onoremap <silent> iN, :call targets#o(',Ni', v:count1)
onoremap <silent> il, :call targets#o(',li', v:count1)
onoremap <silent> in, :call targets#o(',ni', v:count1)
onoremap <silent> i, :call targets#o(',ci', v:count1)
onoremap <silent> iLt :call targets#o('tLi', v:count1)
onoremap <silent> iNt :call targets#o('tNi', v:count1)
onoremap <silent> iL` :call targets#o('`Li', v:count1)
onoremap <silent> iN` :call targets#o('`Ni', v:count1)
onoremap <silent> iL' :call targets#o('''Li', v:count1)
onoremap <silent> iN' :call targets#o('''Ni', v:count1)
onoremap <silent> il' :call targets#o('''li', v:count1)
onoremap <silent> in' :call targets#o('''ni', v:count1)
onoremap <silent> i' :call targets#o('''ci', v:count1)
onoremap <silent> iLd :call targets#o('dLi', v:count1)
onoremap <silent> iNd :call targets#o('dNi', v:count1)
onoremap <silent> ild :call targets#o('dli', v:count1)
onoremap <silent> ind :call targets#o('dni', v:count1)
onoremap <silent> id :call targets#o('dci', v:count1)
onoremap <silent> iL" :call targets#o('"Li', v:count1)
onoremap <silent> iN" :call targets#o('"Ni', v:count1)
onoremap <silent> il" :call targets#o('"li', v:count1)
onoremap <silent> in" :call targets#o('"ni', v:count1)
onoremap <silent> i" :call targets#o('"ci', v:count1)
onoremap <silent> ilh :call targets#o('hli', v:count1)
onoremap <silent> inh :call targets#o('hni', v:count1)
onoremap <silent> ih :call targets#o('hci', v:count1)
onoremap <silent> il- :call targets#o('-li', v:count1)
onoremap <silent> in- :call targets#o('-ni', v:count1)
onoremap <silent> i- :call targets#o('-ci', v:count1)
onoremap <silent> ilt :call targets#o('tli', v:count1)
onoremap <silent> int :call targets#o('tni', v:count1)
onoremap <silent> it :call targets#o('tci', v:count1)
onoremap <silent> il` :call targets#o('`li', v:count1)
onoremap <silent> in` :call targets#o('`ni', v:count1)
onoremap <silent> i` :call targets#o('`ci', v:count1)
onoremap <silent> ila :call targets#o('ali', v:count1)
onoremap <silent> ina :call targets#o('ani', v:count1)
onoremap <silent> ia :call targets#o('aci', v:count1)
onoremap <silent> il> :call targets#o('>li', v:count1)
onoremap <silent> in> :call targets#o('>ni', v:count1)
onoremap <silent> i> :call targets#o('>ci', v:count1)
onoremap <silent> il< :call targets#o('<li', v:count1)
onoremap <silent> in< :call targets#o('<ni', v:count1)
onoremap <silent> i< :call targets#o('<ci', v:count1)
onoremap <silent> ilr :call targets#o('rli', v:count1)
onoremap <silent> inr :call targets#o('rni', v:count1)
onoremap <silent> ir :call targets#o('rci', v:count1)
onoremap <silent> il] :call targets#o(']li', v:count1)
onoremap <silent> in] :call targets#o(']ni', v:count1)
onoremap <silent> i] :call targets#o(']ci', v:count1)
onoremap <silent> il[ :call targets#o('[li', v:count1)
onoremap <silent> in[ :call targets#o('[ni', v:count1)
onoremap <silent> i[ :call targets#o('[ci', v:count1)
onoremap <silent> ilB :call targets#o('Bli', v:count1)
onoremap <silent> inB :call targets#o('Bni', v:count1)
onoremap <silent> iB :call targets#o('Bci', v:count1)
onoremap <silent> il} :call targets#o('}li', v:count1)
onoremap <silent> in} :call targets#o('}ni', v:count1)
onoremap <silent> i} :call targets#o('}ci', v:count1)
onoremap <silent> il{ :call targets#o('{li', v:count1)
onoremap <silent> in{ :call targets#o('{ni', v:count1)
onoremap <silent> i{ :call targets#o('{ci', v:count1)
onoremap <silent> ilb :call targets#o('bli', v:count1)
onoremap <silent> inb :call targets#o('bni', v:count1)
onoremap <silent> ib :call targets#o('bci', v:count1)
onoremap <silent> il) :call targets#o(')li', v:count1)
onoremap <silent> in) :call targets#o(')ni', v:count1)
onoremap <silent> i) :call targets#o(')ci', v:count1)
onoremap <silent> il( :call targets#o('(li', v:count1)
onoremap <silent> in( :call targets#o('(ni', v:count1)
onoremap <silent> i( :call targets#o('(ci', v:count1)
xmap <silent> i,e <Plug>CamelCaseMotion_ie
xmap <silent> i,b <Plug>CamelCaseMotion_ib
xmap <silent> i,w <Plug>CamelCaseMotion_iw
omap <silent> i,e <Plug>CamelCaseMotion_ie
omap <silent> i,b <Plug>CamelCaseMotion_ib
omap <silent> i,w <Plug>CamelCaseMotion_iw
vnoremap v <Plug>(expand_region_expand)
nmap <silent> w <Plug>CamelCaseMotion_w
xmap <silent> w <Plug>CamelCaseMotion_w
omap <silent> w <Plug>CamelCaseMotion_w
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cfile>"),0)
nmap <SNR>74_WE <Plug>AlignMapsWrapperEnd
map <SNR>74_WS <Plug>AlignMapsWrapperStart
nmap <silent> <Plug>unimpairedOPrevious <Plug>unimpairedDirectoryPrevious:echohl WarningMSG|echo "[o is deprecated. Use [f"|echohl NONE
nmap <silent> <Plug>unimpairedONext <Plug>unimpairedDirectoryNext:echohl WarningMSG|echo "]o is deprecated. Use ]f"|echohl NONE
nnoremap <silent> <Plug>unimpairedTLast :exe "".(v:count ? v:count : "")."tlast"
nnoremap <silent> <Plug>unimpairedTFirst :exe "".(v:count ? v:count : "")."tfirst"
nnoremap <silent> <Plug>unimpairedTNext :exe "".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>unimpairedTPrevious :exe "".(v:count ? v:count : "")."tprevious"
nnoremap <silent> <Plug>unimpairedQNFile :exe "".(v:count ? v:count : "")."cnfile"zv
nnoremap <silent> <Plug>unimpairedQPFile :exe "".(v:count ? v:count : "")."cpfile"zv
nnoremap <silent> <Plug>unimpairedQLast :exe "".(v:count ? v:count : "")."clast"zv
nnoremap <silent> <Plug>unimpairedQFirst :exe "".(v:count ? v:count : "")."cfirst"zv
nnoremap <silent> <Plug>unimpairedQNext :exe "".(v:count ? v:count : "")."cnext"zv
nnoremap <silent> <Plug>unimpairedQPrevious :exe "".(v:count ? v:count : "")."cprevious"zv
nnoremap <silent> <Plug>unimpairedLNFile :exe "".(v:count ? v:count : "")."lnfile"zv
nnoremap <silent> <Plug>unimpairedLPFile :exe "".(v:count ? v:count : "")."lpfile"zv
nnoremap <silent> <Plug>unimpairedLLast :exe "".(v:count ? v:count : "")."llast"zv
nnoremap <silent> <Plug>unimpairedLFirst :exe "".(v:count ? v:count : "")."lfirst"zv
nnoremap <silent> <Plug>unimpairedLNext :exe "".(v:count ? v:count : "")."lnext"zv
nnoremap <silent> <Plug>unimpairedLPrevious :exe "".(v:count ? v:count : "")."lprevious"zv
nnoremap <silent> <Plug>unimpairedBLast :exe "".(v:count ? v:count : "")."blast"
nnoremap <silent> <Plug>unimpairedBFirst :exe "".(v:count ? v:count : "")."bfirst"
nnoremap <silent> <Plug>unimpairedBNext :exe "".(v:count ? v:count : "")."bnext"
nnoremap <silent> <Plug>unimpairedBPrevious :exe "".(v:count ? v:count : "")."bprevious"
nnoremap <silent> <Plug>unimpairedALast :exe "".(v:count ? v:count : "")."last"
nnoremap <silent> <Plug>unimpairedAFirst :exe "".(v:count ? v:count : "")."first"
nnoremap <silent> <Plug>unimpairedANext :exe "".(v:count ? v:count : "")."next"
nnoremap <silent> <Plug>unimpairedAPrevious :exe "".(v:count ? v:count : "")."previous"
nnoremap <silent> <Plug>SurroundRepeat .
nmap <silent> <Plug>CommentaryUndo <Plug>Commentary<Plug>Commentary
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
noremap <expr> <Plug>(asterisk-gz#) asterisk#do(mode(1), {'direction' : 0, 'do_jump' : 0, 'is_whole' : 0})
noremap <expr> <Plug>(asterisk-z#) asterisk#do(mode(1), {'direction' : 0, 'do_jump' : 0, 'is_whole' : 1})
noremap <expr> <Plug>(asterisk-g#) asterisk#do(mode(1), {'direction' : 0, 'do_jump' : 1, 'is_whole' : 0})
noremap <expr> <Plug>(asterisk-#) asterisk#do(mode(1), {'direction' : 0, 'do_jump' : 1, 'is_whole' : 1})
noremap <expr> <Plug>(asterisk-gz*) asterisk#do(mode(1), {'direction' : 1, 'do_jump' : 0, 'is_whole' : 0})
noremap <expr> <Plug>(asterisk-z*) asterisk#do(mode(1), {'direction' : 1, 'do_jump' : 0, 'is_whole' : 1})
noremap <expr> <Plug>(asterisk-g*) asterisk#do(mode(1), {'direction' : 1, 'do_jump' : 1, 'is_whole' : 0})
noremap <expr> <Plug>(asterisk-*) asterisk#do(mode(1), {'direction' : 1, 'do_jump' : 1, 'is_whole' : 1})
vnoremap <silent> <Plug>CamelCaseMotion_ie :call camelcasemotion#InnerMotion('e',v:count1)
vnoremap <silent> <Plug>CamelCaseMotion_ib :call camelcasemotion#InnerMotion('b',v:count1)
vnoremap <silent> <Plug>CamelCaseMotion_iw :call camelcasemotion#InnerMotion('w',v:count1)
onoremap <silent> <Plug>CamelCaseMotion_ie :call camelcasemotion#InnerMotion('e',v:count1)
onoremap <silent> <Plug>CamelCaseMotion_ib :call camelcasemotion#InnerMotion('b',v:count1)
onoremap <silent> <Plug>CamelCaseMotion_iw :call camelcasemotion#InnerMotion('w',v:count1)
vnoremap <silent> <Plug>CamelCaseMotion_e :call camelcasemotion#Motion('e',v:count1,'v')
vnoremap <silent> <Plug>CamelCaseMotion_b :call camelcasemotion#Motion('b',v:count1,'v')
vnoremap <silent> <Plug>CamelCaseMotion_w :call camelcasemotion#Motion('w',v:count1,'v')
onoremap <silent> <Plug>CamelCaseMotion_e :call camelcasemotion#Motion('e',v:count1,'o')
onoremap <silent> <Plug>CamelCaseMotion_b :call camelcasemotion#Motion('b',v:count1,'o')
onoremap <silent> <Plug>CamelCaseMotion_w :call camelcasemotion#Motion('w',v:count1,'o')
nnoremap <silent> <Plug>CamelCaseMotion_e :call camelcasemotion#Motion('e',v:count1,'n')
nnoremap <silent> <Plug>CamelCaseMotion_b :call camelcasemotion#Motion('b',v:count1,'n')
nnoremap <silent> <Plug>CamelCaseMotion_w :call camelcasemotion#Motion('w',v:count1,'n')
snoremap <silent> <Del> c
snoremap <silent> <BS> c
snoremap <silent> <C-S-Tab> :call UltiSnips#ListSnippets()
xnoremap <silent> <S-Tab> :call UltiSnips#SaveLastVisualSelection()gvs
snoremap <silent> <S-Tab> :call UltiSnips#ExpandSnippet()
nnoremap <C-S-Tab> :bprevious
nnoremap <C-Tab> :bnext
vnoremap <expr> <Up> DVB_Drag('up')
vnoremap <expr> <Down> DVB_Drag('down')
vnoremap <expr> <Right> DVB_Drag('right')
vnoremap <expr> <Left> DVB_Drag('left')
nnoremap <F10> :call ToggleYCM()
vnoremap <C-F9> :call ToggleFoldColumn()
nnoremap <C-F9> :call ToggleFoldColumn()
nnoremap <S-F9> :call ToggleWrap()
vnoremap <F9> :call ToggleTextwidth()
nnoremap <F9> :call ToggleTextwidth()
vnoremap <M-S-F8> :call AutoCorrect()
nnoremap <M-S-F8> :call AutoCorrect()
nnoremap <M-F8> :w !detex | wc -w
nnoremap <C-F8> :w!:!/usr/bin/aspell --dont-backup --dont-tex-check-comments check %:e! %
nnoremap <F8> :call ToggleSpell()
vnoremap <F7> :LanguageToolCheck:vertical  lopen  80
nnoremap <F7> :'{,'}LanguageToolCheck:vertical  lopen  80
vnoremap <F6> :cd %:p:h:echo expand('%:p')
nnoremap <F6> :cd %:p:h:echo expand('%:p')
nnoremap <F5> :FufMruFile
nnoremap <C-F4> :FufFile
nnoremap <S-F4> :FufFileWithFullCwd
nnoremap <F4> :FufFileWithCurrentBufferDir
nnoremap <S-F3> :buffer
nnoremap <F3> :FufBuffer
nnoremap <silent> <F2> :silent! :mks!:Git add %:p:exe "w | so $MYVIMRC | if foldclosed(\".\") >= 0 | %foldo! | endif"
vnoremap <F1> :echom "f2: save and source file | f3: bufferlist | f4: open file | f5: open mru file | f6: cd to curr | f7: language tool | f8: spell-check | f9: textwidth | f10: enable YCM"
nnoremap <F1> :echom "f2: save and source file | f3: bufferlist | f4: open file | f5: open mru file | f6: cd to curr | f7: language tool | f8: spell-check | f9: textwidth | f10: enable YCM"
imap S <Plug>ISurround
imap s <Plug>Isurround
imap  <Plug>Isurround
inoremap S :aboveleft split
inoremap <silent>  K =(ExpandPossibleShorterSnippet() == 0? '': UltiSnips#ExpandSnippet())
inoremap  bu :BundleInstall!
inoremap  bi  :BundleInstall
inoremap  bc :BundleClean!
inoremap  bl :BundleList
inoremap <silent> $$ $$=UltiSnips#Anon(':latex:\$1\', '$$')
inoremap <silent> (( ((=UltiSnips#Anon('(${1:${VISUAL}})', '((', '', 'i')
inoremap ,p :'{,'}
inoremap ,v :'<,'>
inoremap ,gq gqip``
inoremap <silent> ,cx :XeLatexCompilePDF
inoremap <silent> ,cl :CompilePdfLaTeX
inoremap <silent> ,ct :CompilePdfTeX
inoremap ,so :source $MYVIMRC
inoremap <silent> ,it vip:s/^/\\item /g
inoremap ,? ?\<\><Left><Left>
inoremap ,/ /\<\><Left><Left>
inoremap ,bb :g/^\_$\n\_^$/d
inoremap <silent> ,b# :s/-/#/g3
inoremap ,s :s/\<
inoremap ,: :%s/
inoremap <silent> ,yP :normal yygccp
inoremap <silent> ,yp :normal yyp
inoremap <silent> ,md :exe 'delm! | delm A-Z0-9 | echom "all marks removed!"'
inoremap <silent> ,mn :NoShowMarks
inoremap <silent> ,ms :DoShowMarks
inoremap <silent> ,ob :Obsession 
inoremap <expr> <K> BDG_GetDigraph()
inoremap <silent> [[ [[=UltiSnips#Anon(':latex:\$1\', '[[')
inoremap <silent> \K =(ExpandPossibleShorterSnippet() == 0? '': UltiSnips#ExpandSnippet())
cmap w!! w !sudo tee % >/dev/null
inoreabbr lidsa lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
inoreabbr Lidsa Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
inoreabbr LIDSA LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISICING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT. DUIS AUTE IRURE DOLOR IN REPREHENDERIT IN VOLUPTATE VELIT ESSE CILLUM DOLORE EU FUGIAT NULLA PARIATUR. EXCEPTEUR SINT OCCAECAT CUPIDATAT NON PROIDENT, SUNT IN CULPA QUI OFFICIA DESERUNT MOLLIT ANIM ID EST LABORUM
inoreabbr tqbf the quick, brown fox jumps over the lazy dog
inoreabbr Tqbf The quick, brown fox jumps over the lazy dog
inoreabbr TQBF THE QUICK, BROWN FOX JUMPS OVER THE LAZY DOG
inoreabbr scflead supercalifragilisticexpialidocious
inoreabbr SCFLEAD SUPERCALIFRAGILISTICEXPIALIDOCIOUS
inoreabbr Scflead Supercalifragilisticexpialidocious
inoreabbr Seguments Segments
inoreabbr SEGUMENTS SEGMENTS
inoreabbr Segument Segment
inoreabbr Segumentation Segmentation
inoreabbr Segumented Segmented
inoreabbr segumented segmented
inoreabbr SEGUMENTATION SEGMENTATION
inoreabbr seguments segments
inoreabbr SEGUMENT SEGMENT
inoreabbr segumentation segmentation
inoreabbr segument segment
inoreabbr SEGUMENTED SEGMENTED
inoreabbr seperate separate
inoreabbr Seperating Separating
inoreabbr seperation separation
inoreabbr SEPERATES SEPARATES
inoreabbr seperated separated
inoreabbr SEPERATE SEPARATE
inoreabbr SEPERATOR SEPARATOR
inoreabbr Seperator Separator
inoreabbr Seperation Separation
inoreabbr Seperates Separates
inoreabbr seperations separations
inoreabbr Seperately Separately
inoreabbr Seperations Separations
inoreabbr seperating separating
inoreabbr seperates separates
inoreabbr Seperated Separated
inoreabbr Seperate Separate
inoreabbr SEPERATED SEPARATED
inoreabbr seperator separator
inoreabbr SEPERATING SEPARATING
inoreabbr seperately separately
inoreabbr SEPERATION SEPARATION
inoreabbr SEPERATIONS SEPARATIONS
inoreabbr SEPERATELY SEPARATELY
inoreabbr RESTRAUNT RESTAURANT
inoreabbr Restraunts Restaurants
inoreabbr Restraunt Restaurant
inoreabbr RESTRAUNTS RESTAURANTS
inoreabbr restraunts restaurants
inoreabbr restraunt restaurant
inoreabbr Resouces Resources
inoreabbr resouce resource
inoreabbr resouces resources
inoreabbr RESOUCE RESOURCE
inoreabbr RESOUCES RESOURCES
inoreabbr Resouce Resource
inoreabbr Reproducable Reproducible
inoreabbr reproducable reproducible
inoreabbr REPRODUCABLE REPRODUCIBLE
inoreabbr RECOMENDED RECOMMENDED
inoreabbr RECOMENDS RECOMMENDS
inoreabbr reccommend recommend
inoreabbr RECCOMENDED RECOMMENDED
inoreabbr RECOMEND RECOMMEND
inoreabbr Recomending Recommending
inoreabbr recomended recommended
inoreabbr Reccommendation Recommendation
inoreabbr RECCOMMENDING RECOMMENDING
inoreabbr RECCOMMENDS RECOMMENDS
inoreabbr reccomends recommends
inoreabbr RECCOMMENDED RECOMMENDED
inoreabbr reccomending recommending
inoreabbr recomendation recommendation
inoreabbr recomend recommend
inoreabbr Recomended Recommended
inoreabbr RECCOMMENDATION RECOMMENDATION
inoreabbr reccommends recommends
inoreabbr Reccommended Recommended
inoreabbr Reccomendation Recommendation
inoreabbr recomends recommends
inoreabbr Recomendation Recommendation
inoreabbr Reccommends Recommends
inoreabbr reccomended recommended
inoreabbr reccommending recommending
inoreabbr Reccomended Recommended
inoreabbr Reccommending Recommending
inoreabbr RECCOMENDS RECOMMENDS
inoreabbr Reccommend Recommend
inoreabbr Recomend Recommend
inoreabbr reccommended recommended
inoreabbr reccomendation recommendation
inoreabbr RECCOMENDING RECOMMENDING
inoreabbr RECCOMEND RECOMMEND
inoreabbr RECCOMMEND RECOMMEND
inoreabbr Reccomends Recommends
inoreabbr reccomend recommend
inoreabbr Reccomending Recommending
inoreabbr RECOMENDATION RECOMMENDATION
inoreabbr reccommendation recommendation
inoreabbr RECOMENDING RECOMMENDING
inoreabbr recomending recommending
inoreabbr Reccomend Recommend
inoreabbr RECCOMENDATION RECOMMENDATION
inoreabbr Recomends Recommends
inoreabbr RELEVENCY RELEVANCY
inoreabbr RELEVENTLY RELEVANTLY
inoreabbr irrelevence irrelevance
inoreabbr Irrelevent Irrelevant
inoreabbr relevency relevancy
inoreabbr Irrelevently Irrelevantly
inoreabbr Irrelevency Irrelevancy
inoreabbr Relevent Relevant
inoreabbr relevently relevantly
inoreabbr Irrelevence Irrelevance
inoreabbr IRRELEVENTLY IRRELEVANTLY
inoreabbr IRRELEVENT IRRELEVANT
inoreabbr RELEVENT RELEVANT
inoreabbr IRRELEVENCY IRRELEVANCY
inoreabbr relevent relevant
inoreabbr IRRELEVENCE IRRELEVANCE
inoreabbr Relevency Relevancy
inoreabbr Relevence Relevance
inoreabbr irrelevently irrelevantly
inoreabbr irrelevency irrelevancy
inoreabbr Relevently Relevantly
inoreabbr relevence relevance
inoreabbr irrelevent irrelevant
inoreabbr RELEVENCE RELEVANCE
inoreabbr REFERESH REFRESH
inoreabbr REFERESHES REFRESHES
inoreabbr refereshes refreshes
inoreabbr Referesh Refresh
inoreabbr Refereshes Refreshes
inoreabbr referesh refresh
inoreabbr PERSISTANT PERSISTENT
inoreabbr Persistantly Persistently
inoreabbr PERSISTANTLY PERSISTENTLY
inoreabbr persistantly persistently
inoreabbr persistance persistence
inoreabbr persistant persistent
inoreabbr Persistance Persistence
inoreabbr PERSISTANCE PERSISTENCE
inoreabbr Persistant Persistent
inoreabbr ORGIN ORIGIN
inoreabbr UNORGIN UNORIGIN
inoreabbr ORGINAL ORIGINAL
inoreabbr orgin origin
inoreabbr unorginal unoriginal
inoreabbr Orginal Original
inoreabbr orginal original
inoreabbr Unorginal Unoriginal
inoreabbr Unorgin Unorigin
inoreabbr unorgin unorigin
inoreabbr Orgin Origin
inoreabbr UNORGINAL UNORIGINAL
inoreabbr necesarily necessarily
inoreabbr Unnecesarily Unnecessarily
inoreabbr NECESARY NECESSARY
inoreabbr Necesarily Necessarily
inoreabbr Unneccessarily Unnecessarily
inoreabbr UNNECCESARILY UNNECESSARILY
inoreabbr UNNECESARILY UNNECESSARILY
inoreabbr Neccessarily Necessarily
inoreabbr Neccesarily Necessarily
inoreabbr neccessary necessary
inoreabbr Unneccessary Unnecessary
inoreabbr Necesary Necessary
inoreabbr Unneccesarily Unnecessarily
inoreabbr NECCESSARILY NECESSARILY
inoreabbr NECCESARY NECESSARY
inoreabbr unneccesary unnecessary
inoreabbr Unnecesary Unnecessary
inoreabbr neccesary necessary
inoreabbr unnecesarily unnecessarily
inoreabbr NECCESSARY NECESSARY
inoreabbr Neccesary Necessary
inoreabbr Unneccesary Unnecessary
inoreabbr unneccessarily unnecessarily
inoreabbr NECESARILY NECESSARILY
inoreabbr NECCESARILY NECESSARILY
inoreabbr neccessarily necessarily
inoreabbr neccesarily necessarily
inoreabbr Neccessary Necessary
inoreabbr unneccessary unnecessary
inoreabbr necesary necessary
inoreabbr unneccesarily unnecessarily
inoreabbr UNNECCESSARILY UNNECESSARILY
inoreabbr UNNECESARY UNNECESSARY
inoreabbr UNNECCESARY UNNECESSARY
inoreabbr UNNECCESSARY UNNECESSARY
inoreabbr unnecesary unnecessary
inoreabbr comparsion comparison
inoreabbr COMPARSION COMPARISON
inoreabbr Lession Lesson
inoreabbr LESSION LESSON
inoreabbr Lessions Lessons
inoreabbr COMPARSIONS COMPARISONS
inoreabbr Comparisions Comparisons
inoreabbr Comparision Comparison
inoreabbr Comparsion Comparison
inoreabbr lession lesson
inoreabbr COMPARISION COMPARISON
inoreabbr Comparsions Comparisons
inoreabbr comparisions comparisons
inoreabbr comparision comparison
inoreabbr lessions lessons
inoreabbr comparsions comparisons
inoreabbr LESSIONS LESSONS
inoreabbr COMPARISIONS COMPARISONS
inoreabbr Lastest Latest
inoreabbr LASTEST LATEST
inoreabbr lastest latest
inoreabbr Inherant Inherent
inoreabbr inherantly inherently
inoreabbr INHERANT INHERENT
inoreabbr Inherantly Inherently
inoreabbr inherant inherent
inoreabbr INHERANTLY INHERENTLY
inoreabbr Improvment Improvement
inoreabbr improvment improvement
inoreabbr IMPROVMENTS IMPROVEMENTS
inoreabbr improvments improvements
inoreabbr Improvments Improvements
inoreabbr IMPROVMENT IMPROVEMENT
inoreabbr Reimplimentation Reimplementation
inoreabbr REIMPLIMENTED REIMPLEMENTED
inoreabbr Reimpliments Reimplements
inoreabbr reimpliment reimplement
inoreabbr Implimenting Implementing
inoreabbr REIMPLIMENT REIMPLEMENT
inoreabbr IMPLIMENTS IMPLEMENTS
inoreabbr REIMPLIMENTATION REIMPLEMENTATION
inoreabbr reimplimenting reimplementing
inoreabbr REIMPLIMENTS REIMPLEMENTS
inoreabbr implimented implemented
inoreabbr Impliment Implement
inoreabbr REIMPLIMENTING REIMPLEMENTING
inoreabbr IMPLIMENT IMPLEMENT
inoreabbr reimplimentation reimplementation
inoreabbr Implimentation Implementation
inoreabbr reimpliments reimplements
inoreabbr Reimplimented Reimplemented
inoreabbr implimenting implementing
inoreabbr IMPLIMENTING IMPLEMENTING
inoreabbr Impliments Implements
inoreabbr reimplimented reimplemented
inoreabbr Reimpliment Reimplement
inoreabbr implimentation implementation
inoreabbr Implimented Implemented
inoreabbr IMPLIMENTED IMPLEMENTED
inoreabbr Reimplimenting Reimplementing
inoreabbr impliment implement
inoreabbr impliments implements
inoreabbr IMPLIMENTATION IMPLEMENTATION
inoreabbr Hense Hence
inoreabbr HENSE HENCE
inoreabbr hense hence
inoreabbr euphamism euphemism
inoreabbr EUPHAMISMS EUPHEMISMS
inoreabbr euphamistically euphemistically
inoreabbr Euphamisms Euphemisms
inoreabbr Euphamistic Euphemistic
inoreabbr Euphamistically Euphemistically
inoreabbr euphamisms euphemisms
inoreabbr EUPHAMISTICALLY EUPHEMISTICALLY
inoreabbr Euphamism Euphemism
inoreabbr euphamistic euphemistic
inoreabbr EUPHAMISM EUPHEMISM
inoreabbr EUPHAMISTIC EUPHEMISTIC
inoreabbr DESCREPANCY DISCREPANCY
inoreabbr discrepancies discrepancies
inoreabbr Descrepancies Discrepancies
inoreabbr Descrepancy Discrepancy
inoreabbr Discrepencies Discrepancies
inoreabbr descrepencies discrepancies
inoreabbr Discrepancies Discrepancies
inoreabbr DISCREPENCY DISCREPANCY
inoreabbr Discrepancy Discrepancy
inoreabbr DESCREPANCIES DISCREPANCIES
inoreabbr DISCREPENCIES DISCREPANCIES
inoreabbr Descrepency Discrepancy
inoreabbr discrepancy discrepancy
inoreabbr Descrepencies Discrepancies
inoreabbr descrepency discrepancy
inoreabbr DISCREPANCIES DISCREPANCIES
inoreabbr descrepancy discrepancy
inoreabbr discrepencies discrepancies
inoreabbr discrepency discrepancy
inoreabbr DISCREPANCY DISCREPANCY
inoreabbr DESCREPENCIES DISCREPANCIES
inoreabbr descrepancies discrepancies
inoreabbr DESCREPENCY DISCREPANCY
inoreabbr Discrepency Discrepancy
inoreabbr Desparate Desperate
inoreabbr desparate desperate
inoreabbr desparation desperation
inoreabbr Desparately Desperately
inoreabbr desparately desperately
inoreabbr DESPARATELY DESPERATELY
inoreabbr DESPARATION DESPERATION
inoreabbr DESPARATE DESPERATE
inoreabbr Desparation Desperation
inoreabbr existant existent
inoreabbr nonexistant nonexistent
inoreabbr NONEXISTANCE NONEXISTENCE
inoreabbr NONEXISTANT NONEXISTENT
inoreabbr Nonexistant Nonexistent
inoreabbr EXISTANCE EXISTENCE
inoreabbr nonexistance nonexistence
inoreabbr EXISTANT EXISTENT
inoreabbr Nonexistance Nonexistence
inoreabbr Existant Existent
inoreabbr existance existence
inoreabbr Existance Existence
inoreabbr delimeters delimiters
inoreabbr Delimeter Delimiter
inoreabbr Delimeters Delimiters
inoreabbr DELIMETER DELIMITER
inoreabbr DELIMETERS DELIMITERS
inoreabbr delimeter delimiter
inoreabbr destionation destination
inoreabbr Destionations Destinations
inoreabbr destionations destinations
inoreabbr DESTIONATION DESTINATION
inoreabbr Destionation Destination
inoreabbr DESTIONATIONS DESTINATIONS
inoreabbr INCONSISTANCIES INCONSISTENCIES
inoreabbr consistancies consistencies
inoreabbr Consistantly Consistently
inoreabbr inconsistant inconsistent
inoreabbr consistant consistent
inoreabbr Inconsistancies Inconsistencies
inoreabbr Consistancy Consistency
inoreabbr CONSISTANCY CONSISTENCY
inoreabbr inconsistantly inconsistently
inoreabbr INCONSISTANTLY INCONSISTENTLY
inoreabbr CONSISTANTLY CONSISTENTLY
inoreabbr Inconsistancy Inconsistency
inoreabbr Consistancies Consistencies
inoreabbr consistantly consistently
inoreabbr Inconsistant Inconsistent
inoreabbr INCONSISTANT INCONSISTENT
inoreabbr Consistant Consistent
inoreabbr inconsistancies inconsistencies
inoreabbr consistancy consistency
inoreabbr INCONSISTANCY INCONSISTENCY
inoreabbr Inconsistantly Inconsistently
inoreabbr CONSISTANT CONSISTENT
inoreabbr inconsistancy inconsistency
inoreabbr CONSISTANCIES CONSISTENCIES
inoreabbr Carraiges Carriages
inoreabbr carraige carriage
inoreabbr Marraiges Marriages
inoreabbr CARRAIGE CARRIAGE
inoreabbr marraiges marriages
inoreabbr marraige marriage
inoreabbr MARRAIGES MARRIAGES
inoreabbr MARRAIGE MARRIAGE
inoreabbr carraiges carriages
inoreabbr Marraige Marriage
inoreabbr Carraige Carriage
inoreabbr CARRAIGES CARRIAGES
inoreabbr CALANDER CALENDAR
inoreabbr calanders calendars
inoreabbr calander calendar
inoreabbr CALENDER CALENDAR
inoreabbr Calanders Calendars
inoreabbr CALANDERS CALENDARS
inoreabbr calenders calendars
inoreabbr Calender Calendar
inoreabbr calender calendar
inoreabbr Calander Calendar
inoreabbr Calenders Calendars
inoreabbr CALENDERS CALENDARS
inoreabbr AUSTRAILIAN AUSTRALIAN
inoreabbr Austraila Australia
inoreabbr Austrailian Australian
inoreabbr Austrailia Australia
inoreabbr AUSTRAILIA AUSTRALIA
inoreabbr austrailan australian
inoreabbr austrailia australia
inoreabbr AUSTRAILAN AUSTRALIAN
inoreabbr austrailian australian
inoreabbr austraila australia
inoreabbr Austrailan Australian
inoreabbr AUSTRAILA AUSTRALIA
inoreabbr ANOMOLY ANOMALY
inoreabbr anomolies anomalies
inoreabbr anomoly anomaly
inoreabbr Anomolies Anomalies
inoreabbr Anomoly Anomaly
inoreabbr ANOMOLIES ANOMALIES
inoreabbr Afterword Afterward
inoreabbr AFTERWORDS AFTERWARDS
inoreabbr AFTERWORD AFTERWARD
inoreabbr Afterwords Afterwards
inoreabbr afterwords afterwards
inoreabbr afterword afterward
inoreabbr _SAOP SAVE_AND_OPEN_PAGE
inoreabbr Saop SaveAndOpenPage
inoreabbr _saop save_and_open_page
inoreabbr _fgc FactoryGirl.create
inoreabbr Fgc FactoryGirl.create
inoreabbr _FGC FACTORYGIRL.CREATE
inoreabbr _pry require 'pry'; binding.pry
inoreabbr _PRY REQUIRE 'PRY'; BINDING.PRY
inoreabbr Pry Require 'pry'; binding.pry
inoreabbr Od Do
inoreabbr od do
inoreabbr OD DO
inoreabbr NED END
inoreabbr Ned End
inoreabbr ned end
inoreabbr 3ND END
inoreabbr 3nd end
inoreabbr Fyi For your information
inoreabbr fyi for your information
inoreabbr FYI FOR YOUR INFORMATION
inoreabbr imo in my opinion
inoreabbr Imo In my opinion
inoreabbr IMO IN MY OPINION
inoreabbr btw by the way
inoreabbr Btw By the way
inoreabbr BTW BY THE WAY
inoreabbr otoh on the other hand
inoreabbr Otoh On the other hand
inoreabbr OTOH ON THE OTHER HAND
inoreabbr wrt with respect to
inoreabbr Wrt With respect to
inoreabbr WRT WITH RESPECT TO
inoreabbr dont don't
inoreabbr Dont Don't
inoreabbr DONT DON'T
inoreabbr BZGL BZGL.
inoreabbr bzgl bzgl.
inoreabbr Bzgl Bzgl.
inoreabbr vgl vgl.
inoreabbr VGL VGL.
inoreabbr Vgl Vgl.
inoreabbr etc etc.
inoreabbr ETC ETC.
inoreabbr Etc Etc.
inoreabbr Usw Usw.
inoreabbr USW USW.
inoreabbr usw usw.
inoreabbr Bspw Bspw.
inoreabbr BSPW BSPW.
inoreabbr bspw bspw.
inoreabbr EIGTL EIGTL.
inoreabbr Eigtl Eigtl.
inoreabbr eigtl eigtl.
inoreabbr BZW BZW.
inoreabbr Bzw Bzw.
inoreabbr bzw bzw.
inoreabbr abwärtsbeweung abwärtsbewegung
inoreabbr Abwärtsbeweung Abwärtsbewegung
inoreabbr ABWÄRTSBEWEUNG ABWÄRTSBEWEGUNG
inoreabbr finanzinsitutionen finanzinstitutionen
inoreabbr Finanzinsitutionen Finanzinstitutionen
inoreabbr FINANZINSITUTIONEN FINANZINSTITUTIONEN
iabbr fg freundliche GrüßeJonas Petong
iabbr mfg Mit freundlichen GrüßenJonas Petong
iabbr bg Beste GrüßeJonas 
iabbr lg Liebe GrüßeJonas 
iabbr vg Viele GrüßeJonas 
iabbr abrazo Un abrazoJonas 
iabbr gr Gruß Jonas 
iabbr sgf Sehr geehrte Frau,
iabbr sgh Sehr geehrter Herr,
iabbr sgdh Sehr geehrte Damen und Herren,
iabbr addr Dellplatz 7, c/o Zimmer 316, 47051 Duisburg
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=indent,eol,start
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*test*,*temp*,*tmp*,*tst*,*~,*bak
set clipboard=unnamed,unnamedplus
set cmdheight=3
set cmdwinheight=3
set comments=:#,://,:%,:XCOMM,b:-,n:>,n:*,n:#,s2:/*,mb:*,ex:*/,:\\begin{,:\\end{,:\\title{,:\\author{,:\\subtitle{,:\\part{,:\\chapter{,:\\section{,:\\subsection{,:\\subsubsection{,:\\paragraph,:\\subparagraph{,:\\usepackage{,:\\documenclass{,:\\usepackage[
set commentstring=#\ %s
set complete=.,w,b,u,t,i,k
set confirm
set copyindent
set cpoptions=aABceFsmq
set dictionary=~/.aspell.de.pws,~/.vim/spell
set diffopt=filler,context:6
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set fileformats=unix,dos,mac
set foldclose=all
set foldlevelstart=0
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,insert,jump
set formatoptions=tocqrnl
set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*<\\d\\+>\\s\\+\\|^\\s*[a-zA-Z.]\\.\\s\\+\\|^\\s*[ivxIVX]\\+\\.\\s\\+
set helplang=de
set hidden
set hlsearch
set ignorecase
set incsearch
set nojoinspaces
set laststatus=2
set lazyredraw
set lispwords=
set listchars=tab:»»,trail:·,nbsp:~
set matchpairs=(:),{:},[:],<:>
set matchtime=2
set modelines=3
set omnifunc=syntaxcomplete#Complete
set operatorfunc=<SNR>67_go
set path=~/bin/**,~/Unimaterialien
set ruler
set rulerformat=%25(%n%m%r:\ %Y\ [%l,%v]\ %p%%%)
set runtimepath=~/.vim,~/.vim/bundle/vundle,~/.vim/bundle/L9,~/.vim/bundle/LaTeX-Box,~/.vim/bundle/excel.vim,~/.vim/bundle/ultisnips,~/.vim/bundle/vim-colors-solarized,~/.vim/bundle/frisk,~/.vim/bundle/CamelCaseMotion,~/.vim/bundle/vim-tmux-navigator,~/.vim/bundle/vim-asterisk,~/.vim/bundle/vim-snippets,~/.vim/bundle/vim-showmarks,~/.vim/bundle/Vim-R-plugin,~/.vim/bundle/vim-origami,~/.vim/bundle/matchit.zip,~/.vim/bundle/vim-tex-fold,~/.vim/bundle/vis.vim,~/.vim/bundle/vim-markdown-folding,~/.vim/bundle/vim-autocorrect,~/.vim/bundle/syntastic,~/.vim/bundle/vim-exchange,~/.vim/bundle/vim-commentary,~/.vim/bundle/vim-abolish,~/.vim/bundle/vim-dispatch,~/.vim/bundle/vim-fugitive,~/.vim/bundle/vim-git,~/.vim/bundle/vim-obsession,~/.vim/bundle/vim-repeat,~/.vim/bundle/vim-surround,~/.vim/bundle/vim-unimpaired,~/.vim/bundle/Align,~/.vim/bundle/vim-pandoc-syntax,~/.vim/bundle/vim-rmarkdown,~/.vim/bundle/ExtractLinks,~/.vim/bundle/FuzzyFinder,~/.vim/bundle/LanguageTool,~/.vim/bundle/targets.vim,~/.vim/bundle/VimCom,~/.vim/bundle/vim-ycm-tex,~/.vim/bundle/vim-americanize,~/.vim/bundle/ingo-library,~/.vim/bundle/extractmatches,~/.vim/bundle/PatternsOnText,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,~/.vim/after,~/.vim/plugin/,~/.vim/bundle/vundle/,~/.vim/bundle/vundle/after,~/.vim/bundle/L9/after,~/.vim/bundle/LaTeX-Box/after,~/.vim/bundle/excel.vim/after,~/.vim/bundle/ultisnips/after,~/.vim/bundle/vim-colors-solarized/after,~/.vim/bundle/frisk/after,~/.vim/bundle/CamelCaseMotion/after,~/.vim/bundle/vim-tmux-navigator/after,~/.vim/bundle/vim-asterisk/after,~/.vim/bundle/vim-snippets/after,~/.vim/bundle/vim-showmarks/after,~/.vim/bundle/Vim-R-plugin/after,~/.vim/bundle/vim-origami/after,~/.vim/bundle/matchit.zip/after,~/.vim/bundle/vim-tex-fold/after,~/.vim/bundle/vis.vim/after,~/.vim/bundle/vim-markdown-folding/after,~/.vim/bundle/vim-autocorrect/after,~/.vim/bundle/syntastic/after,~/.vim/bundle/vim-exchange/after,~/.vim/bundle/vim-commentary/after,~/.vim/bundle/vim-abolish/after,~/.vim/bundle/vim-dispatch/after,~/.vim/bundle/vim-fugitive/after,~/.vim/bundle/vim-git/after,~/.vim/bundle/vim-obsession/after,~/.vim/bundle/vim-repeat/after,~/.vim/bundle/vim-surround/after,~/.vim/bundle/vim-unimpaired/after,~/.vim/bundle/Align/after,~/.vim/bundle/vim-pandoc-syntax/after,~/.vim/bundle/vim-rmarkdown/after,~/.vim/bundle/ExtractLinks/after,~/.vim/bundle/FuzzyFinder/after,~/.vim/bundle/LanguageTool/after,~/.vim/bundle/targets.vim/after,~/.vim/bundle/VimCom/after,~/.vim/bundle/vim-ycm-tex/after,~/.vim/bundle/vim-americanize/after,~/.vim/bundle/ingo-library/after,~/.vim/bundle/extractmatches/after,~/.vim/bundle/PatternsOnText/after
set scrolloff=5
set shell=/bin/sh
set shiftround
set shiftwidth=4
set shortmess=filnxToOatI
set showmatch
set showtabline=0
set smarttab
set softtabstop=4
set splitbelow
set splitright
set nostartofline
set statusline=%1*%02n%2*|%t|%1*%{&fo}|%3*%{(fugitive#head()!=\"\"?'(':'')}%3*%<%{(fugitive#head()!=\"\"?fugitive#head():'')}%3*%{(fugitive#head()!=\"\"?')':'')}%2*%=%((%{&ff}|%{(strlen(&fenc)?&enc:&fenc)}%k|%Y)%)%2*\ %(%l,%v|%02p%%\ %)
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.out,.toc
set switchbuf=useopen,usetab
set synmaxcol=200
set tabstop=4
set thesaurus=~/.vim/thesaurus/thes_de.txt
set title
set ttimeoutlen=100
set ttyscroll=0
set updatetime=1000
set viminfo='10,\"500,:1000,%,n~/.viminfo
set visualbell
set wildignore=*.a,*.aut,*.aux,*.bak,*.bbl,*.blg,*.cmi,*.cmo,*.cmx,*.cmxa,*.dvi,*.exe,*.fff,*.lo,*.log,*.o,*.obj,*.out,*.pdf,*.ps,*.py[co],*.swp,*.toc,*.ttt,*~,.svn
set wildmenu
set winheight=30
set winminheight=0
set winwidth=55
set nowrapscan
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/bin
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 imgckCollage
badd +0 imgckMorphology
badd +669 ~/.vim/vimrc_general
argglobal
silent! argdel *
argadd imgckCollage
edit imgckCollage
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 12 + 9) / 18)
exe '2resize ' . ((&lines * 0 + 9) / 18)
exe 'vert 2resize ' . ((&columns * 94 + 75) / 150)
exe '3resize ' . ((&lines * 0 + 9) / 18)
exe 'vert 3resize ' . ((&columns * 94 + 75) / 150)
exe '4resize ' . ((&lines * 1 + 9) / 18)
exe 'vert 4resize ' . ((&columns * 55 + 75) / 150)
argglobal
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#,://,:%,:XCOMM,b:-,n:>,n:*,n:#,s2:/*,mb:*,ex:*/,:\\begin{,:\\end{,:\\title{,:\\author{,:\\subtitle{,:\\part{,:\\chapter{,:\\section{,:\\subsection{,:\\subsubsection{,:\\paragraph,:\\subparagraph{,:\\usepackage{,:\\documenclass{,:\\usepackage[
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i,k
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal copyindent
setlocal cryptmethod=
setlocal nocursorbind
set cursorcolumn
setlocal cursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'bash'
setlocal filetype=bash
endif
set foldcolumn=4
setlocal foldcolumn=4
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
setlocal foldmethod=marker
set foldminlines=2
setlocal foldminlines=2
set foldnestmax=2
setlocal foldnestmax=2
set foldtext=MyFoldText()
setlocal foldtext=MyFoldText()
setlocal formatexpr=
setlocal formatoptions=tocqrnl
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*<\\d\\+>\\s\\+\\|^\\s*[a-zA-Z.]\\.\\s\\+\\|^\\s*[ivxIVX]\\+\\.\\s\\+
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetShIndent()
setlocal indentkeys=0{,0},!^F,o,O,e,},\\item,\\bibitem,\\else,\\fi,\\or,\\],0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,),0=;;,0=;&,0=fin,0=fil,0=fip,0=fir,0=fix
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=trs\ {es=@es+de}
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=syntaxcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=200
if &syntax != 'bash'
setlocal syntax=bash
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 1 - ((0 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 028|
wincmd w
argglobal
edit imgckCollage
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#,://,:%,:XCOMM,b:-,n:>,n:*,n:#,s2:/*,mb:*,ex:*/,:\\begin{,:\\end{,:\\title{,:\\author{,:\\subtitle{,:\\part{,:\\chapter{,:\\section{,:\\subsection{,:\\subsubsection{,:\\paragraph,:\\subparagraph{,:\\usepackage{,:\\documenclass{,:\\usepackage[
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i,k
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal copyindent
setlocal cryptmethod=
setlocal nocursorbind
set cursorcolumn
setlocal cursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'bash'
setlocal filetype=bash
endif
set foldcolumn=4
setlocal foldcolumn=4
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
setlocal foldmethod=syntax
set foldminlines=2
setlocal foldminlines=2
set foldnestmax=2
setlocal foldnestmax=2
set foldtext=MyFoldText()
setlocal foldtext=MyFoldText()
setlocal formatexpr=
setlocal formatoptions=tocqrnl
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*<\\d\\+>\\s\\+\\|^\\s*[a-zA-Z.]\\.\\s\\+\\|^\\s*[ivxIVX]\\+\\.\\s\\+
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetShIndent()
setlocal indentkeys=0{,0},!^F,o,O,e,},\\item,\\bibitem,\\else,\\fi,\\or,\\],0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,),0=;;,0=;&,0=fin,0=fil,0=fip,0=fir,0=fix
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=trs\ {es=@es+de}
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=syntaxcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=200
if &syntax != 'bash'
setlocal syntax=bash
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 18 - ((6 * winheight(0) + 0) / 0)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
normal! 0
lcd ~/bin
wincmd w
argglobal
edit ~/bin/imgckCollage
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#,://,:%,:XCOMM,b:-,n:>,n:*,n:#,s2:/*,mb:*,ex:*/,:\\begin{,:\\end{,:\\title{,:\\author{,:\\subtitle{,:\\part{,:\\chapter{,:\\section{,:\\subsection{,:\\subsubsection{,:\\paragraph,:\\subparagraph{,:\\usepackage{,:\\documenclass{,:\\usepackage[
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i,k
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal copyindent
setlocal cryptmethod=
setlocal nocursorbind
set cursorcolumn
setlocal cursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'bash'
setlocal filetype=bash
endif
set foldcolumn=4
setlocal foldcolumn=4
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
setlocal foldmethod=syntax
set foldminlines=2
setlocal foldminlines=2
set foldnestmax=2
setlocal foldnestmax=2
set foldtext=MyFoldText()
setlocal foldtext=MyFoldText()
setlocal formatexpr=
setlocal formatoptions=tocqrnl
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*<\\d\\+>\\s\\+\\|^\\s*[a-zA-Z.]\\.\\s\\+\\|^\\s*[ivxIVX]\\+\\.\\s\\+
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetShIndent()
setlocal indentkeys=0{,0},!^F,o,O,e,},\\item,\\bibitem,\\else,\\fi,\\or,\\],0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,),0=;;,0=;&,0=fin,0=fil,0=fip,0=fir,0=fix
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=trs\ {es=@es+de}
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=syntaxcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=200
if &syntax != 'bash'
setlocal syntax=bash
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 60 - ((4 * winheight(0) + 0) / 0)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
60
normal! 017|
wincmd w
argglobal
edit ~/bin/imgckMorphology
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,b:-,n:*,n:#,s2:/*,:\\begin{,:\\end{,:\\title{,:\\author{,:\\subtitle{,:\\part{,:\\chapter{,:\\section{,:\\subsection{,:\\subsubsection{,:\\paragraph,:\\subparagraph{,:\\usepackage{,:\\documenclass{,:\\usepackage[,:#
setlocal commentstring=#%s
setlocal complete=.,w,b,u,t,i,k
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal copyindent
setlocal cryptmethod=
setlocal nocursorbind
set cursorcolumn
setlocal cursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'sh'
setlocal filetype=sh
endif
set foldcolumn=4
setlocal foldcolumn=4
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=syntax
set foldminlines=2
setlocal foldminlines=2
set foldnestmax=2
setlocal foldnestmax=2
set foldtext=MyFoldText()
setlocal foldtext=MyFoldText()
setlocal formatexpr=
setlocal formatoptions=tocqrnl
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*<\\d\\+>\\s\\+\\|^\\s*[a-zA-Z.]\\.\\s\\+\\|^\\s*[ivxIVX]\\+\\.\\s\\+
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetShIndent()
setlocal indentkeys=0{,0},!^F,o,O,e,0=then,0=do,0=else,0=elif,0=fi,0=esac,0=done,),0=;;,0=;&,0=fin,0=fil,0=fip,0=fir,0=fix
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,.
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=syntaxcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=200
if &syntax != 'sh'
setlocal syntax=sh
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 32 - ((0 * winheight(0) + 0) / 1)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
32
normal! 0
lcd ~/bin
wincmd w
exe '1resize ' . ((&lines * 12 + 9) / 18)
exe '2resize ' . ((&lines * 0 + 9) / 18)
exe 'vert 2resize ' . ((&columns * 94 + 75) / 150)
exe '3resize ' . ((&lines * 0 + 9) / 18)
exe 'vert 3resize ' . ((&columns * 94 + 75) / 150)
exe '4resize ' . ((&lines * 1 + 9) / 18)
exe 'vert 4resize ' . ((&columns * 55 + 75) / 150)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=30 winwidth=55 shortmess=filnxToOatI
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
