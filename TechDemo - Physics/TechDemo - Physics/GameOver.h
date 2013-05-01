//
//  GameOver.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"

@interface GameOver : CCNode
{
    CCSprite * _mainMenuButton;
}

-(CGPoint) mainMenuButtonPosition;
-(float) mainMenuButtonRadius;

@end
