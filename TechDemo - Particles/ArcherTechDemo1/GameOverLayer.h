//
//  GameOverLayer.h
//  L'Archer D'Amiens Tech Demo Particle System Testing (LADA)
//
//  Created by Joao Amaral on 17/03/2013.
//  Copyright NightOwl Studios 2013. All rights reserved.
//

#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor

+(CCScene *) sceneWithWon:(BOOL)won;
- (id)initWithWon:(BOOL)won;

@end
