//
//  MainMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "CCBReader.h"


#import "LevelLayer.h"
#import "SpriteManager.h"
#import "Config.h"
// Sound interface
#import "SimpleAudioEngine.h"


@implementation MainMenuLayer




- (void) pressedPlay:(id)sender
{
    // ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    
//	CCSprite *background;
//	
//	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
//		background = [CCSprite spriteWithFile:@"Default.png"];
//		background.rotation = 90;
//	} else {
//		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
//	}
//	background.position = ccp(size.width/2, size.height/2);
//    
//	// add the label as a child to this Layer
//	[self addChild: background];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:1];
    
    
    //Initialize art and animations
    if(![Config iPadRetina])
        [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"]];
    else
        [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet-ipadhd.plist" andBatchSpriteSheet:@"lvl1spritesheet-ipadhd.png"]];
    
    [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
    [[SimpleAudioEngine sharedEngine] init];
    
        
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelLayer scene] withColor:ccWHITE]];
}

@end
