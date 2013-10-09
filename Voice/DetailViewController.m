//
//  DetailViewController.m
//  Voice
//
//  Created by xzhou on 10/8/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLogin:(id) sender
{
    AppDelegate *appDelegate =
            [[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *context =
            [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
            insertNewObjectForEntityForName:@"Sentences"
                     inManagedObjectContext:context];
    [newContact setValue:@"ddddd" forKey:@"name"];
    [newContact setValue:self._textView.text forKey:@"content"];

    self._textView.text = @"";
}
- (void)finishWriting
{
[self._textView resignFirstResponder];
}

@end
