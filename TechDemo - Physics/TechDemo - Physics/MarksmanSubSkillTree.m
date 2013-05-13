//
//  marksmanSubSkillTree.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "marksmanSubSkillTree.h"
#import "SkillTreeLayer.h"
#import "GameState.h"

#import "Constants.h"


@implementation MarksmanSubSkillTree

- (void) setStars{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    int index;
    for (int i=21; i<28; i++) {
        index = [[skill objectAtIndex:i] intValue];
        switch (i) {
            case 21:
                if (index!=0)
                    [marksman setIsEnabled:NO]; else [marksman setIsEnabled:YES];  
                
                
                break;
            case 22:
                if (index!=0) 
                [marksmanEl2 setIsEnabled:NO]; else [marksmanEl2  setIsEnabled:YES];                  
                break;
            case 23:
                if (index!=0) 
                [marksmanEl1 setIsEnabled:NO]; else [marksmanEl1 setIsEnabled:YES]; 
                break;
            case 24:
                if (index!=0) 
                [marksmanEl3 setIsEnabled:NO]; else [marksmanEl3  setIsEnabled:YES]; 
                break;
            case 25:
                if (index!=0) 
                [marksmanB3 setIsEnabled:NO]; else [marksmanB3 setIsEnabled:YES]; 
                break;
            case 26:
                if (index!=0) 
                [marksmanB2 setIsEnabled:NO]; else [marksmanB2 setIsEnabled:YES]; 
                break;
            case 27:
                if (index!=0)
                [marksmanB1 setIsEnabled:NO]; else [marksmanB1  setIsEnabled:YES];
                break;
            default:
                break;
        }
    }
    
}



- (void) marksmanMainBranch:(id)sender{
    
    if ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST1) {
        [((SkillTreeLayer *)[self parent]) switchMarksman:21 withStarCost:STARCOST1];
        [marksman setIsEnabled:NO];
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST1];
        [[GameState shared] saveApplicationData];
    }
    
};
- (void) marksmanBranch1:(id)sender{
    if (![marksman isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchMarksman:27 withStarCost:STARCOST2];
        [marksmanB1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) marksmanBranch2:(id)sender{
    if (![marksman isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchMarksman:26 withStarCost:STARCOST2];
        [marksmanB2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) marksmanBranch3:(id)sender{
    if (![marksman isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchMarksman:25 withStarCost:STARCOST2];
        [marksmanB3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) marksmanElement1:(id)sender{
    if (![marksmanB1 isEnabled] &&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchMarksman:23 withStarCost:STARCOST3];
        [marksmanEl1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) marksmanElement2:(id)sender{
    if (![marksmanB2 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchMarksman:22 withStarCost:STARCOST3];
        [marksmanEl2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) marksmanElement3:(id)sender{
    
    if (![marksmanB3 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchMarksman:24 withStarCost:STARCOST3];
        [marksmanEl3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};




- (void) returnS:(id)sender{
    [self setVisible:NO];
};








@end
