//
//  RateViewController.m
//  Voice
//
//  Created by xzhou on 10/10/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "RateViewController.h"
#import "RateView.h"

@interface RateViewController ()

@end

@implementation RateViewController

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
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    self.statusLabel.text = [NSString stringWithFormat:@"%.01f", rating];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
            insertNewObjectForEntityForName:@"Rates"
                     inManagedObjectContext:context];
    [newContact setValue:[NSNumber numberWithFloat:rating] forKey:@"rate"];

    NSError *error;
    [context save:&error];
}
-(IBAction)readingRates:(float)rating{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Rates" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error1 = nil;
    NSArray *totalObjects = [context executeFetchRequest:request error:&error1];
    if (totalObjects == nil) {
        NSLog(@"Sorry,no objects found");
    }
    else {
        int length = [totalObjects count];
        NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:length];
        float sum,rate;
        for(int i =0;i<[totalObjects count];i++) {
            [muArray addObject:[[totalObjects objectAtIndex:i] valueForKey:@"rate"]];
            NSNumber * rate = [[totalObjects objectAtIndex:i] valueForKey:@"rate"];
            sum +=[rate floatValue];
        }
        rate = sum/[totalObjects count];
        NSLog(@"The average is %f",rate);
    }

}
@end
