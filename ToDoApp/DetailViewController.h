//
//  DetailViewController.h
//  ToDoApp
//
//  Created by Vadim on 7/18/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoItem;

@interface DetailViewController : UIViewController<UITextViewDelegate> {
    
    __weak IBOutlet UILabel *srunkTextViewSizePlaceholder_;
    CGRect textViewFullFrame_;
}
- (IBAction)tapAction:(id)sender;
- (IBAction)changeDueDateAction:(id)sender;
- (IBAction)dateChangedAction:(id)sender;
- (IBAction)changePriorityAction:(id)sender;
- (IBAction)completedAction:(id)sender;
@property (strong, nonatomic) TodoItem* todoItem;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *dueDateChangeButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImageView;
@end
