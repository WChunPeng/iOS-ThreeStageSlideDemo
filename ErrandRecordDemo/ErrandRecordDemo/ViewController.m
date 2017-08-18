//
//  ViewController.m
//  ErrandRecordDemo
//
//  Created by Dev on 2017/7/19.
//  Copyright © 2017年 Dev. All rights reserved.
//

#import "ViewController.h"
#import "ErrandRecordTableViewController.h"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

#define OFFSET1               72
#define OFFSET2               self.view.frame.size.height - 294
#define OFFSET3               self.view.frame.size.height - 108

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) ErrandRecordTableViewController      *tableViewController;

@property (nonatomic, strong) UIView                    *contentView;

@property (nonatomic, strong) UISwipeGestureRecognizer  *downSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer  *upSwipe;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableViewController = [[ErrandRecordTableViewController alloc]init];
    [self addChildViewController:self.tableViewController];
    [self.contentView addSubview:self.tableViewController.view];
    [self.view addSubview:self.contentView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 当table Enabled且offsetY不为0时，让swipe响应
    if (self.tableViewController.tableView.scrollEnabled == YES && self.tableViewController.tableView.contentOffset.y != 0) {
        return NO;
    }
    if (self.tableViewController.tableView.scrollEnabled == YES) {
        return YES;
    }
    return NO;
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    float stopY = 0;     // 停留的位置
    float animateY = 0;  // 做弹性动画的Y
    float margin = 10;   // 动画的幅度
    float offsetY = self.contentView.frame.origin.y; // 这是上一次Y的位置
    //    NSLog(@"==== === %f == =====",self.vc.table.contentOffset.y);
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        
        // 当vc.table滑到头 且是下滑时，让vc.table禁止滑动
        if (self.tableViewController.tableView.contentOffset.y == 0) {
            self.tableViewController.tableView.scrollEnabled = NO;
        }
        
        if (offsetY >= OFFSET1 && offsetY < OFFSET2) {
            // 停在y2的位置
            stopY = OFFSET2;

        }else if (offsetY >= OFFSET2 ){
            // 停在y3的位置
            stopY = OFFSET3;
            
        }else{
            stopY = OFFSET1;
        }
        animateY = stopY + margin;
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        //        NSLog(@"==== up =====");
        
        if (offsetY <= OFFSET2) {
            // 停在y1的位置
            stopY = OFFSET1;
            // 当停在Y1位置 且是上划时，让vc.table不再禁止滑动
            self.tableViewController.tableView.scrollEnabled = YES;
        }else if (offsetY > OFFSET2 && offsetY <= OFFSET3 ){
            // 停在y2的位置
            // 当停在Y1位置 且是上划时，让vc.table不再禁止滑动
//            self.tableViewController.tableView.scrollEnabled = YES;
            stopY = OFFSET2;
        }else{
            stopY = OFFSET3;
        }
        animateY = stopY - margin;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.contentView.frame = CGRectMake(0, animateY, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.frame = CGRectMake(0, stopY, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
    }];
    
    // 记录shadowView在第一个视图中的位置
    self.tableViewController.offsetY = stopY;
}



#pragma mark - 懒加载

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, OFFSET3, self.view.frame.size.width, self.view.frame.size.height);
        _contentView.userInteractionEnabled = YES;
        self.downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        self.downSwipe.direction = UISwipeGestureRecognizerDirectionDown ; // 设置手势方向
        self.downSwipe.delegate = self;
        [_contentView addGestureRecognizer:self.downSwipe];
        
        self.upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        self.upSwipe.direction = UISwipeGestureRecognizerDirectionUp; // 设置手势方向
        self.upSwipe.delegate = self;
        [_contentView addGestureRecognizer:self.upSwipe];
        
    }
    return _contentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
