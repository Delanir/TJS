//
//  citySubSkillTree.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "citySubSkillTree.h"
#import "SkillTreeLayer.h"
#import "GameState.h"

#import "Constants.h"


@implementation CitySubSkillTree

- (void) setStars{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    int index;
    for (int i=7; i<14; i++) {
        index = [[skill objectAtIndex:i] intValue];
        switch (i) {
            case 7:
                if (index!=0)
                    [city setIsEnabled:NO]; else [city  setIsEnabled:YES]; 
                
                
                break;
            case 8:
                if (index!=0) 
                [cityEl2 setIsEnabled:NO]; else [cityEl2  setIsEnabled:YES]; 
                
                break;
            case 9:
                if (index!=0) 
                [cityEl1 setIsEnabled:NO]; else [cityEl1 setIsEnabled:YES]; 
                break;
            case 10:
                if (index!=0) 
                [cityEl3 setIsEnabled:NO]; else [cityEl3 setIsEnabled:YES]; 
                break;
            case 11:
                if (index!=0) 
                [cityB3 setIsEnabled:NO]; else [cityB3  setIsEnabled:YES]; 
                break;
            case 12:
                if (index!=0) 
                [cityB2 setIsEnabled:NO]; else [cityB2 setIsEnabled:YES]; 
                break;
            case 13:
                if (index!=0)
                [cityB1 setIsEnabled:NO]; else [cityB1 setIsEnabled:YES]; 
                break;
            default:
                break;
        }
    }
    
}



- (void) cityMainBranch:(id)sender{
    
    if ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST1) {
        [((SkillTreeLayer *)[self parent]) switchCity:7 withStarCost:STARCOST1];
        [city setIsEnabled:NO];
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST1];
        [[GameState shared] saveApplicationData];
    }
    
};
- (void) cityBranch1:(id)sender{
    if (![city isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchCity:13 withStarCost:STARCOST2];
        [cityB1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) cityBranch2:(id)sender{
    if (![city isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchCity:12 withStarCost:STARCOST2];
        [cityB2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) cityBranch3:(id)sender{
    if (![city isEnabled] && ([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST2)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST2];
        [((SkillTreeLayer *)[self parent]) switchCity:11 withStarCost:STARCOST2];
        [cityB3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) cityElement1:(id)sender{
    if (![cityB1 isEnabled] &&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchCity:9 withStarCost:STARCOST3];
        [cityEl1 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) cityElement2:(id)sender{
    if (![cityB2 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchCity:8 withStarCost:STARCOST3];
        [cityEl2 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};
- (void) cityElement3:(id)sender{
    
    if (![cityB3 isEnabled]&&([((SkillTreeLayer *)[self parent]) availableStars] >= STARCOST3)) {
        [((SkillTreeLayer *)[self parent]) decreaseAvailableStarsBy:STARCOST3];
        [((SkillTreeLayer *)[self parent]) switchCity:10 withStarCost:STARCOST3];
        [cityEl3 setIsEnabled:NO];
        [[GameState shared] saveApplicationData];
    }
};




- (void) returnS:(id)sender{
    [self setVisible:NO];
};








@end
