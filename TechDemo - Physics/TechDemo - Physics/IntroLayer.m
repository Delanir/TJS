//
//  IntroLayer.m
//  TechDemo - Physics
//
//  Created by jp on 30/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "LevelLayer.h"
#import "SpriteManager.h"
#import "Config.h"
// Sound interface
#import "SimpleAudioEngine.h"
#import "CCBReader.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    
	
	// return the scene
	return scene;
}

// 
-(void) onEnter
{
	[super onEnter];
//    CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];
//    [CCBReader ]
//    // Go to the game scene
//    [[CCDirector sharedDirector] replaceScene:gameScene];
    
}
//	// ask director for the window size
//	CGSize size = [[CCDirector sharedDirector] winSize];
//
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
//	
//	// In one second transition to the new scene
//	[self scheduleOnce:@selector(makeTransition:) delay:1];
//    
//    
//    //Initialize art and animations
//    if(![Config iPadRetina])
//        [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"]];
//    else
//        [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet-ipadhd.plist" andBatchSpriteSheet:@"lvl1spritesheet-ipadhd.png"]];
//        
//    [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
//    [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
//    [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
//    [[SimpleAudioEngine sharedEngine] init];
//    
//}
//
//-(void) makeTransition:(ccTime)dt
//{
//	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelLayer scene] withColor:ccWHITE]];
//}
@end
