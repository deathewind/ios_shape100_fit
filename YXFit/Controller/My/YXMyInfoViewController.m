//
//  YXMyInfoViewController.m
//  YXFit
//
//  Created by 何军 on 25/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXMyInfoViewController.h"
#import "STAlertView.h"

@interface YXMyInfoViewController()<UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSString *myName;
    NSString *mySex;
    NSString *myIcon;
}

@property(nonatomic, strong) UITableView *tableView;
//@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UILabel *sexLabel;
@property(nonatomic, strong) STAlertView *alert;
@end
@implementation YXMyInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    self.titleBar.text = @"个人信息";
    [self loadTableData];
    [self.view addSubview:self.tableView];
    [self addBackButton];
}
- (void)loadTableData{
    myName = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserName];
    mySex = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserSex];
    myIcon = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserIcon];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"headerCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle: 	UITableViewCellStyleDefault reuseIdentifier:nil];
          //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth/2 - 20, 70)];
            label.font = YXCharacterFont(16);
            label.text = @"头像";
            [cell.contentView addSubview:label];
            
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 80, 5, 60, 60)];
            _imageView.layer.cornerRadius = _imageView.height/2;
            _imageView.clipsToBounds = YES;
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            [cell.contentView addSubview:_imageView];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line];
            
            UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70 - 0.5, ScreenWidth, 0.5)];
            line1.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line1];
        }
        if (myIcon) {
            _imageView.image = [UIImage imageWithContentsOfFile:myIcon];
            
        }else{
            _imageView.image = [UIImage imageFileName:@"info_dp_no.png"];
        }
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"nameCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle: 	UITableViewCellStyleDefault reuseIdentifier:nil];
               // cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
                UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth/2 - 20, 40)];
                left.font = YXCharacterFont(16);
                left.text = @"昵称";
                [cell.contentView addSubview:left];
                
                _name = [[UILabel alloc] initWithFrame:CGRectMake(left.width + left.origin.x, 0, left.width, left.height)];
                _name.font = YXCharacterFont(16);
                _name.textColor = RGB(136, 136, 136);
                _name.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:_name];
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
                line.backgroundColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:line];
                
                UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 40 - 0.5, ScreenWidth - 18, 0.5)];
                line1.backgroundColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:line1];
            }
            _name.text = myName;
            return cell;
        }else if (indexPath.row == 1) {
            static NSString *CellIdentifier = @"sexCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle: 	UITableViewCellStyleDefault reuseIdentifier:nil];
              //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
                UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth/2 - 20, 40)];
                left.font = YXCharacterFont(16);
                left.text = @"性别";
                [cell.contentView addSubview:left];
                
                _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(left.width + left.origin.x, 0, left.width, left.height)];
                _sexLabel.font = YXCharacterFont(16);
                _sexLabel.textColor = RGB(136, 136, 136);
                _sexLabel.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:_sexLabel];
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 - 0.5, ScreenWidth, 0.5)];
                line.backgroundColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:line];
            }
            _sexLabel.text = mySex;
            return cell;
        }

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }else{
        return 40;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"取消", nil)
                                             destructiveButtonTitle:NSLocalizedString(@"拍照", nil)
                                                  otherButtonTitles:NSLocalizedString(@"从相册选取", nil), nil];
        sheet.tag = 1000;
        [sheet showInView:self.view];
    }else{
        if (indexPath.row == 0) {
            self.alert = [[STAlertView alloc] initWithTitle:@"更改昵称" message:nil textFieldHint:nil textFieldValue:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定" cancelButtonBlock:^{
               // NSLog(@"11");
            } otherButtonBlock:^(NSString *result) {
                NSLog(@"result = %@", result);
                if (result != nil && result.length > 0) {
                    if (result.length > 20) {
                        [UIUtils showTextOnly:self.view labelString:@"名字太长了"];
                        return ;
                    }
                  //  [[NSUserDefaults standardUserDefaults] setObject:result forKey:YXUserName];
                    _name.text = result;
                    mySex = result;
                }

            }];
          //  [alert.alertView show];
        }else if(indexPath.row == 1){
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"性别选择" delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"取消", nil)
                                                 destructiveButtonTitle:@"男"
                                                      otherButtonTitles:@"女",@"保密", nil];
            sheet.tag = 1001;
            [sheet showInView:self.view];
        }
    }
}



#pragma mark - action sheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1000) {
        switch (buttonIndex) {
            case 0: {       // 拍照
                // 先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.delegate = self;
                    picker.allowsEditing = YES;
                    picker.sourceType = sourceType;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            } break;
            case 1: {       // 相册
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:nil];
            } break;
            case 2:         // 取消
            default:
                break;
        }
    }else{
       // NSLog(@"buttonIndex = %d", buttonIndex);
        if (buttonIndex == 3) {
            return;
        }
        NSString *sex = nil;
        if (buttonIndex == 0) {
            sex = @"男";
        }else if (buttonIndex == 1){
            sex = @"女";
        }else{
            sex = @"保密";
        }
        _sexLabel.text = sex;
        mySex = sex;
       // [[NSUserDefaults standardUserDefaults] setObject:sex forKey:YXUserSex];
    }
}

#pragma mark - image picker view delegate -
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];

        [picker dismissViewControllerAnimated:YES completion:^{
            if ([UIUtils isConnectNetwork]) {
                NSString *iconPath = [UIUtils saveMyImage:image];
             //   upLoadIconTime = 1;
                [self uploadImage:iconPath with:image];
                
            }else{
                [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"You have no internet connection", nil)];
            }
            
        }];

        
    }
}
- (void)uploadImage:(NSString *)path with:(UIImage *)image{
    [UIUtils showProgressHUDto:self.view withString:@"上传头像" showTime:60];
    [[YXNetworkingTool sharedInstance] uploadImagePath:path success:^(id JSON) {
       // YXLog(@"json = %@", JSON);
        NSString *picID = JSON[@"pic_id"];
        [[YXNetworkingTool sharedInstance] updataUserInfo:@{@"profile_image_pic_id":picID} success:^(id JSON) {
            [UIUtils hideProgressHUD:self.view];
            [UIUtils showTextOnly:self.view labelString:@"头像修改成功"];
            _imageView.image = image;
            myIcon = path;
            [[NSUserDefaults standardUserDefaults] setObject:path forKey:YXUserIcon];
        } failure:^(NSError *error, id JSON) {
            
            [UIUtils hideProgressHUD:self.view];
            [UIUtils showTextOnly:self.view labelString:@"头像修改失败"];
        }];
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:@"头像修改失败"];
    }];
}


- (void)addBackButton{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, StatusBarHeight, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_back.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_back];
    
    UIButton *button_save = [UIButton buttonWithType:UIButtonTypeCustom];
    button_save.frame = CGRectMake(ScreenWidth - 60, StatusBarHeight, 60, 44);
    button_save.showsTouchWhenHighlighted = YES;
    [button_save setTitle:@"保存" forState:UIControlStateNormal];
    button_save.titleLabel.font = YXCharacterFont(16);
    [button_save addTarget:self action:@selector(clickButton_save)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_save];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44);
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.backgroundColor = RGB(156, 210, 122);
    button.titleLabel.font = YXCharacterFont(16);
    [button addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)clickButton_save{
    [UIUtils showProgressHUDto:self.view withString:@"保存信息" showTime:30];
    NSString *sexNum = nil;
    if ([mySex isEqualToString:@"女"]) {
        sexNum = @"0";
    }else if ([mySex isEqualToString:@"男"]){
        sexNum = @"1";
    }else{
        sexNum = @"2";
    }
    NSDictionary *dic = @{@"name":myName,@"gender":sexNum};
    [[YXNetworkingTool sharedInstance] updataUserInfo:dic success:^(id JSON) {
        YXLog(@"userInfo = %@", JSON);
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:@"保存成功"];
        [[NSUserDefaults standardUserDefaults] setObject:myName forKey:YXUserName];
        [[NSUserDefaults standardUserDefaults] setObject:mySex forKey:YXUserSex];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:@"网络不给力"];
    }];

}
- (void)quit{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXToken];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXTokenSecret];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXUserName];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXUserId];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXUserSex];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXUserIcon];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
