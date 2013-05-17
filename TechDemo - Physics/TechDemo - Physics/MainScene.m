//
//  MainScene.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "MainScene.h"
#import "Utils.h"

@implementation MainScene

@synthesize background;

- (id) init;
{
    if( (self=[super init]))
    {
        

        
        Wall * wall = [[Wall alloc] init];
        [self addChild:wall];
        
        [[Registry shared] registerEntity:wall withName:@"Wall"];
        [[Registry shared] registerEntity:self withName:@"MainScene"];
        
        [wall release];
    }
    return self;
    
}

- (void) setBackgroundWithSpriteType:(NSString *) type
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if ([type isEqualToString: @"winter"])
        background = [CCSprite spriteWithFile:@"backgroundWinter.png"];
    
    else //([type isEqualToString: @"summer"])
        background = [CCSprite spriteWithFile:@"background.png"];
    
    [background setPosition:ccp(winSize.width/2, winSize.height/2)];
    [self addChild:background z:-1000];

}



@end
