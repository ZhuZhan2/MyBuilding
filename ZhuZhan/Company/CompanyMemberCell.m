//
//  CompanyMemberCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/22.
//
//

#import "CompanyMemberCell.h"

@implementation CompanyMemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(280, 17, 26, 26)];
    }
    return self;
}

@end
