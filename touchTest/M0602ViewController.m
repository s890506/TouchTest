//
//  M0602ViewController.m
//  touchTest
//
//  Created by lab506 on 2014/6/3.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "M0602ViewController.h"

@interface M0602ViewController ()

@end

@implementation M0602ViewController
{
    NSTimeInterval touchTime;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for(int touchCount=1;touchCount<3;touchCount++)
    {
        UISwipeGestureRecognizer *horizontal =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalSwipe:)];
        horizontal.numberOfTouchesRequired = touchCount;
        // horizontal swipe
        horizontal.direction=UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:horizontal];
    }
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reportDoubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(reportPan:)];
    [self.view addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(reportPinch:)];
    [self.view addGestureRecognizer:pinch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Began, %d taps", [[touches anyObject]tapCount]);
    touchTime = [event timestamp];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Moved. %d touches", [touches count]);
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Ended");
    if([event timestamp] - touchTime>0.4)
    {
        self.label.text=@"Long touch";
        [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches Cancel");
}

-(void)horizontalSwipe:(UISwipeGestureRecognizer*)recognizer//實作(左)右滑的事件
{
    self.label.text=[NSString stringWithFormat:@"Horizontal Swipe. %d touches",[recognizer numberOfTouches]];
    [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1];
}

-(void)reportDoubleTap //實作點兩下的事件
{
    self.label.text=[NSString stringWithFormat:@"Double Tap."];
    [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1];
}

-(void)reportPan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint center = self.moveLabel.center;//取的物件中心
    CGPoint translation=[recognizer translationInView:self.view];//取的位移量
    center.x+=translation.x;
    center.y+=translation.y;
    self.moveLabel.center=center;
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

-(void)reportPinch:(UIPinchGestureRecognizer*) recognizer
{
    self.slider.value=recognizer.scale*0.5;
}

-(void)eraseLabel
{
    self.label.text=@"";
}
@end
