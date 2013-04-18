//
//  EnemyFactory.m
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import "EnemyFactory.h"

@implementation EnemyFactory

static EnemyFactory* _sharedSingleton = nil;

+(EnemyFactory*)shared
{
	@synchronized([EnemyFactory class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([EnemyFactory class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
    
    }
	return self;
}



-(Peasant*)generatePeasant
{
    Peasant *peasant = [[Peasant alloc] initWithSprite:@"p_walk01.png"];
    [peasant placeRandomly];
    [peasant setupActions];
    
    [peasant autorelease];
    
    return peasant;
        
}

-(FaerieDragon*)generateFaerieDragon
{
    FaerieDragon *faerieDragon = [[FaerieDragon alloc] initWithSprite:@"fd_fly01.png"];
    [faerieDragon placeRandomly];
    [faerieDragon setupActions];
    
    [faerieDragon autorelease];
    
    return faerieDragon;
    
}

-(Zealot*)generateZealot
{
    Zealot *zealot = [[Zealot alloc] initWithSprite:@"z_walk01.png"];
    [zealot placeRandomly];
    [zealot setupActions];
    
    [zealot autorelease];
    
    return zealot;
    
}

-(Enemy*)generateEnemyWithType:(NSString*) type vertical:(int) vpos displacement:(CGPoint) disp;
{
    Enemy * enemy = nil;
    //NSLog(@"Enemy: %@ Vert: %d Disp:(%f,%f)", type, vpos, disp.x, disp.y);
    
    if([type isEqualToString:@"peasant"])
        enemy = [[Peasant alloc] initWithSprite:@"p_walk01.png"];
    
    else if([type isEqualToString:@"faerie"])
        enemy = [[FaerieDragon alloc] initWithSprite:@"fd_fly01.png"];
    
    else if([type isEqualToString:@"zealot"])
        enemy = [[Zealot alloc] initWithSprite:@"z_walk01.png"];
    
    else return nil;
    
#warning Falta normalizar a velocidade e testar sem os aleatórios
    // placement
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGSize spriteSize = [[enemy sprite] contentSize];
    
    float x = winSize.width + (spriteSize.width/2) + (disp.x * spriteSize.width);
    float y = vpos + (disp.y * spriteSize.height);
    
    [enemy sprite].position = ccp(x,y);
    
    [enemy setupActions];
    [enemy autorelease];
    
    return enemy;
}

-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}

@end