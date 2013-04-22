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
    CCLabelTTF *label,*label2,*label3;
}

- (NSMutableArray *)buttonsPressed;
- (void)updateArrows;
- (void)updateWallHealth;
- (void)updateMoney:(int)enemyXPosition;
- (void)updateData;

@end
