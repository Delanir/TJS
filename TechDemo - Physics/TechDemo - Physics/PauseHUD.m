//
//  PauseHUD.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "PauseHUD.h"
#import "SimpleAudioEngine.h"
#import "LevelLayer.h"

@implementation PauseHUD

-(CCSprite *) getPauseButton
{
  return _pause;
};

-(CCSprite *) getMenuButton
{
    return _menu;
};

- (void) skillTree:(id)sender{
    if ([[CCDirector sharedDirector]isPaused]) {
        [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [((LevelLayer *)[self parent]) setIsTouchEnabled:NO];
        [[CCDirector sharedDirector] resume];
        
        [[GameManager shared] runSceneWithID:kSkillTreeScene];
    }
   
};


@end
