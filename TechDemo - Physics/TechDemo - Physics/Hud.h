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

@interface Hud : CCLayer
{
    int money;
    NSMutableArray * buttons;
    double lastHealth;
    CCLabelTTF *label1, *label2;
    CCProgressTimer * manaProgress, * healthProgress;
}

- (NSMutableArray *)buttonsPressed;
- (void)updateArrows;
- (void)updateMoney;
- (void)updateWallHealth;

@end
