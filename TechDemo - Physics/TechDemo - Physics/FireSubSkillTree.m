//
//  FireSubSkillTree.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FireSubSkillTree.h"
#import "SkillTreeLayer.h"
#import "GameState.h"
#import "Constants.h"




@implementation FireSubSkillTree

- (void) setStars{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    int index;
    for (int i=14; i<21; i++)
    {
        index = [[skill objectAtIndex:i] intValue];
        switch (i)
        {
            case 14:
                if (index!=0)
                    [fire setIsEnabled:NO]; else [fire  setIsEnabled:YES]; 
                break;
            case 15:
                if (index!=0)
                    [fireEl2 setIsEnabled:NO]; else  [fireEl2 setIsEnabled:YES]; 
                break;
            case 16:
                if (index!=0)
                    [fireEl1 setIsEnabled:NO]; else [fireEl1 setIsEnabled:YES]; 
                break;
            case 17:
                if (index!=0)
                    [fireEl3 setIsEnabled:NO]; else [fireEl3 setIsEnabled:YES]; 
                break;
            case 18:
                if (index!=0)
                    [fireB3 setIsEnabled:NO]; else  [fireB3 setIsEnabled:YES]; 
                break;
            case 19:
                if (index!=0)
                    [fireB2 setIsEnabled:NO]; else   [fireB2 setIsEnabled:YES]; 
                break;
            case 20:
                if (index!=0) 
                    [fireB1 setIsEnabled:NO]; else  [fireB1 setIsEnabled:YES]; 
                break;
            default:
                break;
        }
    }
    
}



- (void) fireMainBranch:(id)sender{
    
    if ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST1) {
        [((SkillTreeLayer *)[self parent]) switchFire:14 withStarCost:STARCOST1];
        [fire setIsEnabled:NO];
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST1];
        [[GameState shared] saveApplicationData];
    }
    
};
- (void) fireBranch1:(id)sender{
    if (![fire isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchFire:20 withStarCost:STARCOST2];
        [fireB1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) fireBranch2:(id)sender{
    if (![fire isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchFire:19 withStarCost:STARCOST2];
        [fireB2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) fireBranch3:(id)sender{
    if (![fire isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchFire:18 withStarCost:STARCOST2];
        [fireB3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) fireElement1:(id)sender{
    if (![fireB1 isEnabled] &&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchFire:16 withStarCost:STARCOST3];
        [fireEl1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) fireElement2:(id)sender{
    if (![fireB2 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchFire:15 withStarCost:STARCOST3];
        [fireEl2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) fireElement3:(id)sender{
    
    if (![fireB3 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchFire:17 withStarCost:STARCOST3];
        [fireEl3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};




- (void) returnS:(id)sender{
    [self setVisible:NO];
};








@end
