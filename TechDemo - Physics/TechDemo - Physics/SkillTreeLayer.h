//
//  SkillTreeLayer.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"
#import "FireSubSkillTree.h"
#import "IceSubSkillTree.h"
#import "MarksmanSubSkillTree.h"
#import "CitySubSkillTree.h"

@interface SkillTreeLayer : CCLayer
{
    CCSprite *_iceMainBranch;
    CCSprite *_iceElement2;
    CCSprite *_iceElement1;
    CCSprite *_iceElement3;
    CCSprite *_iceBranch3;
    CCSprite *_iceBranch2;
    CCSprite *_iceBranch1;
    CCSprite *_cityMainBranch;
    CCSprite *_cityElement2;
    CCSprite *_cityElement1;
    CCSprite *_cityElement3;
    CCSprite *_cityBranch3;
    CCSprite *_cityBranch2;
    CCSprite *_cityBranch1;
    CCSprite *_fireMainBranch;
    CCSprite *_fireElement2;
    CCSprite *_fireElement1;
    CCSprite *_fireElement3;
    CCSprite *_fireBranch3;
    CCSprite *_fireBranch2;
    CCSprite *_fireBranch1;
    CCSprite *_marksmanMainBranch;
    CCSprite *_marksmanElement2;
    CCSprite *_marksmanElement1;
    CCSprite *_marksmanElement3;
    CCSprite *_marksmanBranch3;
    CCSprite *_marksmanBranch2;
    CCSprite *_marksmanBranch1;
    
    CCLabelTTF *_numberStars;
    int availableStars;
    
    FireSubSkillTree * fireMenu;
    IceSubSkillTree *iceMenu;
    MarksmanSubSkillTree *marksmanMenu;
    CitySubSkillTree *cityMenu;
    
}

@property int availableStars;
- (void) pressedPlay:(id)sender;
- (void) pressedCitySymbol:(id)sender;
- (void) pressedMainMenu:(id)sender;
- (void) pressedMarksmanSymbol:(id)sender;
- (void) pressedIceSymbol:(id)sender;
- (void) pressedFireSymbol:(id)sender;
- (void) switchFire: (int)index withStarCost:(int)star;
- (void) switchIce: (int)index withStarCost:(int)star;
- (void) switchCity: (int)index withStarCost:(int)star;
- (void) switchMarksman: (int)index withStarCost:(int)star;
-(int) usedStars;
-(int) currentStars;
- (void) decreaseAvailableStarsBy: (int) stars;
- (void) resetSkillTree:(id)sender;
-(int) nonUsedStars;
@end
