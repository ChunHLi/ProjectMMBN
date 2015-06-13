ProjectMMBN
=========================================================================================================================
APCS Final Project Term 2;

Megaman Battle Network Virus Battle Simulator;

Working version as of 06-01-2015 is in branch called "06-01-2015"
Working version as of 06-08-2015 is in branch called "06-08-2015"

How to Use
=========================================================================================================================
After running the game, you will be promted to choose between "Tutorial" and "Protoman". Use your mouse to select one. 
Tutorial will be a battle against the virus Mettaur. You will have a relatively weak folder.
Protoman will be a battle against the navi Protoman. You will have a strong folder.

Controls

In battle
- Arrow keys to move around
- 'x' to use buster
  - hold 'x' to charge buster, when it turns purple, buster does 10x damage
- 'z' to use your next battle chip
- 'a' or 's' to open up custom menu to select new chips when custom bar is full
- 'enter' to pause the game

In Custom Menu
- Arrow keys to navigate around
- 'q' to shuffle the chips you can choose from
- 'z' to select a chip
- 'x' to deselect a chip
- 'enter' to resume battle

Mechanics
- Megaman can only be on the red panels.
- Custom menu can only be accessed when the custom bar is full.
- In custom menu, you can only select chips that are the same or have the same letter. '*' can go with any letter.
- If you have not used all selected chips during battle, and you select new chips in the custom menu, the old chips will
  be gone. However, if you open the custom menu, but do not select any new chips, the old ones will remain.
- Chips in battle are in a queue. The first chip selected is the first chip used.
- Some combinations of three chips will give you a Program Advance (PA).
  - PAs are essentially super-mega-OP chips.
  - The chips MUST be in the correct order to work.
  - The three chips will be removed and replaced with the PA.

Program Advances
Sword -> Wide Sword -> Long Sword = Life Sword
Cannon -> Cannon -> Cannon = Giga Cannon
Spreader J -> Spreader K -> Spreader L = HiSpreader
Sword -> Wide Blade -> Long Blade = Life Sword
Wide Blade -> Long Blade -> ProtomanSP = Double Hero
Protoman -> Anti Navi -> ColonelSP = Twin Leaders


Change - Log
=========================================================================================================================
5/20/15 - Kah Soon Yap - Made the proposal and printed it out.

5/20/15 - Shawn Li - Imported sprites and decomposed some of them.

5/21/15 - Shawn Li - Created Change Log readme.

5/21/15 - Kah Soon Yap - Created very basic methods for Megaman, Mettaur, and Panels. Created Killable interface.

5/22/15 - Shawn Li - Created animation class. Megaman is animated!

5/22/15 - Shawn Li - Grid made!

5/22/15 - Shawn Li - Panels class corrected to accomodate specified protocols.

5/23/15 - Shawn Li - Movement is done! Animations are correctly applied.

5/23/15 - Shawn Li - Looping background made. Matrix 8D.

5/23/15 - Shawn Li - chip class created, chipMenu created. Modes are implemented but not perfected.

5/23/15 - Kah Soon Yap - Buster is done. One small bug. Will add in the damage once viruses are implimented.

5/23/15 - Kah Soon Yap - Megabuster is done. Charging animation moves along with Megaman. Make charge time longer?

5/24/15 - Kah Soon Yap - Charge time is now longer.

5/24/15 - Kah Soon Yap - Mettaur is animated.

5/24/15 - Kah Soon Yap - Mettaur has a very simple AI. Mettaur attack doesn't work.

5/24/15 - Kah Soon Yap - Buster hurts Mettaur.

5/24/15 - Kah Soon Yap - HP now shows at top left corner and below Mettaur.

5/24/15 - Shawn Li - Chip selection window now appears! And disappears! And REappears!

5/25/15 - Shawn Li - Custom Bar animation and implementation of methods completed.

5/25/15 - Shawn Li - Listen to that glorious music Kreygasm

5/25/15 - Kah Soon Yap - Slashing done

5/25/15 - Kah Soon Yap - Mettaur now attacks, but no waves appear and does no damage

5/25/15 - Kah Soon Yap - Delayed animation now works

5/26/15 - Shawn Li - Added ChipFolder.

5/26/15 - Kah Soon Yap - Added newbie Chip Folder.

5/26/15 - Kah Soon Yap - Worked on sword animations. Very buggy.

5/27/15 - Kah Soon Yap - Smoothed out sword animation. Better now, but still some problems.

5/27/15 - Kah Soon Yap - Cannon made, no damage yet. Small error in animation.

5/27/15 - Kah Soon Yap - Added elemental Chip Folder

5/27/15 - Shawn Li - Added virusAttack, enemy projectiles are a seperate class due to the fact many issues could come up otherwise.

5/27/15 - Shawn Li - Added Mettaur's wave attack.

5/28/15 - Kah Soon Yap - Cleaned up folders

5/28/15 - Kah Soon Yap - Cleaned up chip animations. Much smoother now.

5/28/15 - Kah Soon Yap - Lifesword animation done.

5/28/15 - Shawn Li - added panel flashing.

5/29/15 - Shawn Li - added megaman hurt animation and invincibility.

5/30/15 - Shawn Li - chips now display on the Custom Menu!!!!

5/30/15 - Kah Soon Yap - Replaced all sword animations. Nothing buggy now.

5/30/15 - Kah Soon Yap - Animations for spreader

5/30/15 - Kah Soon Yap - Animations for throwing bomb.

5/31/15 - Kah Soon Yap - Spread does damage.

5/31/15 - Kah Soon Yap - Bomb flies, but it's flight is linear not parabolic.

5/31/15 - Shawn Li - display for customMenu.

6/01/15 - Kah Soon Yap - Created branch for working version

6/01/15 - Kah Soon Yap - Fixed bomb flight. It is now parabolic.

6/01/15 - Kah Soon Yap - Bomb now does damage.

6/01/15 - Shawn Li - Chips can now be selected.

6/01/15 - Shawn Li - Chips now display correctly according to Chip selection system.

6/02/15 - Kah Soon Yap - Cannon hit animations done

6/02/15 - Kah Soon Yap - Bomb explosion done

6/02/15 - Kah Soon Yap - Buster hit animations done

6/02/15 - Kah Soon Yap - Spreader hit animation works (kinda)

6/02/15 - Kah Soon Yap - Vulcan animation and damage works. Need to find hit animation.

6/02/15 - Kah Soon Yap - Guard animation works. Need to time perfectly to counter. Wave is glitchy.

6/02/15 - Shawn Li - Everything is coming along just fine, bugs being fixed, etc.

6/03/15 - Kah Soon Yap - Recover is done. Heals.

6/03/15 - Kah Soon Yap - Invisible is glitchy atm.

6/03/15 - Shawn Li - Chips now display during battle as well.

6/03/15 - Shawn Li - Chips now activate when A/Z is pressed.

6/03/15 - Kah Soon Yap - Barrier works

6/03/15 - Shawn Li - Protoman sprites have been fixed.

6/04/15 - Kah Soon Yap - Stepsword done

6/04/15 - Kah Soon Yap - Firehit done

6/04/15 - Kah Soon Yap - Protoman chip done

6/04/15 - Kah Soon Yap - Colonel chip done

6/04/15 - Kah Soon Yap - Danger properly resets now

6/04/15 - Shawn Li - Protoman now moves at the right timing.

6/04/15 - Shawn Li - Protoman's sequence has been completed.

6/05/15 - Kah Soon Yap - Fixed up Protoman animation

6/05/15 - Shawn Li - Protoman's attacks now display correctly.

6/05/15 - Kah Soon Yap - Protoman's HP shows

6/06/15 - Kah Soon Yap - Battle start animation done

6/06/15 - Kah Soon Yap - Boomer done

6/06/15 - Shawn Li - Program Advances work correctly.

6/07/15 - Shawn Li - Battle start animation works.

6/07/15 - Kah Soon Yap - Gigacannon and Hispread PAs done

6/07/15 - Kah Soon Yap - Adjusted number on chips

6/07/15 - Kah Soon Yap - Sword folder implemented

6/08/15 - Shawn Li & Kah Soon Yap - Mental health day, burned out.

6/09/15 - Shawn Li - Created the menu, can choose between two types of battles.

6/09/15 - Kah Soon Yap - Double hero PA created and bound

6/10/15 - Shawn Li & Kah Soon Yap - Fixed guard bug and increased reflecting frames

6/11/15 - Kah Soon Yap - Twin leader PA created and bound.

6/12/15 - Shawn Li & Kah Soon Yap - Fixed invisible bug





To do
=========================================================================================================================

- For Shawn (due 6/4/15) - Make progress on Bass AI.
- For Kah Soon (due 6/4/15) - Get most of the animations of the second folder's chips done.
- For Kah Soon (due 6/4/15) - Fix animations for old chips.
- For Shawn (due 6/4/15) - Program the program advance method.

Future major goals (pre June 8th):
1. Shawn:
  a. Show danger for Protoman's slashes. (due Friday) (COMPLETED)
  b. Damage Protoman. (due Friday) (COMPLETED)
  c. Protoman's special attack. (due Saturday)
  d. Program Advances. (due Saturday)
  e. transition. (due Sunday)
  f. beautification.

2. Kah Soon:
  a. Protoman's slash frames. (due Friday)
  b. Chip animations. (due Saturday)
  c. Protoman's HP. (due Friday)
  d. Battle Start. (due Saturday)
  e. beautification.
  f. Crosses. (optional).

Future major goals (pre June 15th):
1. Finish 3rd folder.
2. Finish Protoman AI.
3. Finish rest of crosses.
4. Add more sound effects.
5. Beautify the stuff.
