//
//  iceSubSkillTree.h
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface IceSubSkillTree : CCNode {
    CCMenuItem *ice;
    CCMenuItem *iceB1;
    CCMenuItem *iceB2;
    CCMenuItem *iceB3;
    CCMenuItem *iceEl1;
    CCMenuItem *iceEl2;
    CCMenuItem *iceEl3;
    
    CCSprite *_return;
    
}

- (void) iceMainBranch:(id)sender;
- (void) iceBranch1:(id)sender;
- (void) iceBranch2:(id)sender;
- (void) iceBranch3:(id)sender;
- (void) iceElement1:(id)sender;
- (void) iceElement2:(id)sender;
- (void) iceElement3:(id)sender;
- (void) returnS:(id)sender;
- (void) setStars;
@end
