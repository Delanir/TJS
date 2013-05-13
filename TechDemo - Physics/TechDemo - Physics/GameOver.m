//
//  GameOver.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"
#import "SimpleAudioEngine.h"
#import "LevelLayer.h"

@implementation GameOver

-(CGPoint) mainMenuButtonPosition
{
    return _mainMenuButton.position;
}

-(float) mainMenuButtonRadius
{
    return max(_mainMenuButton.contentSize.width*self.scaleX, _mainMenuButton.contentSize.height*self.scaleY);
}

- (void) retry:(id)sender{
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [((LevelLayer *)[self parent]) setIsTouchEnabled:NO];
    [[CCDirector sharedDirector] resume];
    
    [[GameManager shared] runLevel:[((LevelLayer *)[self parent])level]];
    
};

- (void) skillTree:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [((LevelLayer *)[self parent]) setIsTouchEnabled:NO];
    [[CCDirector sharedDirector] resume];
    
    [[GameManager shared] runSceneWithID:kSkillTreeScene];
};

@end
