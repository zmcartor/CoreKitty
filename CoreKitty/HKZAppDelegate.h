//
//  HKZAppDelegate.h
//  CoreKitty
//
//  Created by zm on 5/3/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
