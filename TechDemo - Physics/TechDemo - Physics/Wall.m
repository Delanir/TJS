//
//  Wall.m
//  L'Archer
//
//  Created by João Amaral on 10/4/13.
//
//

#import "Wall.h"

@implementation Wall

@synthesize health, lastHealth, maxHealth, moatLevel;

- (id) init
{
    if(self = [super init])
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        maxHealth = 100.0; // Vai depender da skilltree
        health = maxHealth;
        lastHealth = maxHealth;
        status = kMintWall;
        moatLevel = kMoatNoDamage;
        
        sprites = [[CCArray alloc] init];
        
        CCNode * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
        CGPoint topPoint = ccp(161,549);
        CGPoint bottomPoint = ccp(200,252);
        
        KKPixelMaskSprite * castletop100 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle100-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom100 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle100-bottom.png" alphaThreshold:0.5f];
        [castletop100 setPosition:topPoint];
        [castlebottom100 setPosition:bottomPoint];
        
        KKPixelMaskSprite * castletop75 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle75-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom75 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle75-bottom.png" alphaThreshold:0.5f];
        [castletop75 setPosition:topPoint];
        [castlebottom75 setPosition:bottomPoint];
        
        KKPixelMaskSprite * castletop50 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle50-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom50 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle50-bottom.png" alphaThreshold:0.5f];
        [castletop50 setPosition:topPoint];
        [castlebottom50 setPosition:bottomPoint];
        
        KKPixelMaskSprite * castletop25 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle25-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom25 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle25-bottom.png" alphaThreshold:0.5f];
        [castletop25 setPosition:topPoint];
        [castlebottom25 setPosition:bottomPoint];
        
        KKPixelMaskSprite * castletop0 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle0-top.png" alphaThreshold:0.5f];
        KKPixelMaskSprite * castlebottom0 = [KKPixelMaskSprite spriteWithSpriteFrameName:@"castle0-bottom.png" alphaThreshold:0.5f];
        [castletop0 setPosition:topPoint];
        [castlebottom0 setPosition:ccp(265,252)];
        
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
        
        for (CCSprite * spr in sprites)
        {
            [spr setTag:5];
        }
        
        [levelLayer addChild:castletop100 z:999];
        [levelLayer addChild:castlebottom100 z:10];
        
        [[CollisionManager shared] addToWalls:castletop100];
        [[CollisionManager shared] addToWalls:castlebottom100];
        
        [self schedule:@selector(update:)];
        
        [self schedule:@selector(destructionChant) interval:9];
        losingRate=health;
        
        smokeTop = [[CCParticleSmoke alloc] init];
        smokeBottom = [[CCParticleSmoke alloc] init];
        [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:smokeTop z:999];
        [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:smokeBottom z:999];
        //[smoke setDuration:1];
        fireTop = [[ CCParticleFire alloc] init];
        fireBottom = [[ CCParticleFire alloc] init];
        [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:fireTop z:1000];
        [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:fireBottom z:1000];
        
        [smokeTop setEmissionRate:0];
        [smokeBottom setEmissionRate:0];
        [fireTop setEmissionRate:0];
        [fireBottom setEmissionRate:0];
    }
    
    return self;
}

- (void)update:(ccTime)dt
{
    topPoint1 = ccp(195,552);
    bottomPoint1 = ccp(225,252);
    topPoint2 = ccp(205,500);
    bottomPoint2 = ccp(200,200);
    fireSparksTop =ccp(195,602);
    fireSparksBottom =ccp(225,352);
    
    //Only test if required - try health and status
    if(health != lastHealth)
    {
        if(health > (0.75 * maxHealth) && status == kScratchedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:0] bottomSprite:[sprites objectAtIndex:1]];
            [smokeTop setEmissionRate:0];
            [smokeBottom setEmissionRate:0];
            [fireTop setEmissionRate:0];
            [fireBottom setEmissionRate:0];
            status = kMintWall;
        }
        
        if ( health < (0.75 * maxHealth) && health >= (0.5 * maxHealth) && (status == kMintWall || status == kDamagedWall))
        {
            [self changeTopSprite:[sprites objectAtIndex:2] bottomSprite:[sprites objectAtIndex:3]];
            
            [smokeTop setStartSize:25];
            [smokeTop setEndSize:35];
            [smokeTop setPosition:topPoint1];
            [smokeTop setTotalParticles:150];
            [smokeTop setAutoRemoveOnFinish:YES];
            
            [smokeBottom setStartSize:25];
            [smokeBottom setEndSize:35];
            [smokeBottom setPosition:bottomPoint1];
            [smokeBottom setTotalParticles:150];
            [smokeBottom setAutoRemoveOnFinish:YES];
            
            [smokeTop setEmissionRate:80];
            [smokeBottom setEmissionRate:80];
            [fireTop setEmissionRate:80];
            [fireBottom setEmissionRate:80];
            
            [fireTop setStartSize:0];
            [fireTop setEndSize:0];
            [fireTop setPosition:fireSparksTop];
            
            [fireBottom setStartSize:0];
            [fireBottom setEndSize:0];
            [fireBottom setPosition:fireSparksBottom];
            
            ccColor4F thisColor;
            thisColor.r = 0.7;
            thisColor.g = 0.7;
            thisColor.b = 0.7;
            thisColor.a = 0.1;
            smokeTop.startColor = thisColor;
            smokeBottom.startColor = thisColor;
            thisColor.r = 0;
            thisColor.g = 0;
            thisColor.b = 0;
            thisColor.a = 0.5;
            smokeTop.endColor = thisColor;
            smokeBottom.endColor = thisColor;
            
            status = kScratchedWall;
        }
        else if (health < (0.5 * maxHealth) && health >= (0.25 * maxHealth) && (status == kScratchedWall || status == kWreckedWall))
        {
        
            [smokeTop setStartColor:ccc4f(0.0, 0.0, 0.0, 0.1)];
            [smokeBottom setStartColor:ccc4f(0.0, 0.0, 0.0, 0.1)];
            [self changeTopSprite:[sprites objectAtIndex:4] bottomSprite:[sprites objectAtIndex:5]];
            [smokeTop setStartSize:40];
            [smokeTop setEndSize:70];
            [smokeBottom setStartSize:40];
            [smokeBottom setEndSize:70];
            [fireTop setPosition:topPoint2];
            [fireBottom setPosition:bottomPoint2];
            [fireTop setStartSize:30];
            [fireTop setEndSize:50];
            [fireBottom setStartSize:30];
            [fireBottom setEndSize:50];
            
            status = kDamagedWall;
        }
        else if (health < (0.25 * maxHealth) && health > 0 && status == kDamagedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:6] bottomSprite:[sprites objectAtIndex:7]];
            status = kWreckedWall;
            
            [fireTop setPosition:topPoint1];
            [fireTop setStartSize:50];
            [fireTop setEndSize:70];
            
            [fireBottom setPosition:bottomPoint2];
            [fireBottom setStartSize:50];
            [fireBottom setEndSize:70];
        }
        else if (health <= 0 && status == kWreckedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:8] bottomSprite:[sprites objectAtIndex:9]];
            status = kTotaledWall;
            [fireTop release];
            [fireBottom release];
            [smokeTop release];
            [smokeBottom release];
            
            
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
    CCSprite * moat = [CCSprite spriteWithSpriteFrameName:@"moat.png"];
    [moat setPosition:ccp(250, winSize.height/2)];
    [moat setTag:8];
    [self addChild:moat z:0];
}

- (void) addMasonry
{
    CCSprite * masonry = [CCSprite spriteWithSpriteFrameName:@"masonry.png"];
    [masonry setPosition:ccp(30, 240)];
    [masonry setTag:10];
    [self addChild:masonry z:20];
}

- (void) addMagesTower
{
    CCNode * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    CCSprite * magestower = [CCSprite spriteWithSpriteFrameName:@"mageTower2.png"];
    [magestower setPosition:ccp(30, 600)];
    [magestower setTag:11];
    [levelLayer addChild:magestower z:1400];
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


-(void) increaseHealth:(double)ratio
{
    maxHealth = maxHealth * ratio; // Vai depender da skilltree
    health = maxHealth;
    lastHealth = maxHealth;
}

-(void) regenerateHealth:(double)amount
{
    if (health == maxHealth)
        return;
    if (health + amount > maxHealth)
        health = maxHealth;
    else
        health += amount;
}

-(void) destructionChant
{
    if (losingRate -health >0.2*maxHealth) {
        [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"killhim"] pitch:1.0f pan:0.5f gain:0.7f];
    }
    losingRate = health;
    
}

+(BOOL) instaKill
{
    return arc4random_uniform(100) < kInstaKillChance;
}


@end
