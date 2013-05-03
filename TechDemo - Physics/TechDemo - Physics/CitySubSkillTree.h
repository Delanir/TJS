//
//  citySubSkillTree.h
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CitySubSkillTree : CCNode {
    CCMenuItem *city;
    CCMenuItem *cityB1;
    CCMenuItem *cityB2;
    CCMenuItem *cityB3;
    CCMenuItem *cityEl1;
    CCMenuItem *cityEl2;
    CCMenuItem *cityEl3;
    
    CCSprite *_return;
    
}

- (void) cityMainBranch:(id)sender;
- (void) cityBranch1:(id)sender;
- (void) cityBranch2:(id)sender;
- (void) cityBranch3:(id)sender;
- (void) cityElement1:(id)sender;
- (void) cityElement2:(id)sender;
- (void) cityElement3:(id)sender;
- (void) returnS:(id)sender;
- (void) setStars;
@end
