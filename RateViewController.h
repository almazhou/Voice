//
//  RateViewController.h
//  Voice
//
//  Created by xzhou on 10/10/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import "AppDelegate.h"


@interface RateViewController : UIViewController<RateViewDelegate>
@property IBOutlet RateView *rateView;
@property IBOutlet UILabel *statusLabel;
@property IBOutlet UIButton *seeRateStatistics;
-(IBAction)readingRates:(float)rating;
@end
