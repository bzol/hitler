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
      =turn-president:hitler
      =last-president:hitler
      :: TODO change this variable to unit type
      =special-president:hitler
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
      ?>  =(src.bowl our.bowl)
      :_  %=  state  
          round-status  %nomination
          election-tracker  0
          turn-president  -.addresses.action
          deck  (shuffle create-deck eny.bowl)
          players  (set-players (shuffle-addresses addresses.action eny.bowl))
          offices  [[turn-president turn-president ~ %.n] [turn-president ~ %.n] ~]
          ==
      ~
        ::
        %nominate
      =/  new-state  state
      =/  next-president  turn-president
      =?  next-president  =(special-president ~)  special-president
      ::
      ::?>  (nominate-permitted round-status next-president president
      ::chancellor players.state src.bowl)
      ::::
      =.  address.president.offices.new-state  next-president
      =.  nominee.president.offices.new-state  nominee.action
      =.  last-president.new-state  address.president.offices.state
      =.  round-status.new-state  %election
      =?  deck.new-state  (lth (lent deck.state) 3)  (shuffle discard.state eny.bowl)
      =?  discard.new-state  (lth (lent deck.state) 3)  ~
      =?  turn-president.new-state  =(next-president turn-president)  
        (find-next-president turn-president.state players.state)
      :_  new-state
      ~
        ::
        %vote
      ?>  (vote-permitted round-status.state vote.action)
      ::
      =/  new-state  state
      ?.  (majority-reached votes.offices.new-state)
        =.  votes.offices.new-state  (snoc votes.offices.state vote.action)
        :_  new-state
        ~
      ?:  (chancellor-elected votes.offices.new-state)
        =.  address.chancellor.offices.new-state  nominee.president.offices
        =.  policies.president.offices.new-state  (fetch3cards deck.new-state)
        =.  deck.new-state  (delete3cards deck.new-state)
        =.  round-status.new-state  %legislation
        :_  new-state
        ~
      ?:  =(election-tracker.new-state 3)
        =.  election-tracker.new-state  0
        =.  laws.new-state  (snoc laws.new-state -.deck.new-state)
        =.  votes.offices.new-state  ~
        =.  round-status.new-state  %nomination
        :_  new-state
        ~
      =.  election-tracker.new-state  (add election-tracker.new-state 1)
      =.  votes.offices.new-state  ~
      =.  round-status.new-state  %nomination
      :_  new-state
      ~
        %discard
      :: ?>  discard-permitted
      ::
      =/  new-state  state
      =/  president-policies  policies.president.offices.new-state
      =.  policies.president.offices.new-state  ~
      =.  discard.new-state  (snoc discard.state policy.action)
      =.  policies.chancellor.offices.new-state  
      (oust [-:(fand ~[policy.action] ~) 1] president-policies)
      :_  new-state
      ~
        %enact
      :: ?>  enact-permitted
      =/  new-state  state
      =/  chancellor-policies  policies.chancellor.offices.new-state
      =.  policies.chancellor.offices.new-state  ~
      =.  laws.new-state  (snoc laws.state policy.action)
      =.  discard.new-state
      (snoc discard.state -:(oust [-:(fand ~[policy.action] ~) 1] chancellor-policies))
      =.  round-status.new-state  %execution
      :_  state
      ~
        %veto
      :: ?>  veto-permitted
      ::
      =/  new-state  state
      ~&  src.bowl
      =?    veto.president.offices.new-state  
          =(src.bowl address.president.offices.new-state)  
        veto.action
      =?    veto.president.offices.new-state  
          =(src.bowl address.chancellor.offices.new-state)  
        veto.action
      =/  president  president.offices.new-state
      =/  chancellor  chancellor.offices.new-state
      ?:  (both-vetoed laws president chancellor)
        =.  round-status.new-state  %nomination
        :_  new-state
        ~
      :_  new-state
      ~
        %investigate
      ?>  (execution-allowed src.bowl address.president.offices.state laws %investigate)
      ::
      =/  new-state  state
      ~&  player.action  :: return party membership of player
      =.  round-status.new-state  %nomination
      :_  new-state
      ~
        %election
      ?>  (execution-allowed src.bowl address.president.offices.state laws %elect)
      ::
      =/  new-state  state
      =.  special-president.new-state  player.action
      =.  round-status.new-state  %nomination
      :_  new-state
      ~
        %peek
      ?>  (execution-allowed src.bowl address.president.offices.state laws %peek)
      ::
      =/  new-state  state
      =.  round-status.new-state  %nomination
      ~&  laws.new-state  :: return top 3 cards
      :_  new-state
      ~
        %execute
      ?>  (execution-allowed src.bowl address.president.offices.state laws %execute)
      ::
      =/  new-state  state
      =.  players.new-state  (kill-player player.action players.state)
      =.  round-status.new-state  %nomination
      :_  new-state
      ~
    ==
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
::::::  Start  ::::::
++  shuffle-addresses 
    |=  [addresses=(list @p) eny=@uvJ]
    addresses
++  create-deck  
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
::::::  Nominate  ::::::
:: TODO
++  shuffle
  |=  [=policies:hitler eny=@uvJ]
  policies
:: TODO check whether poker has permission to nominate a given
:: player (is he president + is nominee eligible for
:: chancellorship (check alive status as well))
++  nominate-permitted  
  |=  [=round-status:hitler =last-president:hitler =last-chancellor:hitler =players:hitler]
  %.y
++  find-next-president  
  |=  [=turn-president:hitler =players:hitler]
  =*  alive-filter  |=  =player:hitler 
    ?:  =(+>+.player %alive)
      player
    %.n
  =/  alive-players  (turn players alive-filter)
  :: TODO cycle to next-president
  ~zod
::::::  Vote  ::::::
:: check if vote not exists and sender and vote @p is the same
:: check for alive status
:: TODO
++  vote-permitted  
  |=  [=round-status:hitler =vote:hitler]  %.y
:: TODO
++  majority-reached     |=  votes:hitler  %.y
:: TODO
++  chancellor-elected     |=  votes:hitler  %.y
++  fetch3cards      
  |=  =policies:hitler  
  (scag 3 policies)
++  delete3cards     
  |=  =policies:hitler  
  (oust [0 3] policies)
::::::  Veto     ::::::
:: ?: if both veto true, and there are 5 fascist policies, then
:: veto
:: TODO
++  both-vetoed     
  |=  [=laws:hitler =president:hitler =chancellor:hitler]  
  %.y
::::::  Executions     ::::::
:: TODO
++  execution-allowed 
  |=  [src=@p president=@p =laws:hitler =executive-actions:hitler]
    %.y
:: Dead people can't be killed again!!!
:: TODO
++  kill-player
  |=  [player=@p =players:hitler]
    players
--
