//
//  Config.h
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
{
    NSDictionary *data;
    
}

+(Config*)shared;
#warning criar classe utils
+(BOOL)iPadRetina;
-(void)dummyMethod;
-(NSString*)getStringProperty:(NSString*) key;
-(int)getIntProperty:(NSString*) key;
-(NSNumber*)getNumberProperty:(NSString*) key;

@end