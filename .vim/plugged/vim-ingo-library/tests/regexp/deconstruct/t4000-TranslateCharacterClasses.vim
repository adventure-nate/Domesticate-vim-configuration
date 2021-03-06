" Test removing character classes and similar.

scriptencoding utf-8

call vimtest#StartTap()
call vimtap#Plan(11)

call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('foobar'), 'foobar', 'no character classes')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('\i\I\k\K\f\F\p\P\s\S\d\D\x\X\o\O\w\W\h\H\a\A\l\L\u\U'), 'ππΌππΎππΉπππ πππ·π₯ππππ€πππ»ππ΄ππΏπ’π', 'all character classes')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('[^[:lower:]]oo[[:alpha:]]ar[[:space:][:xdigit:]]'), 'πΏooπarβ¦', 'collection classes')

call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('f\k\kbar'), 'fππbar', 'a character class')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('fo[abcopq]!'), 'foβ¦!', 'simple collection')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('fo[[:alnum:]xyz][^a-z]!'), 'foβ¦β¦!', 'multiple collections')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('fo\_[abcopq]!'), 'foβ¦!', 'collection including EOL')

call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('[[]foo[]]b[a]r[^!]'), '[foo]barβ¦', 'single-literal collections')

call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('foo\%[bar]quux'), 'foobarquux', 'optional sequence')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('r\%[[eo]ad]'), "rβ¦ad", 'optional sequence with character class inside')
call vimtap#Is(ingo#regexp#deconstruct#TranslateCharacterClasses('index\%[[[]0[]]]'), 'index[0]', 'optional sequence with square brackets')

call vimtest#Quit()
