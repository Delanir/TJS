//
//  ElementalExplosion.m
//  L'Archer
//
//  Created by jp on 07/05/13.
//
//

#import "ElementalExplosion.h"

@implementation ElementalExplosion


- (void) performAction
{
    CCParticleExplosion * explosion = [[CCParticleExplosion alloc] init];
    [explosion setPosition:effectPos];
    [explosion setAutoRemoveOnFinish:YES];
    
    [explosion setTotalParticles:1000];
    [explosion setLife: 0.3];
    [explosion setLifeVar: 0.2];
    [explosion setStartSize:34];
    [explosion setStartSizeVar:10];
    [explosion setEndSize:9];
    [explosion setEndSizeVar:5];
    [explosion setAngle:360];
    [explosion setAngleVar:360];
    
    [explosion setEmitterMode:kCCParticleModeGravity];
    [explosion setDuration:0.1];
    
    [explosion setSpeed:300];
    [explosion setSpeedVar:1];
    [explosion setGravity:ccp(1.15, 1.58)];
    
    [explosion setStartColor: ccc4f(0.31, 0.15, 0.0, 1)];
    [explosion setEndColor:ccc4f(0, 0, 0, 0.84)];
    [explosion setStartColorVar:ccc4f(0.2, 0.1, 0.0, 0.5)];
    [explosion setEndColorVar:ccc4f(0, 0, 0, 0)];
    
    [explosion setBlendFunc:(ccBlendFunc){GL_SRC_ALPHA, GL_ONE}];
    [explosion setTexture: [[CCTextureCache sharedTextureCache] addImage:@"defaultEmitter.png"]];
    
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
