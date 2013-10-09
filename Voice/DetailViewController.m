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

    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID ];
    self._iFlySynthesizerView = [[IFlySynthesizerView alloc] initWithOrigin:CGPointMake(10, 60) params:initString];
    self._iFlySynthesizerView.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSave
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

- (void)speak
{
//    [_iFlySynthesizerView setParameter:@"params" value:@"bgs=1"];

    [self._iFlySynthesizerView startSpeaking:self._textView.text];
}
- (void)finishWriting
{
[self._textView resignFirstResponder];
}

#pragma mark delegate
- (void) onBufferProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    NSLog(@"bufferProgress:%d",progress);
}

- (void) onEnd:(IFlySynthesizerView *)iFlySynthesizerView error:(IFlySpeechError *)error
{
    NSLog(@"onEnd:%d",error);

}

- (void) onPlayProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    NSLog(@"playProgress:%d",progress);
}

@end
