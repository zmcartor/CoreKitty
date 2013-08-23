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
    return 20;
}



# pragma mark - Core Kitty internal functions

+ (BOOL)fieldWithinEntity:(NSString *)fieldname context:(NSManagedObjectContext *)context {
    if(kittyFieldList) {
        return (BOOL)([kittyFieldList valueForKey:fieldname]);
    }
    
    NSString * entityName = [self entityName];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    
    // Grab all the attributes in a Dictionary
    kittyFieldList = [entity attributesByName];
    return (BOOL)([kittyFieldList valueForKey:fieldname]);
}

+ (NSString *)entityName {
    if (kittyEntityName) {
        return kittyEntityName;
    }
    
    // Core Data entities do NOT have to match class names.
    NSString *myName = NSStringFromClass([self class]);
    id dele = [UIApplication sharedApplication].delegate;
    NSManagedObjectModel *model = [dele managedObjectModel];
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