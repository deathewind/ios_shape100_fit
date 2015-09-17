//
//  ClubListCell.m
//  YXFit
//
//  Created by 何军 on 10/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ClubListCell.h"
@interface ClubListCell()
{
    UIImageView *_imageView;
    UILabel     *_name;
    UILabel     *_address;
    UILabel     *_distance;
}
@end
@implementation ClubListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(230, 230, 230);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 210)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        UIView *gradient = [[UIView alloc] initWithFrame:CGRectMake(0, _imageView.height - 60, _imageView.width, 60)];
        gradient.backgroundColor = RGBA(0, 0, 0, 0.4);
        [_imageView addSubview:gradient];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 220, gradient.height - 30)];
        //  _describe.backgroundColor = [UIColor orangeColor];
        _name.textColor = [UIColor whiteColor];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = YXCharacterFont(17);
        // _describe.numberOfLines = 0;
        [gradient addSubview:_name];
        
        _address = [[UILabel alloc] initWithFrame:CGRectMake(10, _name.height + _name.origin.y-4, 250, 20)];
        _address.textAlignment = NSTextAlignmentLeft;
        // _price.backgroundColor = [UIColor redColor];
        _address.textColor = [UIColor whiteColor];
        _address.font = [UIFont systemFontOfSize:13];
        [gradient addSubview:_address];
        //
        _distance = [[UILabel alloc] initWithFrame:CGRectMake(gradient.width - 70, _address.origin.y, 60, _address.height)];
        _distance.textAlignment = NSTextAlignmentRight;
        // _price.backgroundColor = [UIColor redColor];
        _distance.textColor = [UIColor whiteColor];
        _distance.font = YXCharacterFont(13);
        [gradient addSubview:_distance];

        
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _imageView.height, ScreenWidth , 40)];
//        bgView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:bgView];
//
//
//        
//        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgView.height - 0.5, bgView.width, 0.5)];
//        line.backgroundColor = [UIColor lightGrayColor];
//        [bgView addSubview:line];
    }
    return self;
}
- (void)setClub:(Model_club *)club{
    _club = club;
    _name.text = club.club_name;
    //    _price.text = [NSString stringWithFormat:@"￥%@", product.product_price];
    //    _describe.text = product.product_description;
    _address.text = club.club_address;
    if (![club.club_distance isEqualToString:@"-1"]) {
        _distance.text = [NSString stringWithFormat:@"%.1fKM", [club.club_distance floatValue]/1000];
    }
    
    NSString *str = [[club.club_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
