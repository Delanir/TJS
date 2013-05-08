//
//  HudLayer.h
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "CCLayer.h"
#import "Wall.h"
#import "Registry.h"
#import "ResourceManager.h"
#import "Constants.h"
#import "GameState.h"

@interface Hud : CCLayer
{
    int money;
    NSMutableArray * buttons;
    double lastHealth, lastMana;
    CCLabelTTF *label1, *label2;
    CCProgressTimer * manaProgress, * healthProgress;
    CCMenuItemToggle *fireToggleButton, *iceToggleButton, *pushBackToggleButton;
}

@property (nonatomic, retain) CCMenuItemToggle * fireToggleButton;
@property (nonatomic, retain) CCMenuItemToggle * iceToggleButton;
@property (nonatomic, retain) CCMenuItemToggle * pushBackToggleButton;

-(void) setFireToggleButtonActive;
-(void) setIceToggleButtonActive;
-(void) setPushbackToggleButtonActive;

- (NSMutableArray *)buttonsPressed;
- (void)updateArrows;
- (void)updateMoney;
- (void)updateWallHealth;
- (void)updateMana;
- (void)updateHUD;

@end
