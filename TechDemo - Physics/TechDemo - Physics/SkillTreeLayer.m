//
//  SkillTreeLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SkillTreeLayer.h"
#import "Registry.h"
#import "GameManager.h"

@implementation SkillTreeLayer

//static SkillTreeLayer* _sharedSingleton = nil;
//
//+(SkillTreeLayer*)shared
//{
//	@synchronized([SkillTreeLayer class])
//	{
//		if (!_sharedSingleton)
//			[[self alloc] init];
//    
//		return _sharedSingleton;
//	}
//  
//	return nil;
//}
//
//+(id)alloc
//{
//	@synchronized([SkillTreeLayer class])
//	{
//		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
//		_sharedSingleton = [super alloc];
//		return _sharedSingleton;
//	}
//  
//	return nil;
//}
//
//-(id)init
//{
//	self = [super init];
//	if (self != nil) {
//		// initialize stuff here
//  }
//	return self;
//}
//
//
//-(void)dealloc
//{
//  [_sharedSingleton release];
//  [super dealloc];
//}



-(void)dealloc{

//    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
    
}

-(void)onEnter
{
    [super onEnter];
    
    [_iceMainBranch setVisible:NO];
    [_iceElement2 setVisible:NO];
    [_iceElement1 setVisible:NO];
    [_iceElement3 setVisible:NO];
    [_iceBranch3 setVisible:NO];
    [_iceBranch2 setVisible:NO];
    [_iceBranch1 setVisible:NO];
    
    [_cityMainBranch setVisible:NO];
//    [_cityMainBranch setZOrder:15];
    [_cityElement2 setVisible:NO];
//    [_cityElement2 setZOrder:4];
    [_cityElement1 setVisible:NO];
//    [_cityElement1 setZOrder:5];
    [_cityElement3 setVisible:NO];
//    [_cityElement3 setZOrder:2];
    [_cityBranch3 setVisible:NO];
//    [_cityBranch3 setZOrder:12];
    [_cityBranch2 setVisible:NO];
//    [_cityBranch2 setZOrder:13];
    [_cityBranch1 setVisible:NO];
//    [_cityBranch1 setZOrder:14];
    
    [_fireMainBranch setVisible:NO];
    [_fireElement2 setVisible:NO];
    [_fireElement1 setVisible:NO];
    [_fireElement3 setVisible:NO];
    [_fireBranch3 setVisible:NO];
    [_fireBranch2 setVisible:NO];
    [_fireBranch1 setVisible:NO];
    
    [_marksmanMainBranch setVisible:NO];
    [_marksmanElement2 setVisible:NO];
    [_marksmanElement1 setVisible:NO];
    [_marksmanElement3 setVisible:NO];
    [_marksmanBranch3 setVisible:NO];
    [_marksmanBranch2 setVisible:NO];
    [_marksmanBranch1 setVisible:NO];
}

- (void) pressedCitySymbol:(id)sender
{
    [_cityMainBranch setVisible:YES];
    [_cityElement2 setVisible:YES];
    [_cityElement1 setVisible:YES];
    [_cityElement3 setVisible:YES];
    [_cityBranch3 setVisible:YES];
    [_cityBranch2 setVisible:YES];
    [_cityBranch1 setVisible:YES];
}

- (void) pressedFireSymbol:(id)sender
{
    [_fireMainBranch setVisible:YES];
    [_fireElement2 setVisible:YES];
    [_fireElement1 setVisible:YES];
    [_fireElement3 setVisible:YES];
    [_fireBranch3 setVisible:YES];
    [_fireBranch2 setVisible:YES];
    [_fireBranch1 setVisible:YES];
}

- (void) pressedMarksmanSymbol:(id)sender
{
    [_marksmanMainBranch setVisible:YES];
    [_marksmanElement2 setVisible:YES];
    [_marksmanElement1 setVisible:YES];
    [_marksmanElement3 setVisible:YES];
    [_marksmanBranch3 setVisible:YES];
    [_marksmanBranch2 setVisible:YES];
    [_marksmanBranch1 setVisible:YES];
}

- (void) pressedIceSymbol:(id)sender
{
    [_iceMainBranch setVisible:YES];
    [_iceElement2 setVisible:YES];
    [_iceElement1 setVisible:YES];
    [_iceElement3 setVisible:YES];
    [_iceBranch3 setVisible:YES];
    [_iceBranch2 setVisible:YES];
    [_iceBranch1 setVisible:YES];
    
    
}

- (void) pressedMainMenu:(id)sender
{
   [[GameManager shared] runSceneWithID:kMainMenuScene];
}

-(void)onExit
{
  [super onExit];
//  [self removeAllChildrenWithCleanup:YES];
}




@end
