//
//  Projectile.m
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Projectile.h"
#import "CollisionManager.h"

@implementation Projectile

-(void)spriteMoveFinished:(id)sender {
    [self removeChild:ps cleanup:YES];
// CCLOG(@"Morreu PS");
// CCLOG(@"Morreu Sprite");
    [self removeChild:sprite cleanup:YES];
    [[CollisionManager shared] removeFromProjectiles:self];
}

- (id) initWithSprite:(NSString *)spriteFile andLocation:(CGPoint)location andWindowSize:(CGSize)winSize
{
    if( (self=[super init])) {
      int type = air;
      
        [self setSpriteWithSpriteFrameName:spriteFile];
        [self addChild:sprite];
      
      switch (type) {
        case fire:
          ps = [[CCParticleSun node] retain];
          [self addChild:ps];
          ps.startSize = 15;
//          ps.gravity = CGPointZero;
//          ps.life = 0;
//          ps.totalParticles = 25;
          break;
        case ice:
          ps = [[CCParticleMeteor node] retain];
          [self addChild:ps];
          ps.startSize = 15;
          ps.gravity = CGPointZero;
//          ps.life = 0;
//          ps.totalParticles = 25;
//          ps.emissionRate = 100;
//          ps.angle = 0;
//          
//            ps.emissionRate = 0.01f;
//          
//            ps.duration = 2.7f;
//            ps.lifeVar = 0.1f;
//            ps.totalParticles = 100;
          break;
        case air:
          ps = [CCParticleSystemQuad particleWithFile:@"Comet.plist"];
//          ccBlendFunc bfMask = ccBlendFunc();
//          bfMask.src = GL_ONE;
//          bfMask.dst = GL_ZERO;
//          ps.blendFunc=ccBlendFunc(GL_SRC_ALPHA);
//          ps = [[CCParticleSmoke node] retain];
          [self addChild:ps];
         ps.startSize = 15;
//          ps.gravity = CGPointZero;
//          ps.life = 0;
//          ps.totalParticles = 25;
          break;
        default: ps = Nil;
          break;
      }
      
      sprite.position = ccp(190, winSize.height/2 + 28);                 // @TODO init with yuri information
      ps.position = ccp(sprite.position.x + sprite.contentSize.width/2,sprite.position.y);
      
        CGSize spriteSize = [self spriteSize];
//        CCLOG(@">>> X: %f  Y: %f\n", sprite.position.x, sprite.position.y);
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
        CGPoint realDest = ccp(realX, realY);
        
        // Determine the length of how far we're shooting
        int offRealX = realX - sprite.position.x;
        int offRealY = realY - sprite.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 480/1; // 480pixels/1sec
        float realMoveDuration = length/velocity;
        
        // Rotate the arrow in the correct direction
        float angle = CC_RADIANS_TO_DEGREES(atanf((float)offRealY / (float)offRealX));
        [sprite setRotation:(-1 * angle)];
        
   
      
      // Move Particle system to actual endpoint
      [ps runAction:[CCSequence actions:
                         [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                         //[CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                         nil]];
      
      // Move projectile to actual endpoint
      [sprite runAction:[CCSequence actions:
                         [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                         [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                         nil]];
      
    }
    
    return self;
    
}

- (void) destroyParticleSystem
{
  [self removeChild:ps cleanup:YES];
}

//-(void)addStimulous



@end
