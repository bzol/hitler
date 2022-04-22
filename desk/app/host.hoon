/-  hitler
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  
  $:  %0
      =round-status:hitler
      =election-tracker:hitler
      =next-president:hitler
      =last-president:hitler
      =last-chancellor:hitler
      =deck:hitler
      =laws:hitler
      =discard:hitler
      =players:hitler
      =offices:hitler
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)

::
++  on-init
  ^-  (quip card _this)
  `this
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==

++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ::  TODO crash if not our ship initiates or players initiates
  ?>  =(src.bowl our.bowl)
  ?+    mark  (on-poke:def mark vase)
      %hitler-action
    =^  cards  state
      (handle-poke !<(action:hitler vase))
    [cards this]
  ==
  ++  handle-poke
    |=  =action:hitler
    ^-  (quip card _state)
    ?-    -.action
        %start
      :_  %=  state  
          round-status  %election
          election-tracker  0
          next-president  -.addresses.action
          deck  (create-deck eny.bowl)
          :: players  (set-players (shuffle-addresses addresses.action))
          players  (set-players addresses.action)
          offices  [[next-president ~ %.n] [next-president ~ %.n] ~]
          ==
      ~
      :: :~  
          :: :*  %give  %fact  ~[/updates]  %hitler-update
          ::     !>(`update:org`[%add nextid entry.action])
          :: ==
      :: ==
        %nominate
      [~ state]
      :: start:hc
    ==
      :: :_  
      ::     %=  state  
      ::     election-tracker  13
      ::     :: next-president    ~zod
      ::     ==
      :: :~  
      ::     :: :*  %give  %fact  ~[/updates]  %hitler-update
      ::     ::     !>(`update:org`[%add nextid entry.action])
      ::     :: ==
      ::     ~
      :: ==
      ::   %nominate
      :: :_  %=  state  
      ::     election-tracker  19
      ::     ==
      :: :~  
      ::     :: :*  %give  %fact  ~[/updates]  %hitler-update
      ::     ::     !>(`update:org`[%add nextid entry.action])
      ::     :: ==
      ::     ~
      :: ==
    :: ==
  --

++  on-watch  on-watch:def
  :: |=  =path
  :: ^-  (quip card _this)
  :: ?+    path  (on-watch:def path)
  ::     [%updates ~]
  ::   ?>  =(src.bowl our.bowl)
  ::   :_  this
  ::   :~  [%give %fact ~ %org-update !>(`update:org`initial+entries)]
  ::   ==
  :: ==
::
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--

|% 
:: TODO
++  shuffle-deck
  |=  =policies:hitler
  policies
:: TODO
++  shuffle-addresses 
    |=  [addresses=(list @p) eny=@uvJ]
    addresses
++  create-deck  
  |=  eny=@uvJ
  %-  shuffle-deck
  :~  %liberal
      %liberal
      %liberal
      %liberal
      %liberal
      %liberal
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
      %fascist
  ==
++  set-players  
  =<
  |=  addresses=(list @p)
  ?+  (lent addresses)  !!
    %5   (generate-players addresses 3)
    %6   (generate-players addresses 4)
    %7   (generate-players addresses 4)
    %8   (generate-players addresses 5)
    %9   (generate-players addresses 5)
    %10  (generate-players addresses 6)
  ==
  ::
  |_  [=membership:hitler =role:hitler]
  ++  set-liberal
    |=  [address=@p]
    ^-  player:hitler
    [address %liberal %liberal %alive]
  ++  set-fascist
    |=  [address=@p]
    ^-  player:hitler
    [address %fascist %fascist %alive]
  ++  generate-players
    |=  [addresses=(list @p) liberal-count=@ud]
    =/  no-hitler-addresses  (snip addresses)
    =/  hitler-address  -.addresses
    =/  fascist-count  (sub (lent no-hitler-addresses) liberal-count)
    %+  weld  [[hitler-address %fascist %hitler %alive] ~]
    %+  weld  (turn (oust [liberal-count fascist-count] no-hitler-addresses) set-liberal)
    (turn (oust [0 liberal-count] no-hitler-addresses) set-fascist)
  --
--
