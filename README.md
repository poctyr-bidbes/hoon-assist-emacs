# hoon-assist-emacs
Provide official documentation for Hoon runes and commands under point. 

## Installation

`git clone https://github.com/poctyr-bidbes/hoon-assist-emacs.git`

Move the following files into your ~/site-lisp/ directory:

hoon-assist-emacs.el
hoon-dictionary.json

add (require 'hoon-assist-emacs) to your init.el file

## Operation

Place point on the rune or command you would like defined. Press F7. Press F7 again to close the documentation window.

## Notes

hoon-assist-emacs will globally modify the function attached to the F7 function key. Inactivate or choose a different key by editing hoon-assist-emacs.el directly.

hoon-assist-emacs does not perform syntax highlighting. Consider [hoon-mode.el](https://github.com/urbit/hoon-mode.el).
