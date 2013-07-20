//
//  CustomCell.h
//  ToDoApp
//
//  Created by Vadim on 7/19/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoItem;

@protocol CustomCellDelegate <NSObject>

-(void) dateChanged;
-(void) priorityChanged;
-(void) pickerShownByCell: (id) cell;
@end

@interface CustomCell : UITableViewCell<UIPickerViewDelegate, UIPickerViewDataSource> {
}

@property (weak, nonatomic) IBOutlet UIButton *priorityButton;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *dueDateButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (nonatomic) TodoItem* todoItem;
@property id<CustomCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImageView;

- (IBAction)dueDateAction:(id)sender;
- (IBAction)priorityAction:(id)sender;
- (IBAction)dateChangedAction:(id)sender;
- (IBAction)completedAction:(id)sender;

- (void) hidePickers;
@end
