//
//  Enemy.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"
#import "CollisionManager.h"

@implementation Enemy

@synthesize currentState, strength, speed, goldValue, health, healthBar, maxHealth;


- (id) initWithSprite:(NSString *)spriteFile
{
    if( (self = [super init]))
    {
        [self setSpriteWithSpriteFrameName:spriteFile];
        [self addChild:sprite z:1];
        
        // Initialize health bar
        CCSprite * barSprite = [[CCSprite alloc] initWithFile:@"red_health_bar.png"];
        [self setHealthBar:[CCProgressTimer progressWithSprite:barSprite]];
        [healthBar setType: kCCProgressTimerTypeBar];
        [healthBar setBarChangeRate:ccp(1,0)];
        [healthBar setOpacity:0];
        [self addChild:healthBar z:2];
        [barSprite release];
    }
    return self;
}

-(void) postInit
{
    [self setMaxHealth:health];
    [healthBar setPercentage:health];
    [self schedule:@selector(update:)];
}

- (void) setupActions
{
    
    
}

- (void) animateWalkLeft;
{
    
    // Create the actions
    id actionMove = [CCMoveTo actionWithDuration:speed
                                        position:ccp(-sprite.contentSize.width/2, sprite.position.y)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(spriteMoveFinished:)];
    [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    id moveHealthBar = [CCMoveTo actionWithDuration:speed
                                           position:ccp(-sprite.contentSize.width/2, healthBar.position.y)];
    [[self healthBar] runAction:moveHealthBar];
}



-(void) placeRandomly
{
    CGSize spriteSize = [self spriteSize];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int minY = winSize.height/6 + spriteSize.height/2;
    int maxY = (5 * winSize.height / 6) - spriteSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the target slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    sprite.position = ccp(winSize.width + (spriteSize.width/2), actualY);
    //sprite.anchorPoint = ccp(1.0,1.0);
    
    healthBar.position = ccp(winSize.width + (spriteSize.width/2), actualY + spriteSize.height/2 + 2);
    healthBar.scaleX = 6;
    healthBar.scaleY = 1;
    
}


-(void)spriteMoveFinished:(id)sender {
    [self removeChild:sprite cleanup:YES];
    [self removeChild:healthBar cleanup:YES];
    [[CollisionManager shared] removeFromTargets:self];
}

-(void)attack
{
    
}

#warning isto é temporário. Depois o que tem de ser feito é um update de tratamento de estimulos. Mas o método pode ficar assim
-(void) takeDamage:(int) amount
{
    health -= amount;
    
    [healthBar setPercentage:100 * (self.health/self.maxHealth)];
    [healthBar setOpacity:255];
    /* IGNORAR ISTO PARA JÁ, N ESTÁ A FUNCIONAR LA MT BEM NAO CENAS E COISE
    if(100 * (self.health/self.maxHealth) < 60)
    {
        [[self healthBar] setSprite:[CCSprite spriteWithFile:@"red_health_bar.png"]];
        healthBar.position = ccp([[self sprite] position].x, [[self sprite] position].y + 2);
        healthBar.scaleX = 6;
        healthBar.scaleY = 2;
    }
    */
    if(health <= 0)
        [self die];
}


- (void)update:(ccTime)dt
{
    [healthBar setOpacity:[healthBar opacity] - dt*0.05];
#warning Testar aqui os selectors
}



-(void)die
{
    [self removeChild:healthBar cleanup:YES];
    [[ResourceManager shared] increaseEnemyKillCount];
    [[ResourceManager shared] addGold: goldValue];
}

-(BOOL) isDead
{
    return [self health]<=0;
}

- (void)damageWall
{
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    [wall damage:strength];
}

-(void ) shout
{
}

@end
