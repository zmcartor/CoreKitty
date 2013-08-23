//
//  PeopleModel.h
//  CoreKitty
//
//  Created by zm on 4/29/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+CoreKitty.h"


@interface PeopleModel : NSManagedObject

- (id)modelFromDictionaryInContext:(NSString *)modelName dictionary:(NSDictionary *)jsonDict
                           context:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@end
