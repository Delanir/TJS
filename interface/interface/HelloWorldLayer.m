//
//  HelloWorldLayer.m
//  interface
//
//  Created by Ricardo on 3/18/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

CCSprite *arrow;
CGPoint firstTouch;
CGPoint lastTouch;
int mode = 0;

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

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        //Arrow Sprite
        arrow = [CCSprite spriteWithFile:@"arrow.png"];
        arrow.position = ccp(arrow.contentSize.width/2, size.height/2);
        [self addChild:arrow];
        
        [self setIsTouchEnabled:YES];
        
        //Menu Stuff
        CCSprite *shootingMode = [CCSprite spriteWithFile:@"ShootingMode.png"];
        CCMenuItem *starMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"ShootingMode.png" selectedImage:@"ShootingMode.png"
                                    target:self selector:@selector(changeShootMode:)];
        starMenuItem.position = ccp(size.width/2, size.height - shootingMode.contentSize.height/2);
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
	}
	return self;
}

- (void)changeShootMode:(id)sender {
    if (mode == 0) {
        mode = 1;
    } else {
        mode = 0;
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //Swipe Detection Part 1
    firstTouch = location;
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (mode == 0) {
    
    //Choose one ofthe touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    //Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *projectile = [CCSprite spriteWithFile:@"arrow.png"];
    projectile.position = ccp(projectile.contentSize.width/2,winSize.height/2);
    
    //Determine offset of location to projectile
    CGPoint offSet = ccpSub(location, projectile.position);
    
    //Bail out if you are shooting down or backwards
    if (offSet.x <= 0) return;
    
    //Ok to add now - we've double checked position
    [self addChild:projectile];
    
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offSet.y / (float) offSet.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX,realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    float angleRadians = atanf((float)offRealY / (float)offRealX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    projectile.rotation = cocosAngle;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
     }],
      nil]];
        
    } else {
        
        NSSet *allTouches = [event allTouches];
        UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
    
        //Swipe Detection Part 2
        lastTouch = location;
    
        //Minimum length of the swipe
        float swipeLength = ccpDistance(firstTouch, lastTouch);
    
        //Check if the swipe is a left swipe and long enough
        if (firstTouch.x > lastTouch.x && swipeLength > 45) {
            [self shootSwipe];
        }
    }
}

- (void) shootSwipe
{
    
    //Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *projectile = [CCSprite spriteWithFile:@"arrow.png"];
    projectile.position = ccp(projectile.contentSize.width/2,winSize.height/2);
    
    [self addChild:projectile];
    
    CGPoint offSet = ccpSub(lastTouch, firstTouch);
    
    //Tamanho da janela mais do projectil
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offSet.y / (float) offSet.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX,realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    float angleRadians = atanf((float)offRealY / (float)offRealX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    projectile.rotation = cocosAngle;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
     }],
      nil]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
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
