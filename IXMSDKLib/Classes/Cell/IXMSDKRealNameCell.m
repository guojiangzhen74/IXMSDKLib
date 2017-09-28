//
//  IXMRealNameCell.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/26.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKRealNameCell.h"
#import "IXMSDKConfing.h"
@interface IXMSDKRealNameCell (){
    
    
    UILabel *titleLable;
    UILabel *statusLable;
    
}
@end

@implementation IXMSDKRealNameCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor =[UIColor whiteColor];
        
        titleLable=[UILabel new];
        titleLable.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLable];
        
        statusLable=[UILabel new];
        statusLable.font =[UIFont systemFontOfSize:14];
        statusLable.textColor=IXMRGB(246, 180, 90, 1);
        [self.contentView addSubview:statusLable];
    }
    
    return self;
}




-(void)layoutSubviews{
    [super layoutSubviews];
    
    titleLable.text = self.titleText;
    statusLable.text = self.statusText;
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        
    }];
    
    
    [statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        
    }];
}

@end
