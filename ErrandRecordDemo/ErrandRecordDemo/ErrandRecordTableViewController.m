//
//  ErrandRecordTableViewController.m
//  ErrandRecordDemo
//
//  Created by Dev on 2017/7/19.
//  Copyright © 2017年 Dev. All rights reserved.
//

#import "ErrandRecordTableViewController.h"
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define OFFSET1               72
@interface ErrandRecordTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray    *dataArray; // 数据源 存放搜索历史数据

@end

@implementation ErrandRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = YES;
    UIView *iconView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-96)/2,0 ,96, 44)];
    iconView.backgroundColor = [UIColor whiteColor];
    iconView.userInteractionEnabled = YES;
    [self.view addSubview:iconView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  // 去掉选中效果
    cell.focusStyle = UITableViewCellStyleSubtitle;
    cell.textLabel.text = [NSString stringWithFormat:@"我是第 %ld 区，第 %ld 行",indexPath.section,indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20+44)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 44)];
    [backgroundView addSubview:searchView];
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = CGRectMake((SCREEN_WIDTH-40)/2.0, -2, 40, 28);
    image.image = [UIImage imageNamed:@"横线"];
    [backgroundView addSubview:image];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5;
    [backgroundView addSubview:lineView];
    return backgroundView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 66;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT -OFFSET1-44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.userInteractionEnabled = YES;
        _tableView.scrollEnabled = NO; // 让table默认禁止滚动
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // 去掉table的尾部
        
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
