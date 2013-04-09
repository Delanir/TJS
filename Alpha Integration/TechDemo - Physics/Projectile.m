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
    [self removeChild:sprite cleanup:YES];
    [[CollisionManager shared] removeFromProjectiles:self];
}

- (id) initWithSprite:(NSString *)spriteFile andLocation:(CGPoint)location andWindowSize:(CGSize)winSize
{
    if( (self=[super init])) {
        
        [self setSprite:spriteFile];
        [self addChild:sprite];
        
        self.position = ccp(70, winSize.height/2 + 10);                 // @TODO init with yuri information
        CGSize spriteSize = [self spriteSize];
        
        // Determine offset of location to projectile
        int offX = location.x - self.position.x;
        int offY = location.y - self.position.y;
        
        // Bail out if we are shooting down or backwards
        if (offX <= 0) return nil;
        
        // Determine where we wish to shoot the projectile to
        int realX = winSize.width + (spriteSize.width/2);
        float ratio = (float) offY / (float) offX;
        int realY = (realX * ratio) + self.position.y;
        CGPoint realDest = ccp(realX, realY);
        
        // Determine the length of how far we're shooting
        int offRealX = realX - self.position.x;
        int offRealY = realY - self.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 480/1; // 480pixels/1sec
        float realMoveDuration = length/velocity;
        
        // Rotate the arrow in the correct direction
        float angle = CC_RADIANS_TO_DEGREES(atanf((float)offRealY / (float)offRealX));
        [self setRotation:(-1 * angle)];
        
        // Move projectile to actual endpoint
        [self runAction:[CCSequence actions:
                         [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                         [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                         nil]];
        
        
    }
    
    return self;
    
}



@end
