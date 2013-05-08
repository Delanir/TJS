//
//  PushbackExplosion.m
//  L'Archer
//
//  Created by jp on 08/05/13.
//
//

#import "PushbackExplosion.h"

@implementation PushbackExplosion

@synthesize radius;

- (id) initWithPosition: (CGPoint) position andRadius: (double) rad
{
    if (self = [super initWithPosition:position])
    {
        radius = rad;
        
    }
    return self;
}

- (void) performAction
{
    CCParticleExplosion * explosion = [[CCParticleExplosion alloc] init];
    [explosion setPosition:effectPos];
    [explosion setAutoRemoveOnFinish:YES];
    
    [explosion setTotalParticles:809];
    [explosion setLife: 0.186 * radius];
    [explosion setLifeVar: 0.2 * radius];
    [explosion setStartSize:34];
    [explosion setStartSizeVar:10];
    [explosion setEndSize:9];
    [explosion setEndSizeVar:5];
    [explosion setAngle:360];
    [explosion setAngleVar:360];
    [explosion setStartSpin:0];
    [explosion setStartSpinVar:0];
    [explosion setEndSpin:0];
    [explosion setEndSpinVar:0];
    
    [explosion setEmitterMode:kCCParticleModeGravity];
    [explosion setDuration:0.1];
    
    [explosion setSpeed:243];
    [explosion setSpeedVar:1];
    [explosion setGravity:ccp(1.15, 1.58)];
    [explosion setRadialAccel:0];
    [explosion setRadialAccelVar:0];
    [explosion setTangentialAccel:0];
    [explosion setTangentialAccelVar:0];
    
    [explosion setStartColor: ccc4f(0.035, 0.027, 0.09, 1.0)];
    [explosion setEndColor:ccc4f(0, 0.0, 0.0, 0.84)];
    [explosion setStartColorVar:ccc4f(0.0, 0.1, 0.0, 0.5)];
    [explosion setEndColorVar:ccc4f(0, 0, 0, 0)];
    
    [explosion setBlendFunc:(ccBlendFunc){GL_SRC_ALPHA, GL_ONE}];
    [explosion setTexture: [[CCTextureCache sharedTextureCache] addImage:@"ccbParticleStars.png"]];
    
    [self addChild:explosion z:[self zOrder]];
    [explosion release];
}


- (void) update
{
    if ([[self children] count] == 0)
        [self setEffectEnded:YES];
    
    [super update];
}

@end
