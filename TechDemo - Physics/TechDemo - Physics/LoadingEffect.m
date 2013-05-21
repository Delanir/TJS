//
//  LoadingEffect.m
//  L'Archer
//
//  Created by jp on 26/04/13.
//
//

#import "LoadingEffect.h"
#import "SpriteManager.h"
#import "Registry.h"

@implementation LoadingEffect


-(id) init
{
    if(self = [super init])
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        [self setZOrder:1000];
        CCParticleMeteor * spiral = [[CCParticleMeteor alloc] init];
        
        [spiral setPosition:ccp(650,768)];
        [spiral setPosVar:ccp(500,100)];
        [spiral setAutoRemoveOnFinish:YES];
        
        [spiral setTotalParticles:100];
        [spiral setLife: 3];
        [spiral setLifeVar: 1.2];
        [spiral setStartSize:44];
        [spiral setStartSizeVar:30];
        [spiral setEndSize:100];
        [spiral setEndSizeVar:0];
        [spiral setAngle:98];
        [spiral setAngleVar:117];
        [spiral setStartSpin:-300];
        [spiral setStartSpinVar:0];
        [spiral setEndSpin:-154];
        [spiral setEndSpinVar:-90];
        
        [spiral setEmitterMode:kCCParticleModeGravity];
        [spiral setDuration:-1.0];
        
        [spiral setSpeed:1];
        [spiral setSpeedVar:1];
        [spiral setGravity:ccp(-200, -900)];
        
        [spiral setRadialAccel: -800];
        [spiral setRadialAccelVar: -650];
        [spiral setTangentialAccel:-300];
        [spiral setTangentialAccelVar:3];
        
        [spiral setStartColor: ccc4f(0.64, 0.32, 0.0, 0.62)];
        [spiral setEndColor:ccc4f(0.27, 0.18, 0.0, 0.95)];
        [spiral setStartColorVar:ccc4f(0.5, 0.26, 0.5, 0.30)];
        [spiral setEndColorVar:ccc4f(0.5, 0.25, 0.11, 0.64)];
        
        [spiral setBlendFunc:(ccBlendFunc){GL_SRC_ALPHA, GL_DST_ALPHA}];
        
        CCSprite * spr = [CCSprite spriteWithSpriteFrameName:@"ccbParticleNeedle.png"];
        CGRect rect = [spr textureRect];
        
      //  CCTexture2D * texture =
        [spiral setTexture:[spr texture] withRect:rect] ;
        
        [self addChild:spiral z:[self zOrder]];
        [spiral release];


    }
    return self;
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}



@end
