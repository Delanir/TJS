//
//  Config.h
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface Config : NSObject
{
    NSDictionary *data;
    
}

+(Config*)shared;

-(void)dummyMethod;
-(NSString*)getStringProperty:(NSString*) key;
-(int)getIntProperty:(NSString*) key;
-(NSNumber*)getNumberProperty:(NSString*) key;
-(NSArray*)getArrayProperty:(NSString*) key;

@end