//
//  HudLayer.h
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "CCLayer.h"

@interface HudLayer : CCLayer
{
    int buttons, _arrows, money;
    double lastHealth;
    CCLabelTTF *label,*label2,*label3;
}

- (void)plusButtonTapped:(id)sender;
- (void)crossButtonTapped:(id)sender;
- (void)bullseyeButtonTapped:(id)sender;
- (int)buttonPressed;
- (void)updateArrows;
- (void)updateWallHealth;
- (void)updateMoney:(int)enemyXPosition;

@end
