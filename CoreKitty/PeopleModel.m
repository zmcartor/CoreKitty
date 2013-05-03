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
// Throw our magic methods via class extension to avoid 'incomplete impl' warnings
+ (NSArray *)findByFirstName:(NSString *)name;
@end

@implementation PeopleModel

// throw data into CD
+ (int)populatePeople {
    
    HKZAppDelegate *appDelegate = (HKZAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *resource = [bundle pathForResource:@"People" ofType:@"json"];
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:resource];
    
    NSError *error = nil;
    NSArray *peopleArray = [NSJSONSerialization JSONObjectWithData:JSONData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&error];
    
    PeopleModel *peopleModel;
    for (NSDictionary *person in peopleArray) {
        peopleModel = [[PeopleModel alloc] modelFromDictionaryInContext:@"People" dictionary:person context:context];
    }
        
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"People"];
    [request setIncludesSubentities:YES];
    
    NSArray *simpsons = [context executeFetchRequest:request error:&error];
    NSLog(@"Found %d simpsons records! :D", [simpsons count]);
    
    NSArray *blah = [PeopleModel findByFirstName:@"Homer"];
    
    // to try - does it hit method missing again when
    // calling findByName ?
    // what about thread safty ?
    
    NSLog(@"tada %@", blah);
    
    return [blah count];
}

+ (int)countPeople {
    HKZAppDelegate *appDelegate = (HKZAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"People"];
    // could add predicate here ...
    
    NSError *error;
    NSArray *simpsons = [context executeFetchRequest:request error:&error];
    NSLog(@"Found %d simpson records! :D", [simpsons count]);
    return [simpsons count];
}


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
