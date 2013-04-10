//
//  Wall.m
//  L'Archer
//
//  Created by João Amaral on 10/4/13.
//
//

#import "Wall.h"

@implementation Wall

- (id) init
{
    if((self = [super init]))
    {
        KKPixelMaskSprite * castle = [KKPixelMaskSprite spriteWithFile:@"castle0.png" alphaThreshold:0.5f];
        [sprites addObject:castle];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [castle setPosition:ccp(winSize.width/2, winSize.height/2)];
        
        [self addChild:castle];
        
        //[castle setVisible:false];
    }
    
    return self;
}


@end
