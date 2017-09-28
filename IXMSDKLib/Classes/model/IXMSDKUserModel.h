//
//  IXMUserModel.h
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IXMSDKUserModel : NSObject
@property (nonatomic, copy) NSString *IDSEXT_HAS_BIRHT_CERT;

@property (nonatomic, copy) NSString *IDSEXT_PASSPORTID;

@property (nonatomic, copy) NSString *terminal;

@property (nonatomic, copy) NSString *IDSEXT_CENSUS_HOME_ADDR;

@property (nonatomic, copy) NSString *IDSEXT_NEWNORN_HUKOU_STAT;

@property (nonatomic, copy) NSString *IDSEXT_MATER_INSUR_STATUS;

@property (nonatomic, copy) NSString *education;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *IDSEXT_FERTILITY;

@property (nonatomic, copy) NSString *loginAccountName;

@property (nonatomic, copy) NSString *IDSEXT_USERTYPE;

@property (nonatomic, copy) NSString *IDSEXT_CAR_STATUS;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *profession;
@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *IDSEXT_WEIXIN;

@property (nonatomic, copy) NSString *expendScore;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *IDSEXT_CENSUS_CODE;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *IDSEXT_EMPLOY_STATUS;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *relPerson;

@property (nonatomic, copy) NSString *regCoApp;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *IDSEXT_APPLYTYPE;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *creditID;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *IDSEXT_AREA;

@property (nonatomic, copy) NSString *fax;

@property (nonatomic, copy) NSString *nation;

@property (nonatomic, copy) NSString *IDSEXT_RESIDENT_COMMUNITY;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *IDSEXT_PREGNANCY;

@property (nonatomic, copy) NSString *realNameStatus;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *IDSEXT_PERNATAL_INFO;


+(instancetype)IXMUserModelWithDic:(NSDictionary *)dict;
@end
