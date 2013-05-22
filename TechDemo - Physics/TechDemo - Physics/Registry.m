//
//  Registry.m
//  L'Archer
//
//  Created by jp on 17/04/13.
//
//

#import "Registry.h"

@implementation Registry

@synthesize registry, numberOfCreatedEntities, numberOfDestroyedEntities, allEntities;

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
	if (self != nil)
    {
		// initialize stuff here
        registry = [[NSMutableDictionary alloc] init];
        allEntities = [[NSMutableArray alloc] init];
        numberOfDestroyedEntities = 0;
        numberOfCreatedEntities = 0;
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
    }
	return self;
}


-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [registry release];
    [allEntities release];
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
    if([registry objectForKey:name])
        return YES;
    return NO;
}

-(void) clearRegistry
{
    [registry removeAllObjects];
    //[registry dealloc];
    //registry = [[NSMutableDictionary alloc] init];
}


-(void) removeEntityFromRegistry: (NSString*) entity
{
    [registry removeObjectForKey:entity];
}

-(void) printRegistry
{
    NSLog(@"Entities in the registry");
    NSLog(@"%@", [registry allValues]);
}

// Debugging purposes

-(void) addToCreatedEntities: (id) entity;
{
    NSString * className = NSStringFromClass([entity class]);
    
    for ( NSMutableDictionary * entry in allEntities)
    {
        if ([[entry objectForKey:@"Class"] isEqualToString:className])
        {
            NSNumber * amount = [entry objectForKey:@"Amount"];
            amount = [NSNumber numberWithInt: [amount intValue] + 1];
            [entry setObject:amount forKey:@"Amount"];
            numberOfCreatedEntities++;
            return;
        }
    }
    NSMutableDictionary * newClass = [[NSMutableDictionary alloc] init];
    [newClass setObject:className forKey:@"Class"];
    [newClass setObject:[NSNumber numberWithInt:1] forKey:@"Amount"];
    [allEntities addObject:newClass];
    [newClass release];

    numberOfCreatedEntities++;
    
}

-(void) addToDestroyedEntities: (id) entity;
{
    NSString * className = NSStringFromClass([entity class]);
    NSLog(@"Destroyed a %@",className);
    for ( NSMutableDictionary * entry in allEntities)
    {
        if ([[entry objectForKey:@"Class"] isEqualToString:className])
        {
            NSNumber * amount = [entry objectForKey:@"Amount"];
            amount = [NSNumber numberWithInt: [amount intValue] - 1];
            [entry setObject:amount forKey:@"Amount"];
            numberOfDestroyedEntities++;
            return;
        }
    }    
}

-(int) numberOfExistingEntities
{
    return numberOfCreatedEntities - numberOfDestroyedEntities;
}

-(int) numberOfExistingEntitiesInClasses
{
    int count = 0;
    for ( NSMutableDictionary * entry in allEntities)
    {
        NSNumber * amount = [entry objectForKey:@"Amount"];
        count += [amount intValue];
    }
    return count;
}


-(void) printAllExistingEntities
{
    NSLog(@"Existing entities: %d (%d authentic)", [self numberOfExistingEntitiesInClasses], [self numberOfExistingEntities]);
    NSLog(@"Created: %d Destroyed: %d", numberOfCreatedEntities, numberOfDestroyedEntities);
    NSLog(@"\nCleared Entities:");
    for (NSMutableDictionary * class in allEntities)
        if ([[class objectForKey:@"Amount"] intValue] == 0)
            NSLog(@"Class: %@ (%d entities)", [class objectForKey:@"Class"], [[class objectForKey:@"Amount"] intValue]);
    NSLog(@"\nUnresolved Issues:");
    for (NSMutableDictionary * class in allEntities)
        if ([[class objectForKey:@"Amount"] intValue] != 0)
            NSLog(@"Class: %@ (%d entities)", [class objectForKey:@"Class"], [[class objectForKey:@"Amount"] intValue]);
}

@end