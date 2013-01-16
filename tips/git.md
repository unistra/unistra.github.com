---
layout: page
---
{% include JB/setup %}

# alias qui vont bien

tappez

    echo alias g=git >> ~/.zshenv
    git config --global alias.s=status -s
    git config --global alias.ci=commit
    git config --global alias.co=checkout
    git config --global alias.br=branch
    git config --global alias.aa=add -A
    git config -l # vérifions que tout est bien en place
    git config -e # éditons

apres avoir sourcé votre /.zshenv, vous pouvez maintenant tapper  

    g s

plutot que status -s

dans votre ~/.ssh/config, ajoutez

    host gh
    hostname github.com
    user git

vous pouvez maintenant tapper 

    g clone gh:eiro/p5-perlude


installer fugitive.vim pour utiliser git directement depuis vim


