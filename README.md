# hoon-assist-emacs
Provide official documentation for Hoon runes and commands under point. 

## Installation

Installation is manual.

1. Install  [hoon-mode.el](https://github.com/urbit/hoon-mode.el).

2. `git clone https://github.com/poctyr-bidbes/hoon-assist-emacs.git`

3. Move the following files into your ~/.emacs.d/site-lisp/ directory:

	hoon-assist-emacs.el<br>
	hoon-dictionary.json

4. Add a hoon-mode hook to your init.el file

```
(defun hoon-assist-hook ()
  (progn
    (global-set-key (kbd "<f7>") 'get-token-definition)
    (setq site-lisp-dir "~/.emacs.d/site-lisp/")
    (setq dict-file (concat site-lisp-dir "hoon-dictionary.json"))
    (load "hoon-assist-emacs")
    (message "hoon-assist loaded")))

(add-hook 'hoon-mode-hook 'hoon-assist-hook )
```

## Operation

Restart emacs, open a hoon file.

Place point on the rune or command you would like defined. Press F7. Press F7 again to close the documentation window.

## Notes

Modify the hook function to utilize a different function key. Alternatively you can `M-x get-token-definition`.

If your site-lisp directory differs from `~/.emacs.d/site-lisp` you will need to edit the `site-lisp-dir` variable in the hook method.


Tested with GNU Emacs 27.1 on Ubuntu 22.04.2 LTS, 8GB RAM 
