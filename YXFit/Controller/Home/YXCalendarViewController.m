//
//  YXCalendarViewController.m
//  YXFit
//
//  Created by 何军 on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXCalendarViewController.h"
#import "YXCollectionViewCell.h"
#import "CalendarFrame.h"
@interface YXCalendarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, footerViewDelegate>
{
    NSInteger integer;
}
@property (nonatomic,strong) UICollectionView *YXCollectionView;
@property (nonatomic,strong) UIView *dataView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation YXCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text=@"日期选择";
    [self addChildView];
    [self creatBackButton];
    // Do any additional setup after loading the view.
}
- (void)addChildView{
    _dataView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.height, self.view.width, 38)];
    _dataView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:_dataView];
    NSArray* array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < array.count; i ++) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width/7.0*i, 0, self.view.width/7.0, _dataView.height)];
        label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        label.font = YXCharacterFont(17);
        if (i==0 ||i==array.count -1) {
            label.textColor = [UIColor orangeColor];
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.text = array[i];
        label.textColor = RGB(60, 60, 60);
        [_dataView addSubview:label];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _dataView.height - CellLine, _dataView.width, CellLine)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_dataView addSubview:line];
//加载8个月以内的日期
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:8];

    integer = 0;
    [self getDataBydata:2];
    [self.YXCollectionView reloadData];
    
   // yxc.dataArray = self.dataArray;
}
- (UICollectionView *)YXCollectionView{
    if (!_YXCollectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _YXCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _dataView.height + _dataView.origin.y, self.view.width, self.view.height - _dataView.height - _dataView.origin.y) collectionViewLayout:layout];
        _YXCollectionView.backgroundColor = [UIColor whiteColor];
        _YXCollectionView.delegate = self;
        _YXCollectionView.dataSource = self;
        _YXCollectionView.allowsMultipleSelection = NO;
        //_YXCollectionView.showsHorizontalScrollIndicator = NO;
        //self.YXCollectionView.showsVerticalScrollIndicator = NO;
        [_YXCollectionView registerClass:[YXCollectionViewCell class] forCellWithReuseIdentifier:@"YXCollectionViewCell"];
        [_YXCollectionView registerClass:[YXCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YXCollectionHeaderView"];
        [_YXCollectionView registerClass:[YXCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YXCollectionFooterView"];
        [self.view addSubview:_YXCollectionView];
    }
    return _YXCollectionView;
}
- (void)moreData:(UIButton *)button{
    if (integer == 8) {
        [button setTitle:@"超出时间范围" forState:UIControlStateNormal];
        button.enabled = NO;
        return;
    }
    [self getDataBydata:2];
   // [self.tableView reloadData];
}

- (void)getDataBydata:(NSInteger)count{
    for (int i = 0; i < count; i ++) {
        NSDateComponents *com = [YXDateManager getOtherMonthComponentsWithCurrentDate:integer];
        CalendarFrame *calendar = [[CalendarFrame alloc] init];
        calendar.dateComponents = com;
        [self.dataArray addObject:calendar];
        integer += 1;
    }
  //  YXLog(@"integer = %d", integer);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CalendarFrame *calendarFrame = [self.dataArray objectAtIndex:section];
    return calendarFrame.weeksOfmonth * 7 ;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader){
        YXCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YXCollectionHeaderView" forIndexPath:indexPath];
        CalendarFrame *calendarFrame = [self.dataArray objectAtIndex:indexPath.section];
        headerView.titleLabel.text = [NSString stringWithFormat:@"%li %@",(long)calendarFrame.dateComponents.year,[YXDateManager getMonths][calendarFrame.dateComponents.month-1]];
        return headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        YXCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YXCollectionFooterView" forIndexPath:indexPath];
        footerView.delegate = self;
        return footerView;
        
    }
    return nil;
}
- (void)loadMoreTime:(UIButton *)button{
    if (self.dataArray.count == 8) {
        [button setTitle:@"超出时间范围" forState:UIControlStateNormal];
        button.enabled = NO;
        // return;
    }
    [self getDataBydata:2];
    [self.YXCollectionView reloadData];

    
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YXCollectionViewCell" forIndexPath:indexPath];
    //从周日开始 若从周一开始则_dateComponents.weekday - 1
    cell.weekend = NO;
    CalendarFrame *calendarFrame = [self.dataArray objectAtIndex:indexPath.section];
    if((indexPath.row < calendarFrame.firstDay) || (indexPath.row > calendarFrame.firstDay + calendarFrame.daysOfmonth -1)) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        NSInteger currentDay = indexPath.row - calendarFrame.firstDay + 1;
        cell.dateLabel.text = [NSString stringWithFormat:@"%ld", (long)currentDay];
        cell.selected = [collectionView.indexPathsForSelectedItems containsObject:indexPath];
        if (indexPath.row%7 == 0 || indexPath.row%7 == 6){
            cell.weekend = YES;
        }
        if (calendarFrame.isCurrentMonth) {
            if (indexPath.row < calendarFrame.dateComponents.day + calendarFrame.firstDay - 1) {
                cell.userInteractionEnabled = NO;
                cell.dateLabel.textColor = RGB(170, 170, 170);
            }else{
                cell.userInteractionEnabled = YES;
                if (currentDay == calendarFrame.dateComponents.day) {
                    cell.dateLabel.text = @"今天";
                }
            }

        }else{
            cell.userInteractionEnabled = YES;
        }
        //上次选择的
        if (indexPath.row == self.index.row && indexPath.section == self.index.section) {
            //self.index = nil;
            cell.selected = YES;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index) {
        YXCollectionViewCell *cell = (YXCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.index];
        cell.selected = NO;
        self.index = nil;
    }
    CalendarFrame *calendarFrame = [self.dataArray objectAtIndex:indexPath.section];
    NSString *chooseData = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)calendarFrame.dateComponents.year,(long)calendarFrame.dateComponents.month,indexPath.row - calendarFrame.firstDay + 1];
   // YXLog(@"chooseData = %@ --- %d --- %d --- %@", chooseData , indexPath.section, indexPath.row, indexPath);
    _dateChoose(chooseData, indexPath);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self.navigationController popViewControllerAnimated:YES];
    });
   
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/7.0, CellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, HeaderViewHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1) {
        return CGSizeMake(ScreenWidth, HeaderViewHeight);
    }
    return CGSizeMake(0, 0);
}
@end
