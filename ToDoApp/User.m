//
//  User.m
//  ToDoApp
//
//  Created by Vadim on 7/21/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import "User.h"
#import "TodoItem.h"
#import "NSManagedObjectContext+Concurrency.h"
#import "NSManagedObject+StackMobSerialization.h"

#define USER_NAME_KEY @"username"
#define PASSWORD_KEY @"password"

static NSManagedObject* _userObject;

@implementation User

@synthesize username;
@dynamic createdate;
@dynamic lastmoddate;
@dynamic todos;


+ (void) createNewUserWithName:(NSString *)username andPassword:(NSString *)password withCompletionBlock:(void (^)(bool))block {
    NSManagedObjectContext *context = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    User *newUser = [[User alloc] initNewUserInContext:context];
    [newUser setUsername:username];
    [newUser setPassword:password];
    
    [context saveOnSuccess:^{
        // Saved the user object
        NSLog(@"Created new user %@", username);
        // result contains a dictionary representation of the user object
        [[NSUserDefaults standardUserDefaults] setValue:username forKey:USER_NAME_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:PASSWORD_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self loginWithUserName:username andPassword:password withCompletionBlock:^(bool Success) {
            if ( Success ) {
                _userObject = [self fetchUser:username];
                block(true);
            } else {
                NSLog(@"Failed logging in");
                block(false);
            }
        }];
    } onFailure:^(NSError *error){
        // Error
        NSLog(@"Failed creating new user %@", username);
        block(false);
    }];
}

+ (void) loginWithCashedCredentialsAndCompletionBlock: (void (^)(bool Success))block {
    NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_KEY];
    NSString* password = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD_KEY];
    if( username && password ) {
        [self loginWithUserName:username andPassword:password withCompletionBlock:^(bool Success) {
            block(Success);
        }];
    } else {
        block(false);
    }
}

+ (void) loginWithUserName:(NSString *)username andPassword:(NSString *)password withCompletionBlock:(void (^)(bool))block {
    [[SMClient defaultClient] loginWithUsername:username password:password onSuccess:^(NSDictionary *result){
        [[NSUserDefaults standardUserDefaults] setValue:username forKey:USER_NAME_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:PASSWORD_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _userObject = [self fetchUser:username];
        block(true);
    } onFailure:^(NSError * error){
        // Error
        block(false);
    }];
}

- (id)initNewUserInContext:(NSManagedObjectContext *)context {
    
    self = [super initWithEntityName:@"User" insertIntoManagedObjectContext:context];
    
    if (self) {
    }
    
    return self;
}

+ (NSManagedObject*) fetchUser: (NSString*) username {
    
    NSFetchRequest *userFetch = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    [userFetch setPredicate:[NSPredicate predicateWithFormat:@"username == %@", username]];
    NSManagedObjectContext *context = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    NSError* error;
    NSArray* results = [context executeFetchRequest:userFetch error:&error];
    if ( !error )
        return [results lastObject];
    
    return nil;
}

+ (bool) loggedin {
    if ( [[SMClient defaultClient] isLoggedIn] ) {
        NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_KEY];
        if ( !_userObject )
            _userObject = [self fetchUser:username];
        return true;
    }
    
    return false;
}

+ (void) addTodosObject:(TodoItem *)value withCompletionBlock:(void (^)(bool))block {
    if ( _userObject ) {
        NSSet* todos = [_userObject valueForKey:@"todos"];
        NSMutableSet* newTodos;
        if ( [todos count] )
            newTodos = [NSMutableSet setWithSet:todos];
        else
            newTodos = [NSMutableSet setWithCapacity:0];
        [newTodos addObject:value];
        [_userObject setValue:newTodos forKey:@"todos"];
        NSManagedObjectContext *context = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
        [context saveOnSuccess:^{
            NSLog(@"Todo item added succesfully");
            block(true);
        } onFailure:^(NSError *error) {
            NSLog(@"Error adding todo value");
            block(false);
        }];
    }
}

+ (NSSet*) todos {
    if ( _userObject )
        return [_userObject valueForKey:@"todos"];
    return nil;
}

+ (void) removeTodosObject:(TodoItem *)value withCompletionBlock:(void (^)(bool))block {
    if ( _userObject ) {
        NSSet* todos = [_userObject valueForKey:@"todos"];
        NSMutableSet* newTodos;
        if ( [todos count] ) {
            newTodos = [NSMutableSet setWithSet:todos];
            [newTodos removeObject:value];
            [_userObject setValue:newTodos forKey:@"todos"];
            NSManagedObjectContext *context = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
            [context saveOnSuccess:^{
                NSLog(@"Todo item removed succesfully");
                block(true);
            } onFailure:^(NSError *error) {
                NSLog(@"Error removing todo value");
                block(false);
            }];
        }
    }
}

+ (NSString*) username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_KEY];
}

@end
