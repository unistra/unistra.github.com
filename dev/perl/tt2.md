% Syympa TT2 guidelines

This is an exemple of template found in the current
[sympa](http://www.sympa.org) codebase. It is very similar to the examples
you can find in the
[Template Toolkit documentation](https://metacpan.org/release/Template-Toolkit).
However, i think we can write better code using some extra features.

This article is not a tutorial: it assumes you're already familiar with the TT2
syntax.

so let's see

~~~{.tt2}
[% IF may_create_list %]
   [% IF action == 'create_list_request' %]
       [% SET class = 'MainMenuLinksCurrentPage' %]
   [% ELSE %]
       [% SET class = 'MainMenuLinks' %]
   [% END %]<li><a class="[% class %]" href="[%
	path_cgi %]/create_list_request" >[%|loc%]Create list[%END%]</a></li>
[% END %] 
~~~

* As filters can be used to anything you have to render, 
  `[%|loc%]Create list[%END%]` may be rewritten as `[% "Create list" |loc %]`.

* The `SET` instruction is optionnal and can use ternary operator. so

~~~{.tt2}
[% IF action == 'create_list_request' %]
   [% SET class = 'MainMenuLinksCurrentPage' %]
[% ELSE %]
   [% SET class = 'MainMenuLinks' %]
[% END %]
~~~

  can be rewritten as

~~~{.tt2}
[% class = action == 'create_list_request'
    ? 'MainMenuLinksCurrentPage'
    : 'MainMenuLinks';
%]
~~~

* closing a template section is not needed as all the TT2 instructions
  can be separated with `;`. so 

~~~{.tt2}
[% IF may_create_list %]
[% class = action == 'create_list_request'
    ? 'MainMenuLinksCurrentPage'
    : 'MainMenuLinks';
%]
[% END %]
~~~

  can be written as

~~~{.tt2}
[% IF may_create_list;
    class = action == 'create_list_request'
	? 'MainMenuLinksCurrentPage'
	: 'MainMenuLinks';
END %]
~~~

Put it all together and the final block is

~~~{.tt2}
[% IF may_create_list;
    class = action == 'create_list_request'
	? 'MainMenuLinksCurrentPage'
	: 'MainMenuLinks';
   %]<li><a class="[% class %]"[% 
   %] href="[% path_cgi %]/create_list_request">[%
   "Create list" | loc;
   %]</a></li>[%
END %]
~~~

more examples to come


