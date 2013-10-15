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

    self._iFlyRecognizerView = [[IFlyRecognizerView alloc] initWithOrigin:CGPointMake(15, 60) initParam:initString];
    self._iFlyRecognizerView.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveWords
{
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"保存成功" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    // Display the Hello World Message
    [alert show];

    AppDelegate *appDelegate =
            [[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *context =
            [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
            insertNewObjectForEntityForName:@"Sentences"
                     inManagedObjectContext:context];
    [newContact setValue:self._textView.text forKey:@"name"];
    [newContact setValue:self._textView.text forKey:@"content"];

    NSError *error;
    [context save:&error];

}
- (IBAction)clear{
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"清空" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alert show];
    self._textView.text = nil;
}
- (IBAction)speak
{
//    [_iFlySynthesizerView setParameter:@"params" value:@"bgs=1"];

    [self._iFlySynthesizerView startSpeaking:self._textView.text];
}
- (IBAction)finishWriting
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

- (IBAction) record
{
    self._textView.text = nil;
    [self._iFlyRecognizerView setParameter:@"sample_rate" value:@"16000"];
    [self._iFlyRecognizerView setParameter:@"vad_eos" value:@"1800"];
    [self._iFlyRecognizerView setParameter:@"vad_bos" value:@"6000"];
    [self._iFlyRecognizerView start];
}

- (void) onResult:(IFlyRecognizerView *)iFlyRecognizerView theResult:(NSArray *)resultArray
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@(置信度:%@)\n",key,[dic objectForKey:key]];
    }
    //    NSLog(@"result:%@",results);
    self._textView.text = [NSString stringWithFormat:@"%@%@",self._textView.text,result];


}

- (void)onEnd:(IFlyRecognizerView *)iFlyRecognizerView theError:(IFlySpeechError *) error
{
    NSLog(@"recognizer end");
}

- (void) onPlayProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    NSLog(@"playProgress:%d",progress);
}

@end
