//
//  Wall.m
//  L'Archer
//
//  Created by João Amaral on 10/4/13.
//
//

#import "Wall.h"

@implementation Wall

@synthesize health;

- (id) init
{
    if((self = [super init]))
    {
        KKPixelMaskSprite * castle = [KKPixelMaskSprite spriteWithFile:@"castle100.png" alphaThreshold:0.5f];
        [sprites addObject:castle];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [castle setPosition:ccp(winSize.width/2, winSize.height/2)];
        
        [self addChild:castle];
        
        //[castle setVisible:false];
    }
    
    return self;
}

// Fazer update
// Meter no collision cenas
// Fazer comportamentos peasant
// Mudar animação peasant


@end
