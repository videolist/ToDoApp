//
//  TodoItem.h
//  ToDoApp
//
//  Created by Vadim on 7/20/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum  {
    lowPriority = 0,
    mediumPriority = 1,
    highPriority = 2
} tPriorities;


@interface TodoItem : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSString * todoId;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;

+ (NSString*) stringForDate: (NSDate*) date;
+ (NSString*) stringForPriority: (NSNumber*) priority;

@end
