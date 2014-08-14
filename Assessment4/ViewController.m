//
//  ViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property UIAlertView *stuckAlert;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];

    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: mmCellIdentifier];
    cell.textLabel.text = person.name;
    return cell;
}

#pragma mark - UIAlertView Methods

//METHOD FOR PRESENTING ALERT VIEW WITH TEXT FIELD FOR USER TO ENTER NEW PERSON
- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender
{
    self.addAlert = [[UIAlertView alloc] initWithTitle:@"Add a Person"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    self.addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextField = [self.addAlert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;

    [self.addAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.addAlert)
    {

        if (buttonIndex != alertView.cancelButtonIndex)
        {
            NSLog(@"%@", [self.addAlert textFieldAtIndex:0].text);
            Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
            p.name = [self.addAlert textFieldAtIndex:0].text;
            [self.managedObjectContext save:nil];
        }
    }
    else if (alertView == self.colorAlert)
    {
        //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW
            if (buttonIndex == 0)
            {
                self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
            }
            else if (buttonIndex == 1)
            {
                self.navigationController.navigationBar.tintColor = [UIColor blueColor];
            }
            else if (buttonIndex == 2)
            {
                self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
            }
            else if (buttonIndex == 3)
            {
                self.navigationController.navigationBar.tintColor = [UIColor greenColor];
            }
    }
    else
    {
        if (buttonIndex != alertView.cancelButtonIndex)
        {
            UIAlertView *newAlertView = [[UIAlertView alloc] initWithTitle:@"Lets try this"
                                                                   message:@"1.Write down the question you want to ask \n2.Brainstorm 3 possible solutions \n3.Bring the question and 3 possible answers to an instructor, or learning assistant \n4.Give the Engineerium a high-five"
                                                                  delegate:self
                                                         cancelButtonTitle:@"We found the answer"
                                                         otherButtonTitles:nil, nil];
            [newAlertView show];
        }
    }


}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    [self.colorAlert show];
}
- (IBAction)onPressedPresentStuckBox:(UIButton *)sender
{
    self.stuckAlert = [[UIAlertView alloc] initWithTitle:@"Follow these steps"
                                                        message:@"1.Identify where you are stuck \n2.Use Apple documentation to get a better understand of what has you stuck \n3.Search Google and StackOverflow for possible solutions"
                                                       delegate:self
                                              cancelButtonTitle:@"Found solution"
                                              otherButtonTitles:@"Still Stuck", nil];
    [self.stuckAlert show];
}

@end
