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

@synthesize health, lastHealth, parentNode;

- (id) initWithParent:(CCNode *)parent
{
    if((self = [super init]))
    {
        
        health = 100.0f;
        lastHealth = 100.0f;
        status = mint;
        [self setParentNode:parent];
        sprites = [[NSMutableArray alloc] init];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        KKPixelMaskSprite * castletop = [KKPixelMaskSprite spriteWithFile:@"castle100-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom = [KKPixelMaskSprite spriteWithFile:@"castle100-bottom.png" alphaThreshold:0.5f];
        
        [sprites addObject:castletop];
        [sprites addObject:castlebottom];
        
        [castletop setPosition:ccp(winSize.width/2, winSize.height/2)];
        [castlebottom setPosition:ccp(winSize.width/2, winSize.height/2)];
        
        [parentNode addChild:castletop z:1500];
        [parentNode addChild:castlebottom z:10];
        
        [[CollisionManager shared] addToWalls:castletop];
        [[CollisionManager shared] addToWalls:castlebottom];
        
        
        [self schedule:@selector(update:)];
    }
    
    return self;
}

- (void)update:(ccTime)dt
{    
    //Only test if required - try health and status
    if(health != lastHealth)
    {
        if (health < 75 && health >= 50 && status == mint)
        {
            [self changeTopSprite:@"castle75-top.png" bottomSprite:@"castle75-bottom.png"];
            status = scratched;
        }
        else if (health < 50 && health >= 25 && status == scratched)
        {
            [self changeTopSprite:@"castle50-top.png" bottomSprite:@"castle50-bottom.png"];
            status = damaged;
        }
        else if (health < 25 && health > 0 && status == damaged)
        {
            [self changeTopSprite:@"castle25-top.png" bottomSprite:@"castle25-bottom.png"];
            status = wrecked;
        }
        else if (health <= 0 && status == wrecked)
        {
            [self changeTopSprite:@"castle0-top.png" bottomSprite:@"castle0-bottom.png"];
            status = totaled;
        }
        lastHealth = health;
    }
        
}

- (void) changeTopSprite: (NSString*) topSprite bottomSprite: (NSString*) bottomSprite
{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    [parentNode removeChild:sprites[0] cleanup:YES];
    [parentNode removeChild:sprites[1] cleanup:YES];
    [sprites removeObject:sprites[1]];                      // reverse order is required!
    [sprites removeObject:sprites[0]];
    
    KKPixelMaskSprite * castletop = [KKPixelMaskSprite spriteWithFile:topSprite alphaThreshold:0.5f];
    KKPixelMaskSprite * castlebottom = [KKPixelMaskSprite spriteWithFile:bottomSprite alphaThreshold:0.5f];
    
    [sprites addObject:castletop];
    [sprites addObject:castlebottom];
    
    [castletop setPosition:ccp(winSize.width/2, winSize.height/2)];
    [castlebottom setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    [parentNode addChild:castletop z:1500];
    [parentNode addChild:castlebottom z:10];
    
    
}

- (void) dealloc
{
    [parentNode removeChild:sprites[0] cleanup:YES];
    [parentNode removeChild:sprites[1] cleanup:YES];
    [sprites removeObject:sprites[1]];                      // reverse order is required!
    [sprites removeObject:sprites[0]];
    [super dealloc];
}

- (NSMutableArray*) getSprites
{
    return sprites;
}


@end
