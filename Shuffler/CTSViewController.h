//
//  CTSViewController.h
//  Shuffler
//
//  Created by mark on 4/16/14.
//  Copyright (c) 2014 Teamstudio, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)handleShuffle:(id)sender;

@end
