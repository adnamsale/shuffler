//
//  CTSViewController.m
//  Shuffler
//
//  Created by mark on 4/16/14.
//  Copyright (c) 2014 Teamstudio, Inc. All rights reserved.
//

#import "CTSViewController.h"
#include <random>

@interface CTSViewController ()
@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
@end

@implementation CTSViewController

int shuffleMap[52];

void shuffle() {
    for (int i = 0 ; i < 52 ; ++i) {
        shuffleMap[i] = i;
    }
    std::mt19937 r{std::random_device{}()};
    std::shuffle(std::begin(shuffleMap), std::end(shuffleMap), r);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    srand((unsigned int)time(NULL));
    
    self.pageImages = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"PNG-cards-1.3/ace_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/2_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/3_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/4_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/5_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/6_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/7_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/8_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/9_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/10_of_clubs.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/jack_of_clubs2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/queen_of_clubs2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/king_of_clubs2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/ace_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/2_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/3_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/4_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/5_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/6_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/7_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/8_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/9_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/10_of_diamonds.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/jack_of_diamonds2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/queen_of_diamonds2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/king_of_diamonds2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/ace_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/2_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/3_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/4_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/5_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/6_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/7_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/8_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/9_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/10_of_hearts.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/jack_of_hearts2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/queen_of_hearts2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/king_of_hearts2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/ace_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/2_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/3_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/4_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/5_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/6_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/7_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/8_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/9_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/10_of_spades.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/jack_of_spades2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/queen_of_spades2.png"],
                       [UIImage imageNamed:@"PNG-cards-1.3/king_of_spades2.png"],
                       nil];
    
    NSInteger pageCount = self.pageImages.count;
    [self.progressView setProgress:0];
    
    shuffle();
    
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView.superview addGestureRecognizer:tapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    [self loadVisiblePages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewTapped:(UITapGestureRecognizer*)recognizer {
    CGPoint pointInView = [recognizer locationInView:self.scrollView.superview];
    
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    if (pointInView.x < 100 && 0 < page) {
        [self.scrollView setContentOffset:CGPointMake((page - 1) * pageWidth, 0) animated:YES];
    }
    else if (100 < pointInView.x && page < 51) {
        [self.scrollView setContentOffset:CGPointMake((page + 1) * pageWidth, 0) animated:YES];
    }
}

- (IBAction)handleReset:(id)sender {
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)handleShuffle:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Kathie says I need to ask if you're sure"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex
{
    if (buttonIndex == 1) {
        shuffle();
        for (int i = 0 ; i < 52 ; ++i) {
            [self purgePage:i];
        }
        [self handleReset:nil];
        [self loadVisiblePages];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:shuffleMap[page]]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    [self.progressView setProgress:(float)page / self.pageImages.count];
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}
@end
