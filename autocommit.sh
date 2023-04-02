#! /bin/bash

cp ~/projects/hoon-assist-emacs/hoon-assist-emacs.el .
cp ~/projects/hoon-assist-emacs/README.md .

git add .
git commit -m "autocommit"
git push
