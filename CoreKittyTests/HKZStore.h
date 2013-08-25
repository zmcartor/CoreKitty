//
//  HKZStore.h
//  CoreKitty
//
//  Created by zm on 8/24/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKZStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
