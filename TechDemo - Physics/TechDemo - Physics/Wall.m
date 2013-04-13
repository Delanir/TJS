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

#warning temporario
static Wall * _major = nil;

- (id) initWithParent:(CCNode *)parent
{
    if((self = [super init]))
    {
        
        health = 100.0f;
        lastHealth = 100.0f;
        status = mint;
        [self setParentNode:parent];
        sprites = [[CCArray alloc] init];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        KKPixelMaskSprite * castletop100 = [KKPixelMaskSprite spriteWithFile:@"castle100-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom100 = [KKPixelMaskSprite spriteWithFile:@"castle100-bottom.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castletop75 = [KKPixelMaskSprite spriteWithFile:@"castle75-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom75 = [KKPixelMaskSprite spriteWithFile:@"castle75-bottom.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castletop50 = [KKPixelMaskSprite spriteWithFile:@"castle50-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom50 = [KKPixelMaskSprite spriteWithFile:@"castle50-bottom.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castletop25 = [KKPixelMaskSprite spriteWithFile:@"castle25-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom25 = [KKPixelMaskSprite spriteWithFile:@"castle25-bottom.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castletop0 = [KKPixelMaskSprite spriteWithFile:@"castle0-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom0 = [KKPixelMaskSprite spriteWithFile:@"castle0-bottom.png" alphaThreshold:0.5f];
        
        [sprites addObject:castletop100];
        [sprites addObject:castlebottom100];
        [sprites addObject:castletop75];
        [sprites addObject:castlebottom75];
        [sprites addObject:castletop50];
        [sprites addObject:castlebottom50];
        [sprites addObject:castletop25];
        [sprites addObject:castlebottom25];
        [sprites addObject:castletop0];
        [sprites addObject:castlebottom0];
        
        CGPoint center = ccp(winSize.width/2, winSize.height/2);
        
        for (CCSprite * spr in sprites)
        {
            [spr setPosition:center];
            [spr setTag:5];
        }
        
        [parentNode addChild:castletop100 z:1500];
        [parentNode addChild:castlebottom100 z:10];
        
        [[CollisionManager shared] addToWalls:castletop100];
        [[CollisionManager shared] addToWalls:castlebottom100];
        
        
#warning TEMPORARIO remover moat
        [self addMoat];
        
        [self schedule:@selector(update:)];
    }
    
    _major = self;
    return self;
}

- (void)update:(ccTime)dt
{    
    //Only test if required - try health and status
    if(health != lastHealth)
    {
        if (health < 75 && health >= 50 && status == mint)
        {
            [self changeTopSprite:[sprites objectAtIndex:2] bottomSprite:[sprites objectAtIndex:3]];
            status = scratched;
        }
        else if (health < 50 && health >= 25 && status == scratched)
        {
            [self changeTopSprite:[sprites objectAtIndex:4] bottomSprite:[sprites objectAtIndex:5]];
            status = damaged;
        }
        else if (health < 25 && health > 0 && status == damaged)
        {
            [self changeTopSprite:[sprites objectAtIndex:6] bottomSprite:[sprites objectAtIndex:7]];
            status = wrecked;
        }
        else if (health <= 0 && status == wrecked)
        {
            [self changeTopSprite:[sprites objectAtIndex:8] bottomSprite:[sprites objectAtIndex:9]];
            status = totaled;
        }
        lastHealth = health;
    }
        
}

- (void) changeTopSprite: (CCSprite*) topSprite bottomSprite: (CCSprite*) bottomSprite
{
    
    [parentNode removeChildByTag:5 cleanup:YES];
    [parentNode removeChildByTag:5 cleanup:YES];
    
    [parentNode addChild:topSprite z:1500];
    [parentNode addChild:bottomSprite z:10];
}

- (void) addMoat
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite * moat = [CCSprite spriteWithFile:@"moat.png"];
    [moat setPosition:ccp(winSize.width/2, winSize.height/2)];
    [moat setTag:8];
    [self addChild:moat z:0];
}

- (void) dealloc
{
    [parentNode removeChildByTag:5 cleanup:YES];
    [parentNode removeChildByTag:5 cleanup:YES];
    [sprites removeAllObjects];
    [super dealloc];
}

- (CCArray*) getSprites
{
    return sprites;
}

-(void) damage: (double) amount
{
    health -= amount;
}

#warning temporario
+(Wall*) getMajor
{
    return _major;
}

@end
