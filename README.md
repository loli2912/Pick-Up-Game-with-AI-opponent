# CongLABA2 - Item Collector

**Author:** Thanh Cong, Trinh
**ID:** 041099051
**Implementation:** 100% MAX GRADE VERSION

---

## Gameplay

- The AI competes against the player in real time for the same items on the map
- Items have a danger system: they change color to red after 5 seconds, then orange after another 5 seconds, and explode 10 seconds after first turning red
- The AI will not pick up items that are about to explode
- Explosions freeze nearby characters for 5 seconds and play a particle effect and sound at the explosion location
- A sound effect plays when an item is successfully dropped into the goal area
- Throw items toward the Goal Area to score a point
- A new wave of 10 items spawns every 15 seconds
- Items spawn randomly at start

---

## How To Play

### Controls

| Action | Key |
|--------|-----|
| Move Forward | W |
| Move Backward | S |
| Strafe Left | A |
| Strafe Right | D |
| Look Right / Left | E / Q |
| Pick Up nearby item | E |
| Throw held item | T |
| Jump | Space |

### Tips

- Items turn RED then ORANGE before exploding — throw them into the goal or drop them before they detonate
- Standing near an exploding item will freeze you for 5 seconds — keep your distance
- The AI will race you to the nearest safe item — move fast

---

## HUD

| Element | Location |
|---------|----------|
| Player Score | Top left |
| AI Score | Below player score |
| Time Left | Counts down from 2 minutes |
| Winner | Displayed at end of match with a Restart button |

---

## Notes

- The fire effect when an item explodes can be changed to another effect as wished
- The explosion sound may not be suitable, it can be changed as wished

---

## Customization

**Change item color over time:**
Go to AMyCollectibleItem::AdvanceDangerState() and assign the RGB parameter:

DynamicMat->SetVectorParameterValue("Color", FLinearColor(Para1, Para2, Para3));

**Change explosion effect and sound:**
Open the Blueprint BP_MyCollectibleItem in Unreal Engine and change the following variables:

| Variable | Description |
|----------|-------------|
| ExplosionFX | The particle effect played on explosion |
| ExplosionSound | The sound played on explosion |
