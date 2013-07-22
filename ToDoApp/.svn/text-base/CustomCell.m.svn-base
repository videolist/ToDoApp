//
//  CustomCell.m
//  ToDoApp
//
//  Created by Vadim on 7/19/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import "CustomCell.h"
#import "TodoItem.h"

@implementation CustomCell

- (void) setTodoItem: (TodoItem*) newTodoItem {
    if (_todoItem ) {
        //Remove observers for the previous item
        [_todoItem removeObserver:self forKeyPath:@"dueDate"];
        [_todoItem removeObserver:self forKeyPath:@"priority"];
        [_todoItem removeObserver:self forKeyPath:@"title"];
        [_todoItem removeObserver:self forKeyPath:@"completed"];
    }
    
    _todoItem = newTodoItem;
    if ( _todoItem ) {
        self.title.text = @"";
        [_todoItem addObserver:self forKeyPath:@"dueDate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
        [_todoItem addObserver:self forKeyPath:@"priority" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
        [_todoItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
        [_todoItem addObserver:self forKeyPath:@"completed" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqual:@"dueDate"]) {
        if ( ! [[change objectForKey:NSKeyValueChangeNewKey] isKindOfClass:[NSNull class]] ) {
            [self.dueDateButton setTitle:[TodoItem stringForDate:[change objectForKey:NSKeyValueChangeNewKey]] forState:UIControlStateNormal];
            [self.dueDateButton setTitle:[TodoItem stringForDate:[change objectForKey:NSKeyValueChangeNewKey]] forState:UIControlStateHighlighted];
        }
        
    } else if ([keyPath isEqual:@"priority"]) {
        if ( ! [[change objectForKey:NSKeyValueChangeNewKey] isKindOfClass:[NSNull class]] ) {
            [self.priorityButton setTitle:[TodoItem stringForPriority:[change objectForKey:NSKeyValueChangeNewKey]] forState:UIControlStateNormal];
            [self.priorityButton setTitle:[TodoItem stringForPriority:[change objectForKey:NSKeyValueChangeNewKey]] forState:UIControlStateHighlighted];
        }
    } else if ([keyPath isEqual:@"title"]) {
        if ( ! [[change objectForKey:NSKeyValueChangeNewKey] isKindOfClass:[NSNull class]] ) {
            self.title.text = [change objectForKey:NSKeyValueChangeNewKey];
        }
    } else if ([keyPath isEqual:@"completed"]) {
        if ( ! [[change objectForKey:NSKeyValueChangeNewKey] isKindOfClass:[NSNull class]] ) {
            self.checkMarkImageView.hidden = ![[change objectForKey:NSKeyValueChangeNewKey] intValue];
        }
    }
}

- (IBAction)dueDateAction:(id)sender {
    if ( self.datePicker.hidden == YES ) {
        [[self superview] addSubview:self.datePicker];
        [[self superview] bringSubviewToFront:self.datePicker];
        CGRect frame = self.datePicker.frame;
        frame.origin.y = self.frame.origin.y + self.frame.size.height;
        frame.origin.x = self.frame.origin.x;
        if ( frame.origin.y + frame.size.height > [self superview].frame.size.height ) {
            frame.origin.y = [self superview].frame.size.height - frame.size.height;
        }
        self.datePicker.frame = frame;
        self.datePicker.hidden = NO;
        if ( self.delegate ) {
            [self.delegate pickerShownByCell:self];
        }
    } else {
        [self hidePickers];
    }
    
}

- (IBAction)priorityAction:(id)sender {
    if ( self.priorityPicker.hidden == YES ) {
        [[self superview] addSubview:self.priorityPicker];
        [[self superview] bringSubviewToFront:self.priorityPicker];
        CGRect frame = self.priorityPicker.frame;
        frame.origin.y = self.frame.origin.y + self.frame.size.height;
        frame.origin.x = self.frame.origin.x;
        if ( frame.origin.y + frame.size.height > [self superview].frame.size.height ) {
            frame.origin.y = [self superview].frame.size.height - frame.size.height;
        }
        self.priorityPicker.frame = frame;
        [self.priorityPicker selectRow:[self.todoItem.priority intValue] inComponent:0 animated:NO];
        self.priorityPicker.hidden = NO;
        if ( self.delegate ) {
            [self.delegate pickerShownByCell:self];
        }
    } else {
        [self hidePickers];
    }
}

- (IBAction)dateChangedAction:(id)sender {
    self.todoItem.dueDate = self.datePicker.date;
    if ( self.delegate ) {
        [self.delegate dateChanged];
    }
}

- (IBAction)completedAction:(id)sender {
    self.todoItem.completed = [NSNumber numberWithBool:![self.todoItem.completed intValue]];
}

- (void) hidePickers {
    if ( !self.datePicker.hidden ) {
        if ( ![self.todoItem.dueDate isEqualToDate:self.datePicker.date] ) {
            self.todoItem.dueDate = self.datePicker.date;
            if ( self.delegate ) {
                [self.delegate dateChanged];
            }
        }
        self.datePicker.hidden = YES;
    }
    if ( !self.priorityPicker.hidden ) {
        tPriorities newPriority = [self.priorityPicker selectedRowInComponent:0];
        if ( [self.todoItem.priority intValue] != newPriority ) {
            self.todoItem.priority = [NSNumber numberWithInt: newPriority];
            if ( self.delegate ) {
                [self.delegate priorityChanged];
            }
        }
        self.priorityPicker.hidden = YES;
    }
}

#pragma mark- UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark- UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [TodoItem stringForPriority:[NSNumber numberWithInt:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.todoItem.priority = [NSNumber numberWithInt:row];
    if ( self.delegate ) {
        [self.delegate priorityChanged];
    }
}

- (void) dealloc {
    if (_todoItem ) {
        //Remove observers for the previous item
        [_todoItem removeObserver:self forKeyPath:@"dueDate"];
        [_todoItem removeObserver:self forKeyPath:@"priority"];
    }
}

@end
