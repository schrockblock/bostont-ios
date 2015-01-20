//
//  ViewController.m
//  BostonTMap
//
//  Created by Ellidi Jatgeirsson on 10/5/12.
//
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate, ADBannerViewDelegate>

@end

@implementation ViewController
@synthesize subwayImageView = _subwayImageView;
@synthesize subwayScrollView = _subwayScrollView;

- (void)viewDidLoad
{
    self.adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.adView.frame = CGRectOffset(self.adView.frame, 0, -50);
    self.adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    self.adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:self.adView];
    self.adView.delegate=self;
    self.bannerIsVisible=NO;
    [super viewDidLoad];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.subwayImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setSubwayImageView:nil];
    [self setSubwayScrollView:nil];
    [self setSchedulesButton:nil];
    [super viewDidUnload];
}

#pragma mark - iAd delegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        self.schedulesButton.frame = CGRectOffset(self.schedulesButton.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        self.schedulesButton.frame = CGRectOffset(self.schedulesButton.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}
@end
