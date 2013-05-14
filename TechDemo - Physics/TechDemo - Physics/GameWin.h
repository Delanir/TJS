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

@interface GameWin : CCNode {
    CCSprite * _mainMenuButton;
    
    CCSprite * _menu;
    CCSprite * _skill;
    CCSprite * _play;
}


-(CCSprite *) getMenuButton;

-(CCSprite *) getPlayButton;

-(CCSprite *) getSkillButton;

-(void) disablePlayNext;

@end
