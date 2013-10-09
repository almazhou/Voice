//
//  DetailViewController.h
//  Voice
//
//  Created by xzhou on 10/8/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySynthesizerViewDelegate.h"
#import "iflyMSC/IFlySynthesizerView.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"

#define APPID       @"523e8a23"

@interface DetailViewController : UIViewController <IFlySynthesizerViewDelegate, IFlyRecognizerViewDelegate, UITextViewDelegate>

@property(nonatomic, strong) IBOutlet UITextView *_textView;
@property IFlySynthesizerView *_iFlySynthesizerView;
@property IFlyRecognizerView *_iFlyRecognizerView;

- (IBAction)saveWords;
- (IBAction)clear;

- (IBAction)finishWriting;

- (IBAction)speak;
- (IBAction) record;
@end
