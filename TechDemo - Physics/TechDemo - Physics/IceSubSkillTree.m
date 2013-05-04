//
//  iceSubSkillTree.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "IceSubSkillTree.h"
#import "SkillTreeLayer.h"
#import "GameState.h"

#import "Constants.h"


@implementation IceSubSkillTree

- (void) setStars{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    int index;
    for (int i=0; i<7; i++) {
        index = [[skill objectAtIndex:i] intValue];
        switch (i) {
            case 0:
                if (index!=0) {
                    [ice setIsEnabled:NO];
                }
                
                break;
            case 1:
                if (index!=0) 
                [iceEl2 setIsEnabled:NO];
                
                break;
            case 2:
                if (index!=0) 
                [iceEl1 setIsEnabled:NO];
                break;
            case 3:
                if (index!=0) 
                [iceEl3 setIsEnabled:NO];
                break;
            case 4:
                if (index!=0) 
                [iceB3 setIsEnabled:NO];
                break;
            case 5:
                if (index!=0) 
                [iceB2 setIsEnabled:NO];
                break;
            case 6:
                if (index!=0)
                [iceB1 setIsEnabled:NO];
                break;
            default:
                break;
        }
    }
    
}



- (void) iceMainBranch:(id)sender{
    
    if ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST1) {
        [((SkillTreeLayer *)[self parent]) switchIce:0 withStarCost:STARCOST1];
        [ice setIsEnabled:NO];
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST1];
        [[GameState shared] saveApplicationData];
    }
    
};
- (void) iceBranch1:(id)sender{
    if (![ice isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchIce:6 withStarCost:STARCOST2];
        [iceB1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) iceBranch2:(id)sender{
    if (![ice isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchIce:5 withStarCost:STARCOST2];
        [iceB2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) iceBranch3:(id)sender{
    if (![ice isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchIce:4 withStarCost:STARCOST2];
        [iceB3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) iceElement1:(id)sender{
    if (![iceB1 isEnabled] &&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchIce:2 withStarCost:STARCOST3];
        [iceEl1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) iceElement2:(id)sender{
    if (![iceB2 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchIce:1 withStarCost:STARCOST3];
        [iceEl2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) iceElement3:(id)sender{
    
    if (![iceB3 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchIce:3 withStarCost:STARCOST3];
        [iceEl3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};




- (void) returnS:(id)sender{
    [self setVisible:NO];
};








@end
