//
//  HudLayer.h
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "CCLayer.h"

typedef enum {power1button, power2button, power3button} powerButton;

@interface HudLayer : CCLayer
{
    int _arrows, money;
    NSMutableArray * buttons;
    double lastHealth;
    CCLabelTTF *label,*label2,*label3;
}
@property int numberOfEnemiesFromStart;
@property int numberOfEnemiesKilled;
@property int numberOfArrowsUsed;

- (NSMutableArray *)buttonsPressed;
- (void)updateArrows;
- (void)updateWallHealth;
- (void)updateMoney:(int)enemyXPosition;
- (void)increaseEnemyCount;
- (void)updateNumberOfEnemiesKilled:(int) killed;
- (int) hasArrows;

@end
