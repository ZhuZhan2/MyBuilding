//
//  TradeCollectionViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-6.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "TradeCollectionViewCell.h"

@implementation TradeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



+(TradeCollectionViewCell*)dequeueReusableCellWithCollectionView:(UICollectionView*)collectionView reuseIdentifier:(NSString*)identifier forIndexPath:(NSIndexPath*)indexPath info:(NSDictionary*)dic{
    
    TradeCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor=[UIColor whiteColor];
    cell.contentView.layer.cornerRadius=7;

    cell.layer.shadowColor=[[UIColor grayColor]CGColor];
    cell.layer.shadowOffset=CGSizeMake(0, .1);//使阴影均匀
    cell.layer.shadowOpacity=.5;//阴影的alpha
    
    
    NSArray* ary=dic[@"cellText"];
    if (cell.myLabel) {
        cell.myLabel.text=ary[indexPath.row];
    }else{
        cell.myLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
        cell.myLabel.text=ary[indexPath.row];
        [cell.contentView addSubview:cell.myLabel];
    }
    
    
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
