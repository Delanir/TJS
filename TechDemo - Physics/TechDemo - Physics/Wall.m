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
        sprites = [[NSMutableArray alloc] init];
        
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
            [self changeTopSprite:sprites[2] bottomSprite:sprites[3]];
            status = scratched;
        }
        else if (health < 50 && health >= 25 && status == scratched)
        {
            [self changeTopSprite:sprites[4] bottomSprite:sprites[5]];
            status = damaged;
        }
        else if (health < 25 && health > 0 && status == damaged)
        {
            [self changeTopSprite:sprites[6] bottomSprite:sprites[7]];
            status = wrecked;
        }
        else if (health <= 0 && status == wrecked)
        {
            [self changeTopSprite:sprites[8] bottomSprite:sprites[9]];
            status = totaled;
        }
        lastHealth = health;
    }
        
}

- (void) changeTopSprite: (CCSprite*) topSprite bottomSprite: (CCSprite*) bottomSprite
{
    
    //CGSize winSize = [[CCDirector sharedDirector] winSize];
    [parentNode removeChild:sprites[0] cleanup:YES];
    [parentNode removeChild:sprites[1] cleanup:YES];
    //[sprites removeObject:sprites[1]];                      // reverse order is required!
    //[sprites removeObject:sprites[0]];
    
    //KKPixelMaskSprite * castletop = [KKPixelMaskSprite spriteWithFile:topSprite alphaThreshold:0.5f];
    //KKPixelMaskSprite * castlebottom = [KKPixelMaskSprite spriteWithFile:bottomSprite alphaThreshold:0.5f];
    
    //[sprites addObject:castletop];
    //[sprites addObject:castlebottom];
    
    //[castletop setPosition:ccp(winSize.width/2, winSize.height/2)];
    //[castlebottom setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    [parentNode addChild:topSprite z:1500];
    [parentNode addChild:bottomSprite z:10];
    
    
}

- (void) dealloc
{
    [parentNode removeChildByTag:5 cleanup:YES];
    [sprites removeAllObjects];
    [super dealloc];
}

- (NSMutableArray*) getSprites
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
