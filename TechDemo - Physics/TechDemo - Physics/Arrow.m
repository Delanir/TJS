//
//  Arrow.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Arrow.h"
#import "Stimulus.h"

@implementation Arrow



- (id) initWithDestination: (CGPoint) location andStimulusPackage: (CCArray *) stimulusPackage
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if( self = [super initWithSprite:@"Projectile.png"])
    {
        
        CGSize spriteSize = [self spriteSize];
        
        // @TODO init with yuri information
        sprite.position = ccp(180, winSize.height/2 + 26);
        [sprite setAnchorPoint:CGPointMake(0, 0.5)];
        
        // Determine offset of location to projectile
        int offX = location.x - sprite.position.x;
        int offY = location.y - sprite.position.y;
        
        // Bail out if we are shooting down or backwards
        if (offX <= 0)
            offX = 1;
        
        // Determine where we wish to shoot the projectile to
        int realX = winSize.width + (spriteSize.width/2);
        float ratio = (float) offY / (float) offX;
        int realY = (realX * ratio) + sprite.position.y;
        [self setDestination:ccp(realX, realY)];
        
        // Determine the length of how far we're shooting
        int offRealX = realX - sprite.position.x;
        int offRealY = realY - sprite.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 600/1; // 480pixels/1sec
        [self setTimeToLive:length/velocity];
        
        // Rotate the arrow in the correct direction
        float angle = CC_RADIANS_TO_DEGREES(atanf((float)offRealY / (float)offRealX));
        [sprite setRotation:(-1 * angle)];
        
        // Move projectile to actual endpoint
        [sprite runAction:[CCSequence actions:
                           [CCMoveTo actionWithDuration:[self timeToLive] position:[self destination]],
                           [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                           nil]];
        
        [self handleStimulus:stimulusPackage];
    }
    return self;
}


- (void) handleStimulus:(CCArray *) stimulusPackage;
{
    CCParticleSystem * ps;
    
    for(Stimulus * stimulus in stimulusPackage)
    {
        switch ([stimulus type])
        {
            case slow:
                ps = [[CCParticleSun node] retain];
                [ps setTag:7];
                [self addChild:ps];
                ps.startSize = 15;
                ccColor4F startColorIce = {0.38, 0.698, 0.8, 1.0};
                ps.startColor= startColorIce;
                ps.position = sprite.position;
                
                
                // Move Particle system to actual endpoint
                [ps runAction:[CCSequence actions:
                               [CCMoveTo actionWithDuration:[self timeToLive] position:[self destination]],
                               //[CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
                break;
            case dot:
                ps = [[CCParticleSun node] retain];
                [self addChild:ps];
                //          Wildfire alternative
                ccColor4F startColorWildfire = {0.38, 0.698, 0.267, 1.0};
                ps.startColor= startColorWildfire;
                
                //          Wildfire alternative (End)
                ps.startSize = 15;
                ps.position = sprite.position;
                
                // Move Particle system to actual endpoint
                [ps runAction:[CCSequence actions:
                               [CCMoveTo actionWithDuration:[self timeToLive] position:[self destination]],
                               //[CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
                break;
            case pushBack:
                ps = [[CCParticleSun node] retain];
                [self addChild:ps];
                ccColor4F startColorPushBack = {0.035, 0.027, 0.09, 1.0};
                ps.startColor= startColorPushBack;
                ps.startSize = 15;
                ps.position = sprite.position;
                
                // Move Particle system to actual endpoint
                [ps runAction:[CCSequence actions:
                               [CCMoveTo actionWithDuration:[self timeToLive] position:[self destination]],
                               //[CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
                break;
            default:
                break;
        }
    }
}

@end
