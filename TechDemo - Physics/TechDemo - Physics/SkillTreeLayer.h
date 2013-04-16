//
//  SkillTreeLayer.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SkillTreeLayer : CCLayer {
    CCSprite *_cityMainBranch;
    CCSprite *_cityElement2;
    CCSprite *_cityElement1;
    CCSprite *_cityElement3;
    CCSprite *_cityBranch3;
    CCSprite *_cityBranch2;
    CCSprite *_cityBranch1;
}
- (void) pressedCitySymbol:(id)sender;
- (void) pressedMainMenu:(id)sender;
@end
