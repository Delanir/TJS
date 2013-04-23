//
//  Wall.m
//  L'Archer
//
//  Created by João Amaral on 10/4/13.
//
//

#import "Wall.h"

@implementation Wall

@synthesize health, lastHealth, maxHealth;

- (id) init
{
    if((self = [super init]))
    {
        maxHealth = 50.0f; // Vai depender da skilltree
        health = maxHealth;
        lastHealth = maxHealth;
        status = kMintWall;
        
        sprites = [[CCArray alloc] init];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCNode * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
        
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
        
        [levelLayer addChild:castletop100 z:1500];
        [levelLayer addChild:castlebottom100 z:10];
        
        [[CollisionManager shared] addToWalls:castletop100];
        [[CollisionManager shared] addToWalls:castlebottom100];
        
        [self schedule:@selector(update:)];
        
#warning temporario
        [self addMoat];
    }
    
    return self;
}

- (void)update:(ccTime)dt
{    
    //Only test if required - try health and status
    if(health != lastHealth)
    {
        if (health < (0.75 * maxHealth) && health >= (0.5 * maxHealth) && status == kMintWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:2] bottomSprite:[sprites objectAtIndex:3]];
            status = kScratchedWall;
        }
        else if (health < (0.5 * maxHealth) && health >= (0.25 * maxHealth) && status == kScratchedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:4] bottomSprite:[sprites objectAtIndex:5]];
            status = kDamagedWall;
        }
        else if (health < (0.25 * maxHealth) && health > 0 && status == kDamagedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:6] bottomSprite:[sprites objectAtIndex:7]];
            status = kWreckedWall;
        }
        else if (health <= 0 && status == kWreckedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:8] bottomSprite:[sprites objectAtIndex:9]];
            status = kTotaledWall;
        }
        lastHealth = health;
    }
        
}

- (void) changeTopSprite: (CCSprite*) topSprite bottomSprite: (CCSprite*) bottomSprite
{
    CCNode * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    
    [levelLayer removeChildByTag:5 cleanup:YES];
    [levelLayer removeChildByTag:5 cleanup:YES];
    
    [levelLayer addChild:topSprite z:999];
    [levelLayer addChild:bottomSprite z:10];
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
    CCNode * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    
    [levelLayer removeChildByTag:5 cleanup:YES];
    [levelLayer removeChildByTag:5 cleanup:YES];
    [sprites removeAllObjects];
    [sprites release];
    sprites = nil;
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


@end
