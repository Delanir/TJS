//
//  InstantEffect.h
//  L'Archer
//
//  Created by jp on 07/05/13.
//
//

#import "cocos2d.h"
#import "Registry.h"
#import "LevelLayer.h"

@interface InstantEffect : CCNode
{
    CCSequence *instantAction;
    CGPoint effectPos;
    BOOL effectEnded;
}

@property (nonatomic, retain) CCSequence *instantAction;
@property CGPoint effectPos;
@property BOOL effectEnded;

-(id) initWithPosition: (CGPoint) position;
-(void) performAction;
-(void) clearEffect;
-(void) update;

@end
