//
//  YXFontViewController.m
//  YXFit
//
//  Created by 何军 on 16/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXFontViewController.h"

@interface YXFontViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation YXFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.tableView belowSubview:self.navBar];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView{
    if (!_tableView) {
        // _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navBar.height)];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
      //  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    //字体家族总数
    
    return [[UIFont familyNames] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //字体家族包括的字体库总数
    return [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:section] ] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //字体家族名称
    return [[UIFont familyNames] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    // Configure the cell.
    cell.textLabel.textColor = indexPath.row %2 ? [UIColor orangeColor] : [UIColor magentaColor];
    
    
    //字体家族名称
    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:14.0f];
    cell.textLabel.numberOfLines = 0;
    //查找微软雅黑字体
    if([fontName isEqualToString:@"MicrosoftYaHei"]) {
        NSLog(@"微软雅黑");
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ ----- 6", familyName, fontName ];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
