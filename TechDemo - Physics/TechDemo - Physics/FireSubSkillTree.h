//
//  FireSubSkillTree.h
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface FireSubSkillTree : CCNode {
    CCMenuItem *fire;
    CCMenuItem *fireB1;
    CCMenuItem *fireB2;
    CCMenuItem *fireB3;
    CCMenuItem *fireEl1;
    CCMenuItem *fireEl2;
    CCMenuItem *fireEl3;
    
    CCSprite *_return;
    
}

- (void) fireMainBranch:(id)sender;
- (void) fireBranch1:(id)sender;
- (void) fireBranch2:(id)sender;
- (void) fireBranch3:(id)sender;
- (void) fireElement1:(id)sender;
- (void) fireElement2:(id)sender;
- (void) fireElement3:(id)sender;
- (void) returnS:(id)sender;
@end
