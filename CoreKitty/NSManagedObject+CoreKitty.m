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
static NSString *kittyFieldSelector;
static NSManagedObjectContext *context;

+ (BOOL)resolveClassMethod:(SEL)name {
    // determine if the selector is a valid one for this entity.
    // if it is, then dispatch to the function to figure out query
    if ([self validKittySelector: NSStringFromSelector(name)]) {
        // adding class method to meta-class
        NSString *classname = [NSString stringWithFormat:@"%@", [self class]];
        Class ourClass = object_getClass(NSClassFromString(classname));
        class_addMethod(ourClass, name, (IMP)determineTypeDispatch, "@v:@");
        return YES;
    }
    return [super resolveClassMethod:name];
}

+ (BOOL)validKittySelector:(NSString *)stringSelector {
    NSRange beacon = [stringSelector rangeOfString:@"findBy"];
    if(beacon.length){
        NSString *field = [[stringSelector substringFromIndex:NSMaxRange(beacon)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        field = [field stringByReplacingOccurrencesOfString:@":" withString:@""];
        field =  [field stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[field substringToIndex:1] lowercaseString]];
        if([self fieldWithinEntity:field]) {
            kittyFieldSelector = field;
            return YES;
        }
    }
    return NO;
}

+ (BOOL)fieldWithinEntity:(NSString *)fieldname {
    NSString * entityName = [self entityName];
    // determine the fields and types from here
    id dele = [UIApplication sharedApplication].delegate;
    context = [dele managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    
    
    // Grab all the attributes in a Dictionary
    NSDictionary *attributes = [entity attributesByName];
    return (BOOL)([attributes valueForKey:fieldname]);
}

id determineTypeDispatch(id self, SEL _cmd, id param) {
    NSString *stringSelector = NSStringFromSelector(_cmd);
    NSLog(@"In a method!!! %@ %@", self, stringSelector);
    NSLog(@"some param %@", param);
   
    NSArray *s = [self findByRequest:kittyFieldSelector by:param];
    return s;
}

// this method could be it's own thing on it's own ;)
+ (NSArray *)findByRequest:(NSString *)field by:(id)thing {
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:kittyEntityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K = %@)", field, thing];
    [fetch setPredicate:predicate];
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetch error:&error];
    if(error){
        NSLog(@"ohno error! %@", error);
    }
    return results;
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