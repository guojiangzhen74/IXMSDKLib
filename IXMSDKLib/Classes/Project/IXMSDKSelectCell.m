//
//  IXMSelectCell.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/28.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKSelectCell.h"
#import "IXMSDKConfing.h"
#import "Masonry.h"
@interface IXMSDKSelectCell (){
    
    
    UILabel *titleLable;
    UIImageView *status;
    
}
@end

@implementation IXMSDKSelectCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor =[UIColor whiteColor];
        
        titleLable=[UILabel new];
        titleLable.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLable];
        
        status=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"down_icon"]];

        [self.contentView addSubview:status];
    }
    
    return self;
}




-(void)layoutSubviews{
    [super layoutSubviews];
    
    titleLable.text = self.titleText;
//    statusLable.text = self.statusText;
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        
    }];
    
    
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        
    }];
}
@end
