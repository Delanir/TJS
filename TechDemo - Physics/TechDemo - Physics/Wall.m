//
//  Wall.m
//  L'Archer
//
//  Created by João Amaral on 10/4/13.
//
//

#import "Wall.h"
#import <objc/runtime.h>

@implementation Wall

@synthesize health;

- (id) init
{
    if((self = [super init]))
    {

    }
    
    return self;
}

// Isto tem de ser efectuado aqui para poder colocar as sprites ao nível do LevelLayer
// É feio mas tem de ser depois do init para as referências estarem montadas
-(void) mountWall
{
    
    KKPixelMaskSprite * castletop = [KKPixelMaskSprite spriteWithFile:@"castle100-top.png" alphaThreshold:0.5f];
    [sprites addObject:castletop];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    [castletop setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    [[[self parent] parent ] addChild:castletop z:1500];
    
    KKPixelMaskSprite * castlebottom = [KKPixelMaskSprite spriteWithFile:@"castle100-bottom.png" alphaThreshold:0.5f];
    [sprites addObject:castlebottom];
    
    [castlebottom setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    [[[self parent] parent ] addChild:castlebottom z:0];
    
}

// Fazer update
// Meter no collision cenas
// Fazer comportamentos peasant
// Mudar animação peasant


@end
