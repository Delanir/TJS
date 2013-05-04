//
//  marksmanSubSkillTree.h
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MarksmanSubSkillTree : CCNode {
    CCMenuItem *marksman;
    CCMenuItem *marksmanB1;
    CCMenuItem *marksmanB2;
    CCMenuItem *marksmanB3;
    CCMenuItem *marksmanEl1;
    CCMenuItem *marksmanEl2;
    CCMenuItem *marksmanEl3;
    
    CCSprite *_return;
    
}

- (void) marksmanMainBranch:(id)sender;
- (void) marksmanBranch1:(id)sender;
- (void) marksmanBranch2:(id)sender;
- (void) marksmanBranch3:(id)sender;
- (void) marksmanElement1:(id)sender;
- (void) marksmanElement2:(id)sender;
- (void) marksmanElement3:(id)sender;
- (void) returnS:(id)sender;
- (void) setStars;
@end
