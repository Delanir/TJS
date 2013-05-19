//
//  Snow.m
//  L'Archer
//
//  Created by jp on 19/05/13.
//
//

#import "Snow.h"
//#import "LevelLayer.h"
//#import "Registry.h"

@implementation Snow

- (void) performAction
{
    [self setZOrder:1000];
    
    CCParticleSnow * snow = [[CCParticleSnow alloc] init];
    [snow setPosition:ccp(512,768)];
    [snow setPosVar:ccp(512,0)];
    [snow setAutoRemoveOnFinish:YES];
    
    [snow setTotalParticles:175];
    [snow setLife: 4.5];
    [snow setLifeVar: 0];
    [snow setStartSize:3];
    [snow setStartSizeVar:10];
    [snow setEndSize:8];
    [snow setEndSizeVar:0];
    [snow setAngle:265];
    [snow setAngleVar:0];
    
    [snow setEmitterMode:kCCParticleModeGravity];
    [snow setDuration:-1.0];
    
    [snow setSpeed:125];
    [snow setSpeedVar:30];
    [snow setGravity:ccp(0, -10)];
    
    [snow setStartColor: ccc4f(1, 1, 1, 1)];
    [snow setEndColor:ccc4f(1, 1, 1, 0.46)];
    [snow setStartColorVar:ccc4f(0, 0, 0, 0.9)];
    [snow setEndColorVar:ccc4f(0, 0, 0, 0.24)];
    
    [snow setBlendFunc:(ccBlendFunc){GL_ONE, GL_ONE}];
    [snow setTexture: [[CCTextureCache sharedTextureCache] addImage:@"ccbParticleSnow.png"]];
    
    [self addChild:snow z:[self zOrder]];
    [snow release];
}


- (void) update
{
    //LevelLayer * levellayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    //if (levellaye)
    //    [self setEffectEnded:YES];
    
    [super update];
}


@end

