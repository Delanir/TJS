//
//  GameWin.m
//  L'Archer
//
//  Created by Ricardo on 4/25/13.
//
//

#import "GameWin.h"

@implementation GameWin

-(CCSprite *) getMenuButton
{
    return _menu;
};

-(CCSprite *) getPlayButton{
    return _play;
};

-(CCSprite *) getSkillButton{
    return _skill;
};

-(void) disablePlayNext{
    [_play setVisible:NO];
}

@end
