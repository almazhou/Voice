//
//  AppDelegate.h
//  Voice
//
//  Created by xzhou on 10/8/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}
@property(strong, nonatomic) UIWindow *window;

- (void)saveContext;

- (NSManagedObjectContext *)managedObjectContext;

- (NSURL *)applicationDocumentsDirectory;

@end
