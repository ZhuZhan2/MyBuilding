//
//  MapContentView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MapContentView.h"
#import "ProjectStage.h"
#import "IsFocusedApi.h"
#import "LoginSqlite.h"

#define FONT [UIFont systemFontOfSize:15]
#define OTHERFONT [UIFont systemFontOfSize:14]
@implementation MapContentView

- (id)initWithFrame:(CGRect)frame model:(projectModel *)model number:(NSString *)number;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"=====> %@",model.isFocused);
        self.model = model;
        self.isFocused = model.isFocused;
        self.number = number;
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView addSubview:self.cutLine];
        [self.backgroundImageView addSubview:self.redImageView];
        [self.redImageView addSubview:self.countLabel];
        [self.backgroundImageView addSubview:self.stageLabel];
        [self addSubview:self.focusBtn];
        [self.backgroundImageView addSubview:self.projectName];
        [self.backgroundImageView addSubview:self.projectAddress];
        [self.backgroundImageView addSubview:self.projectInvestment];
        [self.backgroundImageView addSubview:self.projectArea];
        [self.backgroundImageView addSubview:self.projectInvestmentCount];
        [self.backgroundImageView addSubview:self.projectAreaCount];
        [self.backgroundImageView addSubview:self.lastUpdatedTime];
        [self.backgroundImageView addSubview:self.lastUpdatedTimeCount];
    }
    return self;
}

-(UIImageView *)backgroundImageView{
    if(!_backgroundImageView){
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 15, 292, 167)];
        _backgroundImageView.image = [GetImagePath getImagePath:@"map_projectBackgroud"];
    }
    return _backgroundImageView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 292, 1)];
        _cutLine.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine;
}

-(UIImageView *)redImageView{
    if(!_redImageView){
        _redImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 20, 20)];
        _redImageView.image = [GetImagePath getImagePath:@"map_project_red"];
    }
    return _redImageView;
}

-(UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _countLabel.center = CGPointMake(10, 10);
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.text = self.number;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

-(UILabel *)stageLabel{
    if(!_stageLabel){
        _stageLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 6, 130, 36)];
        _stageLabel.textColor = BlueColor;
        _stageLabel.font = FONT;
        if([self.model.a_projectstage isEqualToString:@"1"]){
            _stageLabel.text = @"土地信息阶段";
        }else if([self.model.a_projectstage isEqualToString:@"2"]){
            _stageLabel.text = @"主体设计阶段";
        }else if([self.model.a_projectstage isEqualToString:@"3"]){
            _stageLabel.text = @"主体施工阶段";
        }else if([self.model.a_projectstage isEqualToString:@"4"]){
            _stageLabel.text = @"装修阶段";
        }else{
            _stageLabel.text = @"土地信息阶段";
        }
    }
    return _stageLabel;
}

-(UIButton *)focusBtn{
    if(!_focusBtn){
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _focusBtn.frame = CGRectMake(210, 22, 81, 28);
        if([self.model.isFocused isEqualToString:@"0"]){
            [_focusBtn setImage:[GetImagePath getImagePath:@"addfocus"] forState:UIControlStateNormal];
        }else{
            [_focusBtn setImage:[GetImagePath getImagePath:@"cancelfocus"] forState:UIControlStateNormal];
        }
        [_focusBtn addTarget:self action:@selector(focusBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusBtn;
}

-(UILabel *)projectName{
    if(!_projectName){
        _projectName = [[UILabel alloc] initWithFrame:CGRectMake(14, 48, 264, 20)];
        _projectName.text = self.model.a_projectName;
        _projectName.font = [UIFont systemFontOfSize:19];
    }
    return _projectName;
}

-(UILabel *)projectAddress{
    if(!_projectAddress){
        _projectAddress = [[UILabel alloc] initWithFrame:CGRectMake(14, 70, 264, 20)];
        _projectAddress.textColor = AllDeepGrayColor;
        NSString* tempStr = [NSString stringWithFormat:@"%@ %@",self.model.a_city,self.model.a_landAddress];
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:BlueColor range:NSMakeRange(0, self.model.a_city.length)];
        _projectAddress.attributedText = attStr;
        
    }
    return _projectAddress;
}

-(UILabel *)projectInvestment{
    if(!_projectInvestment){
        _projectInvestment = [[UILabel alloc] initWithFrame:CGRectMake(14, 95, 90, 20)];
        _projectInvestment.text = @"投资额(百万)";
        _projectInvestment.font = FONT;
        _projectInvestment.textColor = BlueColor;
    }
    return _projectInvestment;
}

-(UILabel *)projectArea{
    if(!_projectArea){
        _projectArea = [[UILabel alloc] initWithFrame:CGRectMake(152, 95, 90, 20)];
        _projectArea.textColor = BlueColor;
        _projectArea.text = @"建筑面积(㎡)";
        _projectArea.font = FONT;
    }
    return _projectArea;
}

-(UILabel *)projectInvestmentCount{
    if(!_projectInvestmentCount){
        _projectInvestmentCount = [[UILabel alloc] initWithFrame:CGRectMake(14, 115, 90, 20)];
        _projectInvestmentCount.font = FONT;
        if([[NSString stringWithFormat:@"%@",self.model.a_investment] isEqualToString:@""]){
            _projectInvestmentCount.text = @"－";
            _projectInvestmentCount.textColor = AllNoDataColor;
        }else{
            if([[NSString stringWithFormat:@"%@",self.model.a_investment] isEqualToString:@"0"]){
                _projectInvestmentCount.text = @"－";
                _projectInvestmentCount.textColor = AllNoDataColor;
            }else{
                _projectInvestmentCount.text = [NSString stringWithFormat:@"%@",self.model.a_investment];
                _projectInvestmentCount.textColor = [UIColor blackColor];
            }
        }
    }
    return _projectInvestmentCount;
}

-(UILabel *)projectAreaCount{
    if(!_projectAreaCount){
        _projectAreaCount = [[UILabel alloc] initWithFrame:CGRectMake(152, 115, 90, 20)];
        _projectAreaCount.font = FONT;
        if([[NSString stringWithFormat:@"%@",self.model.a_storeyArea] isEqualToString:@""]){
            _projectAreaCount.text = @"－";
            _projectAreaCount.textColor = AllNoDataColor;
        }else{
            if([[NSString stringWithFormat:@"%@",self.model.a_storeyArea] isEqualToString:@"0"]){
                _projectAreaCount.text = @"－";
                _projectAreaCount.textColor = AllNoDataColor;
            }else{
                _projectAreaCount.text = [NSString stringWithFormat:@"%@",self.model.a_storeyArea];
                _projectAreaCount.textColor = [UIColor blackColor];
            }
        }
    }
    return _projectAreaCount;
}

-(UILabel *)lastUpdatedTime{
    if(!_lastUpdatedTime){
        _lastUpdatedTime = [[UILabel alloc] initWithFrame:CGRectMake(14, 135, 100, 20)];
        _lastUpdatedTime.font = OTHERFONT;
        _lastUpdatedTime.text = @"最后更新时间";
    }
    return _lastUpdatedTime;
}

-(UILabel *)lastUpdatedTimeCount{
    if(!_lastUpdatedTimeCount){
        _lastUpdatedTimeCount = [[UILabel alloc] initWithFrame:CGRectMake(108, 135, 140, 20)];
        _lastUpdatedTimeCount.font = OTHERFONT;
        _lastUpdatedTimeCount.text = [self.model.a_lastUpdatedTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    return _lastUpdatedTimeCount;
}


-(void)focusBtnAction{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([self.isFocused isEqualToString:@"0"]){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                    [self.focusBtn setImage:[GetImagePath getImagePath:@"cancelfocus"] forState:UIControlStateNormal];
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:nil];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.focusBtn setImage:[GetImagePath getImagePath:@"addfocus"] forState:UIControlStateNormal];
                    self.isFocused = @"0";
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:^{
                [ErrorCode alert];
            }];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(gotoLoginView)]){
            [self.delegate gotoLoginView];
        }
    }
}
@end
