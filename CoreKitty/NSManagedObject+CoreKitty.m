//
//  NSManagedObject+CoreKitty.m
//  CoreKitty
//
//  Created by zm on 4/29/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "NSManagedObject+CoreKitty.h"
#import <objc/runtime.h>
#import "HKZAppDelegate.h"
@implementation NSManagedObject (CoreKitty)

static NSString *kittyEntityName;
static NSDictionary *kittyFieldList;

+ (int)countRecordsInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self entityNameinContext:context]];
    [request setIncludesSubentities:NO];
    NSError *error;
    [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"CoreKitty: and error occured - %@", error);
    }
    int count = [context countForFetchRequest:request error:&error];
    if (error) {
        NSLog(@"CoreKitty: and error occured - %@", error);
        return 0;
    }
    return count;
}


# pragma mark - Core Kitty internal functions

+ (BOOL)fieldWithinEntity:(NSString *)fieldname context:(NSManagedObjectContext *)context {
    if(kittyFieldList) {
        return (BOOL)([kittyFieldList valueForKey:fieldname]);
    }
    
    NSString * entityName = [self entityNameinContext:context];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    
    // Grab all the attributes in a Dictionary
    kittyFieldList = [entity attributesByName];
    return (BOOL)([kittyFieldList valueForKey:fieldname]);
}

+ (NSString *)entityNameinContext:(NSManagedObjectContext *)moc {
    if (kittyEntityName) {
        return kittyEntityName;
    }
    
    // Core Data entities do NOT have to match class names.
    NSString *myName = NSStringFromClass([self class]);
    NSManagedObjectModel *model = moc.persistentStoreCoordinator.managedObjectModel;
    for (NSEntityDescription *description in model.entities) {
        if ([description.managedObjectClassName isEqualToString:myName]) {
            kittyEntityName = description.name;
            return description.name;
        }
    }
    [NSException raise:NSInvalidArgumentException
                format:@"no entity found that uses %@ as its class", myName];
    return nil;
}
@end