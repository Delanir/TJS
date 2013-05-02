//
//  FireSubSkillTree.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FireSubSkillTree.h"
#import "SkillTreeLayer.h"


@implementation FireSubSkillTree


- (void) fireMainBranch:(id)sender{
    [((SkillTreeLayer *)[self parent]) pressedIceSymbol:self];
    [fire setIsEnabled:NO];
};
- (void) fireBranch1:(id)sender{
    if (![fire isEnabled]) {
        [fireB1 setIsEnabled:NO];
    }
};
- (void) fireBranch2:(id)sender{
    if (![fire isEnabled]) {
        [fireB2 setIsEnabled:NO];
    }
};
- (void) fireBranch3:(id)sender{
    if (![fire isEnabled]) {
        [fireB3 setIsEnabled:NO];
    }
};
- (void) fireElement1:(id)sender{
    if (![fireB1 isEnabled]) {
        [fireEl1 setIsEnabled:NO];
    }
};
- (void) fireElement2:(id)sender{
    if (![fireB2 isEnabled]) {
        [fireEl2 setIsEnabled:NO];
    }
};
- (void) fireElement3:(id)sender{
    
    if (![fireB3 isEnabled]) {
        [fireEl3 setIsEnabled:NO];
    }
};

- (void) returnS:(id)sender{
    [self setVisible:NO];
};








@end
