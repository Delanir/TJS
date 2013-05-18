//
//  GameWin.h
//  L'Archer
//
//  Created by Ricardo on 4/25/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"
#import "LevelStars.h"

@interface GameWin : CCNode {
    CCSprite * _mainMenuButton;
    
    CCSprite * _menu;
    CCSprite * _skill;
    CCSprite * _play;
    CCSprite * _main;
    
    LevelStars* _stars1;
}


-(CCSprite *) getMenuButton;

-(CCSprite *) getPlayButton;

-(CCSprite *) getSkillButton;

-(CCSprite *) getMainButton;

-(void) disablePlayNext;

-(void) setStars: (int) numberOfStars;

@end
