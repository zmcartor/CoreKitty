//
//  PeopleModel.m
//  CoreKitty
//
//  Created by zm on 4/29/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "PeopleModel.h"
#import "HKZAppDelegate.h"

@interface PeopleModel ()
@end

@implementation PeopleModel

- (id)modelFromDictionaryInContext:(NSString *)modelName dictionary:(NSDictionary *)jsonDict
                           context:(NSManagedObjectContext *)context{
    
    id model = [NSEntityDescription
                insertNewObjectForEntityForName:modelName
                inManagedObjectContext:context];
    
    NSDictionary *modelAttribues = [[model entity] attributesByName];
    
    //Grab the Core Data 'entity' description
    //Set known keys from the JSON dictionary
    
    NSString *descriptionFieldname = [[modelName lowercaseString] stringByAppendingString:@"_description"];
    for (NSString *attribute in modelAttribues) {
        
        // In the event of 'description' json field, the model should have a field
        // called modelName_description. Check for this field and assign value
        if ([attribute isEqualToString:descriptionFieldname]) {
            [model setValue:[jsonDict valueForKey:@"description"] forKey:descriptionFieldname];
            continue;
        }
        
        id value = [jsonDict objectForKey:attribute];
        if(value == nil || value == [NSNull null]){
            continue;
        }
        
        [model setValue:value forKey:attribute];
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", error);
        return nil;
    }
    
    return model;
}

@dynamic firstName;
@dynamic lastName;

@end
