notes a récurerer sur le serveur

[% IF may_create_list %]
   [% IF action == 'create_list_request' %][% SET class = 'MainMenuLinksCurrentPage' %][% ELSE %][% SET class = 'MainMenuLinks' %][% END %]<li><a class="[% class %]" href="[% path_cgi %]/create_list_request" >[%|loc%]Create list[%END%]</a></li>
[% END %] 

devient:

[% IF may_create_list;
    IF action == 'create_list_request';
        SET class = 'MainMenuLinksCurrentPage';
    ELSE;
        SET class = 'MainMenuLinks';
    END %]<li><a class="[% class %]" href="[% path_cgi %]/create_list_request" >[%|loc%]Create list[%END%]</a></li>
[% END %] 

* [%|loc%]A text[%END%] peut etre écrit [% "A text" | loc %]   
* SET class = 'MainMenuLinksCurrentPage' ( le SET est facultatif)  
* class = 'MainMenuLinksCurrentPage' 


[% IF may_create_list;
    IF action == 'create_list_request';
        class = 'MainMenuLinksCurrentPage';
    ELSE;
        class = 'MainMenuLinks';
    END %]<li><a class="[% class %]" href="[% path_cgi %]/create_list_request"
    >[% "Create list"|loc %]</a></li>
[% END %] 

* use of ternary operator

[% IF may_create_list;
    %]<li><a class="[% action == 'create_list_request' ?  'MainMenuLinksCurrentPage' : 'MainMenuLinks' %]" href="[% path_cgi %]/create_list_request" >[% "Create list"|loc %]</a></li>
[% END %] 


[% IF may_create_list;
    class = action == 'create_list_request' ?  'MainMenuLinksCurrentPage' : 'MainMenuLinks';
    END %]<li><a class="[% class %]" href="[% path_cgi %]/create_list_request" >[%|loc%]Create list[%END%]</a></li>
[% END %]





