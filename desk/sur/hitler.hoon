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
  $?  %ja
      %nein
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
      policies=(list @p)
      veto=?
  ==
+$  chancellor  
  $:  address=@p
      policies=(list @p)
      veto=?
  ==
+$  policies  (list policy)

+$  round-status  
  $?  %election 
      %legislation 
      %execution
  ==
+$  election-tracker  @ud
+$  next-president   @p
+$  last-president   @p
+$  last-chancellor  @p
+$  deck     policies
+$  laws     policies
+$  discard  policies
+$  players  (list player)
+$  offices
  $:  =president
      =chancellor
      votes=(list ?)
  ==

+$  action
  $%  
      [%start addresses=(list @p)]
      :: :: Election
      [%nominate ?]
      :: [%vote ?]
      :: :: Legislation
      :: [%discard]
      :: [%enact]
      :: [%veto]
      :: :: Execution
      :: [%investigate]
      :: [%elect]
      :: [%peek]
      :: [%execute]
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




:: +$  presidential-powers
::   $:
::       [%1 %investigate]
::       [%2 %elect]
::       [%3 %peek]
::       [%4 %execute]
::       [%5 %execute]
::   ==
