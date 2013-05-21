//
//  GameWin.m
//  L'Archer
//
//  Created by Ricardo on 4/25/13.
//
//

#import "GameWin.h"
#import "Registry.h"

@implementation GameWin

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(CCSprite *) getMenuButton
{
    return _menu;
};

-(CCSprite *) getMainButton
{
    return _main;
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

-(void) setStars: (int) numberOfStars{
    [_stars1 makeVisible:numberOfStars];
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

@end
