|%
+$  policy
  $?  %liberal
      %fascist
  ==
+$  role
  $?  %liberal
      %fascist
      %hitler
  ==
+$  membership
  $?  %liberal
      %fascist
  ==
+$  vote
  $:  voter=@p
      jn=?
  ==
+$  vitals
  $?  %alive
      %dead
  ==
+$  player
  $:  address=@p
      membership
      role
      vitals
  ==
+$  president  
  $:  address=@p
      nominee=@p
      policies=(list policy)
      veto=?
  ==
+$  chancellor  
  $:  address=@p
      policies=(list policy)
      veto=?
  ==
+$  policies  (list policy)
+$  votes  (list vote)
+$  executive-actions
  $?
      [%investigate]
      [%elect]
      [%peek]
      [%execute]
  ==

+$  round-status  
  $?  %nomination
      %election 
      %legislation 
      %execution
  ==
+$  election-tracker  @ud
::  who is president according to normal turn flow
+$  turn-president   @p
+$  last-president   @p
+$  special-president  @p
+$  last-chancellor  @p
+$  deck     policies
+$  laws     policies
+$  discard  policies
+$  players  (list player)
+$  offices
  $:  =president
      =chancellor
      =votes
  ==

+$  action
  $%  
      [%start addresses=(list @p)]
      :: Election
      [%nominate nominee=@p]
      [%vote =vote]
      :: Legislation
      [%discard =policy]
      [%enact =policy]
      [%veto veto=?]
      :: Execution
      [%investigate player=@p]
      [%election player=@p]
      [%peek ?]
      [%execute player=@p]
  ==

:: +$  update
::   $%  [%start =entry]  :: give roles to the players
::       [%test =id]
::       :: [%del =id]
::       :: [%toggle =id]
::       :: [%rename =id =name]
::       [%initial =entries]
::   ==
--




