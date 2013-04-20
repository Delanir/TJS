//
//  LevelSelectLayer.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelSelectLayer.h"
#import "SpriteManager.h"
#import "SimpleAudioEngine.h"
#import "Config.h"


@implementation LevelSelectLayer



-(void)onEnter{
#warning ler do dic ou da plist
  [super onEnter];
  [_level1 setLevel:1];
  [_level2 setLevel:2];
  [_level1 setNumberStars:1];
  [_level2 setNumberStars:0];
  [_level1 setIsEnabled:YES];
  [_level2 setIsEnabled:NO];
  
  [_level1 initLevel];
  [_level2 initLevel];
  
  //Initialize art and animations
  [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"]];
  
  [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
  [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
  [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
  [[SpriteManager shared] addAnimationFromFile:@"yurie_anim.plist"];
  [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"MainMenuMusic"] loop:YES];
  
}



- (void) pressedGoToMainMenu:(id)sender{
  // Load the game scene
  CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];
  
  // Go to the game scene
  [[CCDirector sharedDirector] replaceScene:gameScene];
}
@end
