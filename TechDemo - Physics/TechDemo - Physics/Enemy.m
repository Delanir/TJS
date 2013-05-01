//
//  Enemy.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"
#import "CollisionManager.h"
#import "Utils.h"

#define SHOUTPERCENTAGE 7

@implementation Enemy

@synthesize currentState, strength, speed, goldValue, health, healthBar, maxHealth, stimuli;


- (id) initWithSprite:(NSString *)spriteFile
{
    if( (self = [super init]))
    {
        [self setSpriteWithSpriteFrameName:spriteFile];
        [self addChild:sprite z:1];
        stimuli = [[NSMutableArray alloc] init];
        
        // Initialize health bar
        CCSprite * barSprite = [[CCSprite alloc] initWithSpriteFrameName:@"red_health_bar.png"];
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
    shoutPercentage =SHOUTPERCENTAGE;
    [self schedule:@selector(shout) interval:1.5];
 
    [self schedule:@selector(update:)];
}

-(void) dealloc
{
    [stimuli release];
    [super dealloc];
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

-(void) takeDamage:(int) amount
{
    if(![self isDead])  // para garantir que só morre uma vez
    {
        health -= amount;
        
        [healthBar setPercentage:100 * (self.health/self.maxHealth)];
        [healthBar setOpacity:255];
        
        if(health <= 0)
            [self die];
    }
}

-(void) enqueueStimuli:(NSMutableArray *) stimulusPackage
{
    for (Stimulus * stimulus in stimulusPackage)
        [stimuli enqueue:stimulus];
}


- (void)update:(ccTime)dt
{
    if([healthBar opacity] > 0)
        [healthBar setOpacity:[healthBar opacity] - dt*0.08];
    
    if([stimuli count] > 0)
    {
        
        // PARA EXPANDIR PARA PARTICULARIDADES DE CADA UM DOS ENEMIES
        // É PRECISO POR ESTE FOR EM CADA UMA DAS SUBCLASSES
        // E IMPLEMENTAR DISTINTAMENTE PARA CADA UM DELES
        for (int i = 0; i< [stimuli count]; i++)
        {
            Stimulus * stimulus = [stimuli dequeue];
            
            switch ([stimulus type])
            {
                case kDamageStimulus:
                    [self takeDamage:[stimulus value]];
                    break;
                case kDOTStimulus:
                    // FAZER LOGICA DE DAMAGE OVER TIME
                    // METER UMA VARIAVEL QUE DECREMENTA
                    // ENQUANTO N É ZERO, PARTICULAS FOGO
                    [self takeDamage:[stimulus value]];
                    break;
                case kSlowStimulus:
                    // FAZER LOGICA DE SLOW
                    // METER UMA VARIAVEL QUE DECREMENTA
                    // ENQUANTO N É ZERO, SPEED MAIS LENTO -> REFAZER ANIMAÇÃO
                    [self takeDamage:[stimulus value]];
                    break;
                case KPushBackStimulus:
                    // FAZER LOGICA DE PUSH BACK
                    // TRANSLATES PARA TRÁS
                    [self takeDamage:[stimulus value]];
                    break;
                default:
                    break;
            }
        }
    }
    
    
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
