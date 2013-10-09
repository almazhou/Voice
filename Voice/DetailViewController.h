//
//  DetailViewController.h
//  Voice
//
//  Created by xzhou on 10/8/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITextViewDelegate>

@property(nonatomic, strong) IBOutlet UITextView *_textView;
-(IBAction)onLogin:(id) sender;
- (IBAction)finishWriting;
@end
