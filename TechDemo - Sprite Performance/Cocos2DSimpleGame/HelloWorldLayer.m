//
//  HelloWorldLayer.m
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 11/13/12.
//  Copyright Razeware LLC 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "GameOverLayer.h"

//Audio

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (void) addMonster: (CGPoint) location {
    CCSprite * monster = [CCSprite spriteWithFile:@"monster.png"];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array ];
    for (int i=1; i<=8; ++i) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bear%d.png", i ]]];
    }
    
    CCAnimation * walkAnim =[CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
    
    //[CCAnimation animationWithAnimationFrames:walkAnimFrames delayPerUnit:0.1 loops:1];
    monster = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];
    CCAction *walkAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [monster runAction:walkAction];
    [self addChild:monster];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = location;
    //[self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 20.0;
    int maxDuration = 40.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMoveR = [CCMoveTo actionWithDuration:actualDuration position:ccp(-monster.contentSize.width/2, location.y)];
    
    CCMoveTo * actionMoveL = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width+monster.contentSize.width/2, location.y)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];
        
        //CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
        //[[CCDirector sharedDirector] replaceScene:gameOverScene];
    }];
    CCCallBlockN * flip = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        ((CCSprite *)node).flipX=YES;
        
    }];
    [monster runAction:[CCSequence actions:actionMoveR, flip, actionMoveL, actionMoveDone, nil]];
    
    monster.tag = 1;
    // z ordering para os ursos nao andarem a cavalgar uns nos outros
    [self reorderChild: monster z: winSize.height - monster.position.y];
    [_monsters addObject:monster];
    
    
}

- (void) addMonster {
    
    CCSprite * monster = [CCSprite spriteWithFile:@"monster.png"];
    
            NSMutableArray *walkAnimFrames = [NSMutableArray array ];
            for (int i=1; i<=8; ++i) {
                [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bear%d.png", i ]]];
            }
    
            CCAnimation * walkAnim =[CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];

    //[CCAnimation animationWithAnimationFrames:walkAnimFrames delayPerUnit:0.1 loops:1];
    monster = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];
    CCAction *walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [monster runAction:walkAction];
    [self addChild:monster];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = monster.contentSize.height / 2;
    int maxY = winSize.height - monster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = ccp(winSize.width + monster.contentSize.width/2, actualY);
    //[self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 20.0;
    int maxDuration = 40.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMoveR = [CCMoveTo actionWithDuration:actualDuration position:ccp(-monster.contentSize.width/2, actualY)];
    
    CCMoveTo * actionMoveL = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width+monster.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];
        
        //CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
        //[[CCDirector sharedDirector] replaceScene:gameOverScene];
    }];
    CCCallBlockN * flip = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        ((CCSprite *)node).flipX=YES;
        
    }];
    [monster runAction:[CCSequence actions:actionMoveR, flip, actionMoveL, actionMoveDone, nil]];
    
    monster.tag = 1;
    // z ordering para os ursos nao andarem a cavalgar uns nos outros
    [self reorderChild: monster z: winSize.height - monster.position.y];
    [_monsters addObject:monster];
    
}

-(void)gameLogic:(ccTime)dt {
    [self addMonster];
}
 
- (id) init
{
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {

        CGSize winSize = [CCDirector sharedDirector].winSize;
        //CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        //player.position = ccp(player.contentSize.width/2, winSize.height/2);
        //[self addChild:player];
        
        [self schedule:@selector(gameLogic:) interval:1.0];
        
        [self setTouchEnabled:YES];
        
        CCSprite * bg= [CCSprite spriteWithFile:@"leBACKGROUNDdamiens.jpg"];
        [bg setPosition:ccp(winSize.width, winSize.height)];
        [self addChild:bg z:0];
        
        
        _monsters = [[NSMutableArray alloc] init];
        //_projectiles = [[NSMutableArray alloc] init];

        [self schedule:@selector(update:)];
        
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bear_default.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"bear_default.png"];
        [self addChild:spriteSheet];
        
        
    }
    return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    [self addMonster:location];
    [[SimpleAudioEngine sharedEngine] playEffect:@"leEVILBEARdamiens.caf"];
    // Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //CCSprite *projectile = [CCSprite spriteWithFile:@"projectile.png"
    //                                           rect:CGRectMake(0, 0, 20, 20)];
    //projectile.position = ccp(20, winSize.height/2);
    
    // Determine offset of location to projectile
    //CGPoint offset = ccpSub(location, projectile.position);
    
    // Bail out if you are shooting down or backwards
    //if (offset.x <= 0) return;
    
    // Ok to add now - we've double checked position
    //[self addChild:projectile];
    
//    int realX = winSize.width + (projectile.contentSize.width/2);
//    float ratio = (float) offset.y / (float) offset.x;
//    int realY = (realX * ratio) + projectile.position.y;
//    CGPoint realDest = ccp(realX, realY);
//    
//    // Determine the length of how far you're shooting
//    int offRealX = realX - projectile.position.x;
//    int offRealY = realY - projectile.position.y;
//    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
//    float velocity = 480/1; // 480pixels/1sec
//    float realMoveDuration = length/velocity;
//    
//    // Move projectile to actual endpoint
//    [projectile runAction:
//     [CCSequence actions:
//      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
//      [CCCallBlockN actionWithBlock:^(CCNode *node) {
//         [_projectiles removeObject:node];
//         [node removeFromParentAndCleanup:YES];
//    }],
//      nil]];
//    
//    projectile.tag = 2;
//    [_projectiles addObject:projectile];
//    
//    [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
}

- (void)update:(ccTime)dt {
    
//    for (CCSprite *monster in _monsters) {
//            
//    }
    
//    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
//    for (CCSprite *projectile in _projectiles) {
//        
//        NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
//        for (CCSprite *monster in _monsters) {
//            
//            if (CGRectIntersectsRect(projectile.boundingBox, monster.boundingBox)) {
//                [monstersToDelete addObject:monster];
//            }
//        }
//        
//        for (CCSprite *monster in monstersToDelete) {
//            [_monsters removeObject:monster];
//            [self removeChild:monster cleanup:YES];
//            
//            _monstersDestroyed++;
//            if (_monstersDestroyed > 30) {
//                CCScene *gameOverScene = [GameOverLayer sceneWithWon:YES];
//                [[CCDirector sharedDirector] replaceScene:gameOverScene];
//            }
//        }
//        
//        if (monstersToDelete.count > 0) {
//            [projectilesToDelete addObject:projectile];
//        }
//        [monstersToDelete release];
//    }
    
//    for (CCSprite *projectile in projectilesToDelete) {
//        [_projectiles removeObject:projectile];
//        [self removeChild:projectile cleanup:YES];
//    }
//    [projectilesToDelete release];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [_monsters release];
    _monsters = nil;
//    [_projectiles release];
//    _projectiles = nil;
    [super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}
@end
