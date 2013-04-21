//
//  SpriteManager.m
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SpriteManager.h"


@implementation SpriteManager

static SpriteManager* _sharedSingleton = nil;

+(SpriteManager*)shared
{
	@synchronized([SpriteManager class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([SpriteManager class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init
{
	if (self = [super init]) {

        // Initialize stuff
    }
    
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    //Dealloc stuff below this line
    [_sharedSingleton release];
	[super dealloc];
}




- (CCSpriteBatchNode *) addSpritesToSpriteFrameCacheWithFile: (NSString *)filePlist andBatchSpriteSheet: (NSString *)filePng
 {
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePlist];
     spritesheetDisplayList = [CCSpriteBatchNode batchNodeWithFile:filePng];
    
     return spritesheetDisplayList;
 }

- (void) addSpritesToSpriteFrameCacheWithFile: (NSString *)filePlist
{
  [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePlist];
}


- (void) addAnimationFromFile: (NSString *)file
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:file];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    [self addAnimationsWithDictionary:dict];
    
}

-(void)addAnimationsWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *animations = dictionary;
    
    if ( animations == nil ) {
        CCLOG(@"ISCCAnimationCacheExtensions: No animations found in provided dictionary.");
        return;
    }
    
    NSArray* animationNames = [animations allKeys];
    
    for( NSString *name in animationNames ) {
        NSDictionary* animationDict = [animations objectForKey:name];
        NSArray *frameNames = [animationDict objectForKey:@"frames"];
        NSNumber *delay = [animationDict objectForKey:@"delay"];
        CCAnimation* animation = nil;
        
        if ( frameNames == nil ) {
            CCLOG(@"ISCCAnimationCacheExtensions: Animation '%@' found in dictionary without any frames - cannot add to animation cache.", name);
            continue;
        }
      
      CCArray *frames = [CCArray arrayWithCapacity:[frameNames count]];
        //NSMutableArray *frames = [NSMutableArray arrayWithCapacity:[frameNames count]];
        
        for( NSString *frameName in frameNames ) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
            
            
            if ( frame != nil ) {
                [frames addObject:frame];
            }else
                CCLOG(@"ISCCAnimationCacheExtensions: Animation '%@' refers to frame '%@' which is not currently in the CCSpriteFrameCache. This frame will not be added to the animation.", name, frameName);
        }
        
        if ( [frames count] == 0 ) {
            CCLOG(@"ISCCAnimationCacheExtensions: None of the frames for animation '%@' were found in the CCSpriteFrameCache. Animation is not being added to the AnimationCache.", name);
            continue;
        } else if ( [frames count] != [frameNames count] ) {
            CCLOG(@"ISCCAnimationCacheExtensions: An animation in your dictionary refers to a frame which is not in the CCSpriteFrameCache. Some or all of the frames for the animation '%@' may be missing.", name);
        }
        
        if ( delay != nil ) {
            animation = [CCAnimation animationWithSpriteFrames:(NSArray *) frames delay:[delay floatValue]];
        } else {
            animation = [CCAnimation animationWithSpriteFrames:(NSArray *) frames];
        }
        
        [[CCAnimationCache sharedAnimationCache] addAnimation:animation name:name];
    }
}

@end
