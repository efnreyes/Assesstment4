//
//  ViewController.h
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

#define mmCellIdentifier @"myCell"

@end
