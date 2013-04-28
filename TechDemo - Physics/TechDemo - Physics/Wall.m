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
        maxHealth = 100.0; // Vai depender da skilltree
        health = maxHealth;
        lastHealth = maxHealth;
        status = kMintWall;
        
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
        
        [levelLayer addChild:castletop100 z:1500];
        [levelLayer addChild:castlebottom100 z:10];
        
        [[CollisionManager shared] addToWalls:castletop100];
        [[CollisionManager shared] addToWalls:castlebottom100];
        
        [self schedule:@selector(update:)];
        
        //[self addMoat];
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
//          CCParticleSmoke *smoke = [[CCParticleSmoke alloc] init];
//          CCParticleSmoke *fire = [[CCParticleMeteor alloc] init];
//          [smoke setAutoRemoveOnFinish:YES];
//          [smoke setScaleX:0.8];
//          [smoke setStartSize:10];
//          [smoke setEndSize:10];
//          [smoke setGravity:ccp(0,-90)];
//          [smoke setTotalParticles:50];
//          smoke.position = center;
//          [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:smoke];
          
          smoke = [[CCParticleSmoke alloc] init];
          [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:smoke z:999];
          [smoke setStartSize:25];
          [smoke setEndSize:35];
          [smoke setPosition:ccp(225,252)];
          [smoke setTotalParticles:150];
          [smoke setAutoRemoveOnFinish:YES];

          //[smoke setDuration:1];
          fire = [[ CCParticleFire alloc] init];
          [[[Registry shared] getEntityByName:@"LevelLayer"] addChild:fire z:1000];
          [fire setStartSize:0];
          [fire setEndSize:0];
          [fire setPosition:ccp(225,352)];
          
          //smoke.blendAdditive = NO;
          
          ccColor4F thisColor;
          thisColor.r = 1;
          thisColor.g = 1;
          thisColor.b = 1;
          thisColor.a = 0.5;
          smoke.startColor = thisColor;
          thisColor.r = 1;
          thisColor.g = 1;
          thisColor.b = 1;
          thisColor.a = 1;
          smoke.endColor = thisColor;
          
            status = kScratchedWall;
        }
        else if (health < (0.5 * maxHealth) && health >= (0.25 * maxHealth) && status == kScratchedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:4] bottomSprite:[sprites objectAtIndex:5]];
          
          [smoke setStartSize:40];
          [smoke setEndSize:70];
          NSLog(@"medio fogo!");
          //[smoke setTotalParticles:100];
//          [fire setStartSize:10];
//          [fire setEndSize:10];
//          //[smoke setAutoRemoveOnFinish:YES];
//                    [smoke setScaleX:0.8];
//          //          [smoke setStartSize:10];
//          //          [smoke setEndSize:10];
//                    [smoke setGravity:ccp(0,-90)];
//                    [smoke setTotalParticles:50];
          
          [fire setStartSize:10];
          [fire setEndSize:20];

          
          
            status = kDamagedWall;
        }
        else if (health < (0.25 * maxHealth) && health > 0 && status == kDamagedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:6] bottomSprite:[sprites objectAtIndex:7]];
            status = kWreckedWall;
//          [smoke setStartSize:25];
//          [smoke setEndSize:25];
//          [fire setStartSize:25];
//          [fire setEndSize:25];
        }
        else if (health <= 0 && status == kWreckedWall)
        {
            [self changeTopSprite:[sprites objectAtIndex:8] bottomSprite:[sprites objectAtIndex:9]];
            status = kTotaledWall;
//          [smoke setStartSize:50];
//          [smoke setEndSize:50];
//          [fire setStartSize:50];
//          [fire setEndSize:50];
          [fire setStartSize:120];
          [fire setEndSize:240];



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
