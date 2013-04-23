//
//  Registry.m
//  L'Archer
//
//  Created by jp on 17/04/13.
//
//

#import "Registry.h"

@implementation Registry

@synthesize registry,lastScene;

static Registry* _sharedSingleton = nil;

+(Registry*)shared
{
	@synchronized([Registry class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([Registry class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init
{
	self = [super init];
	if (self != nil) {
		// initialize stuff here
        registry = [[NSMutableDictionary alloc] init];
    }
	return self;
}


-(void)dealloc
{
    [registry release];
    [_sharedSingleton release];
    [super dealloc];
}

-(void) registerEntity: (id) entity withName: (NSString *) name
{
    [registry setObject:entity forKey:name];
}

-(id) getEntityByName: (NSString *) entityName
{
    return [registry objectForKey:entityName];
}

-(BOOL) entityAlreadyRegistered: (NSString *) name
{
    return([registry objectForKey:name]);
}

-(void) clearRegistry
{
    [registry removeAllObjects];
    //[registry dealloc];
    //registry = [[NSMutableDictionary alloc] init];
}

-(void) printRegistry
{
    NSLog(@"Entities in the registry");
    NSLog(@"%@", [registry allValues]);
}

@end