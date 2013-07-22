//
//  TodoItem.m
//  ToDoApp
//
//  Created by Vadim on 7/20/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import "TodoItem.h"


@implementation TodoItem

@dynamic timeStamp;
@dynamic title;
@dynamic dueDate;
@dynamic priority;
@dynamic completed;
@dynamic todoId;
@dynamic createddate;
@dynamic lastmoddate;
@dynamic owner;

+ (NSString*) stringForDate:(NSDate *)date {
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MM/dd/YYYY" options:0
                                                              locale:[NSLocale currentLocale]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:date];
}

+ (NSString*) stringForPriority:(NSNumber*)priority {
    switch ([priority intValue]) {
        case lowPriority:
            return @"Low";
            break;
            
        case mediumPriority:
            return @"Medium";
            break;
            
        case highPriority:
            return @"High";
            break;
            
        default:
            NSAssert(0, @"Unknown priority value");
            return nil;
            break;
    }
    
}

- (void) setTimeStamp:(NSDate *)newTimeStamp {
    if ( !self.dueDate )
        self.dueDate = newTimeStamp;
}

@end
