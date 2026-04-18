================================================================
Gameplay explained:
- The AI competes against the player in real time for the same
  items on the map
- Items have a danger system: they change color to red after 5
  seconds, then orange after another 5 seconds, and explode
  10 seconds after first turning red
- The AI will not pick up items that are about to explode
- Explosions freeze nearby characters for 5 seconds and play
  a particle effect and sound at the explosion location
- A sound effect plays when an item is successfully dropped
  into the goal area
- Throw items toward the Goal Area to score a point
- A new wave of 10 items spawns every 15 seconds
- Item spawn randomly at start

================================================================
HOW TO PLAY
================================================================

CONTROLS:

  Movement:
    W             - Move Forward
    S             - Move Backward
    A             - Strafe Left
    D             - Strafe Right

  Camera:
    E/Q        - Look Right / Left

  Actions:
    E             - Pick Up nearby item
    T		          - Throw held item
    Space         - Jump

TIPS:
  - Items turn RED then ORANGE before exploding — throw them
    into the goal or drop them before they detonate
  - Standing near an exploding item will freeze you for 5
    seconds — keep your distance
  - The AI will race you to the nearest safe item — move fast


HUD:
  - Player Score  — top left
  - AI Score      — top left below player score
  - Time Left     — counts down from 2 minutes
  - Winner        — displayed at end of match with a
                    Restart button to play again
================================================================
Author: Thanh Cong, Trinh
ID: 041099051
================================================================
Notes:
-The fire when bomb can be changed to another effect as wished
-The sound when bomb may not not suitable, it can be changed as wished
================================================================
For Customization:
-If you want to change the color of item over time go to AMyCollectibleItem::AdvanceDangerState() and assign RGB parameter
DynamicMat->SetVectorParameterValue("Color", FLinearColor(Para1, Para2, Para3));
-If you want to change the effect,sound when item bomb go to Unreal engine and change the variable in My Collectible Item
ExplosionFX : for the effect
ExplosionSound : for the sound
===============================================================
