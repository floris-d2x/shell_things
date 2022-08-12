#! /bin/echo Source this file instead of running it

# utility aliases
alias tree="exa -TL=3"
alias back="cd $OLDPWD"

# utility functions
ms() {
fd -e "$3" -x sed -i "s/$1/$2/g"
}
