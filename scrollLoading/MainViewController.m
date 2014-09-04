//
//  MainViewController.m
//  scroll
//
//  Created by Taeho Ko on 9/4/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) int currentPositionY;

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
    
    // Set up the scroll view
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    self.scrollView.delegate = self;
    self.currentPositionY = 508;
    
    // Add the first image (default) in the scroll view
    UIImageView *defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,508)];
    defaultImageView.image = [UIImage imageNamed:(@"default_scroll")];
    [self.scrollView addSubview:defaultImageView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    //NSLog(@"%f", self.scrollView.contentOffset.y);
    //NSLog(@"%f", translation.y);
    
    if (translation.y < 200) {
        [self addNewImage];
    }
}

- (void)addNewImage {
    // There are 5 images for the list items. Pick a random one to add.
    int imageIndex = arc4random() % 5 + 1;
    
    // Add a new image at the bottom
    UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.currentPositionY,320,127)];
    newImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"unit_0%d", imageIndex]];
    [self.scrollView addSubview:newImage];
    self.currentPositionY += 127;
    
    // Make the scroll view even taller so it become infinite
    self.scrollView.contentSize = CGSizeMake(320, self.scrollView.contentSize.height + 130);
    
    // Animate the opacity of the new image
    newImage.alpha = 0;
    [UIView animateWithDuration:0.6 animations:^{
        newImage.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

