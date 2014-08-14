//
//  AddDogViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "Dog.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.person.managedObjectContext];
    dog.name = self.nameTextField.text;
    dog.breed = self.breedTextField.text;
    dog.color = self.colorTextField.text;
    [self.person addDogsObject:dog];
    [self.person.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
