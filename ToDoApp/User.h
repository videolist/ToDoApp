//
//  User.h
//  ToDoApp
//
//  Created by Vadim on 7/21/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"

@class TodoItem;

@interface User : SMUserManagedObject {
}

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate * createdate;
@property (nonatomic, retain) NSDate * lastmoddate;
@property (nonatomic, retain) NSSet *todos;

+ (void) loginWithCashedCredentialsAndCompletionBlock: (void (^)(bool Success))block;;
+ (void) loginWithUserName: (NSString*) username andPassword: (NSString*) password withCompletionBlock: (void (^)(bool Success))block;
+ (void) createNewUserWithName: (NSString*) username andPassword: (NSString*) password withCompletionBlock: (void (^)(bool Success))block;
+ (bool) loggedin;
+ (void) addTodosObject:(TodoItem *)value withCompletionBlock:(void (^)(bool))block ;
+ (void) removeTodosObject:(TodoItem *)value withCompletionBlock:(void (^)(bool))block ;
+ (NSSet*) todos;
+ (NSString*) username;

@end


@interface User (CoreDataGeneratedAccessors)

- (void)addTodosObject:(TodoItem *)value;
- (void)removeTodosObject:(TodoItem *)value;
- (void)addTodos:(NSSet *)values;
- (void)removeTodos:(NSSet *)values;

@end
