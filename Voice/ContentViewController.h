//
//  ContentViewController.h
//  Voice
//
//  Created by xzhou on 10/9/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
@property (weak, nonatomic)IBOutlet UITextView *_contentView;
@property (strong, nonatomic) NSString *_content;
@end
