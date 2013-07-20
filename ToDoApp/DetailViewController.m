//
//  DetailViewController.m
//  ToDoApp
//
//  Created by Vadim on 7/18/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import "DetailViewController.h"
#import "TodoItem.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setTodoItem:(TodoItem *)todoItem
{
    if (_todoItem != todoItem) {
        _todoItem = todoItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    self.textView.font                       =   [UIFont fontWithName:@"MarkerFelt-Thin" size:19.0];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotePad.png"]];
    textViewFullFrame_ = self.textView.frame;
    imageView.frame = self.textView.bounds;
    [self.textView addSubview:imageView];
    [self.textView sendSubviewToBack:imageView];
    if (self.todoItem) {
        self.textView.text = self.todoItem.title;
//        NSDate* dueDate = self.todoItem.dueDate;
        self.dueDateLabel.text = [TodoItem stringForDate:self.todoItem.dueDate];
        self.priorityLabel.text = [TodoItem stringForPriority:self.todoItem.priority];
        [self.priorityPicker selectRow:[self.todoItem.priority intValue] inComponent:0 animated:NO];
        self.checkMarkImageView.hidden = ![self.todoItem.completed intValue];
//        [self setDate:self.todoItem.dueDate];
    }
    
    self.tapGestureRecognizer.enabled = NO;
}

//- (void) setDate: (NSDate*) date {
//    self.dueDateLabel.text = [TodoItem stringForDate:date];
//}
//
#pragma mark - UITextViewDelegate

-(void) textViewDidBeginEditing:(UITextView *)textView {
    textView.frame = srunkTextViewSizePlaceholder_.frame;
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    textView.frame = textViewFullFrame_;
}

#pragma mark - View lifetime management methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ( self.textView.text )
        self.todoItem.title = self.textView.text;
    [self hidePickers];
}

- (void) hidePickers {
    if ( !self.datePicker.hidden ) {
        self.todoItem.dueDate = self.datePicker.date;
        self.dueDateLabel.text = [TodoItem stringForDate:self.todoItem.dueDate];
//        self.date = self.datePicker.date;
        self.datePicker.hidden = YES;
        self.tapGestureRecognizer.enabled = NO;
        [self.textView setEditable:YES];
    }
    if ( !self.priorityPicker.hidden ) {
        self.priorityPicker.hidden = YES;
        self.tapGestureRecognizer.enabled = NO;
        [self.textView setEditable:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapAction:(id)sender {
    [self hidePickers];
}

- (IBAction)changeDueDateAction:(id)sender {
    if ( self.datePicker.hidden ) {
        self.datePicker.hidden = NO;
        [self.textView resignFirstResponder];
        [self.textView setEditable:NO];
        self.tapGestureRecognizer.enabled = YES;
    }
}

- (IBAction)changePriorityAction:(id)sender {
    if ( self.priorityPicker.hidden ) {
        self.priorityPicker.hidden = NO;
        [self.textView resignFirstResponder];
        [self.textView setEditable:NO];
        self.tapGestureRecognizer.enabled = YES;
    }
}

- (IBAction)completedAction:(id)sender {
    self.todoItem.completed = [NSNumber numberWithBool:![self.todoItem.completed intValue]];
    self.checkMarkImageView.hidden = ![self.todoItem.completed intValue];
}



- (IBAction)dateChangedAction:(id)sender {
    self.todoItem.dueDate = self.datePicker.date;
    self.dueDateLabel.text = [TodoItem stringForDate:self.todoItem.dueDate];
//    [self setDate:self.datePicker.date];
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
    self.priorityLabel.text = [TodoItem stringForPriority:self.todoItem.priority];
}


@end
