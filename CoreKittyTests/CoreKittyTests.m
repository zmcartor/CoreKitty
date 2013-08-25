//
//  CoreKittyTests.m
//  CoreKittyTests
//
//  Created by zm on 8/18/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "Kiwi.h"
#import "HKZStore.h"
#import "PeopleModel.h"

SPEC_BEGIN(CoreKitty)

describe(@"CoreKitty", ^{
    
    // Load up the fake Simpsons JSON
    HKZStore *store = [[HKZStore alloc] init];
    __block NSManagedObjectContext *managedObjectContext = store.managedObjectContext;
  
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *resource = [bundle pathForResource:@"People" ofType:@"json"];
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:resource];
    
    NSError *error = nil;
    NSArray *peopleArray = [NSJSONSerialization JSONObjectWithData:JSONData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
    for (NSDictionary *person in peopleArray) {
        [[PeopleModel alloc] modelFromDictionaryInContext:@"People" dictionary:person context:managedObjectContext];
    }
    
    
    it(@"counts the number of records", ^{
        NSManagedObjectContext *managedObjectContext = store.managedObjectContext;
        int count = [PeopleModel countRecordsInContext:managedObjectContext];
        [[theValue(count) should] equal:theValue(20)];
    });
    
    it (@"throws an exception if field name not found in Core Data model", ^{
        
    });
    
    
    context(@"finders for given field and condition", ^{
    
        it(@"finds all records matching a string type field", ^{
            
        });
        
        it(@"finds all records matching an integer type field", ^{
            
        });
        
        it(@"finds all records matching a Boolean type field", ^{
            
        });

        it(@"finds all records matching a date type field", ^{
            
        });

        it(@"finds all records matching a field with integer value", ^{
            
        });
        
    });
    
    context(@"count functions for given field and condition", ^{
        
        it(@"counts records matching a string type field", ^{
            
        });
        
        it(@"counts records matching an integer type field", ^{
            
        });
        
        it(@"counts records matching a Boolean type field", ^{
            
        });
        
        it(@"counts records matching a date type field", ^{
            
        });
        
        it(@"counts records matching a field with integer value", ^{
            
        });
        
    });
    
    context (@"provides aggregate functions", ^{
        it(@"computes the min of a given field", ^{
        });
        
        it(@"computes the max of a given field", ^{
        });
        
        it(@"computes the average of a given field", ^{
        });
        
    });
});

SPEC_END