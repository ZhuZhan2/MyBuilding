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
    
    
    NSArray* labelArray=dic[@"cellLabel"];
    NSArray* imageArray=dic[@"cellImage"];
    if (cell.myLabel) {
        cell.myLabel.text=labelArray[indexPath.row];
        cell.myImageView.image=imageArray[indexPath.row];
    }else{
        //cell大小CGSizeMake(148, 250);
        cell.myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 148, 125)];
        cell.myImageView.image=imageArray[indexPath.row];
        [cell.contentView addSubview:cell.myImageView];
        
        cell.myLabel=[[UILabel alloc]initWithFrame:CGRectMake(0 , 125, 148, 125)];
        cell.myLabel.numberOfLines=0;
        cell.myLabel.text=labelArray[indexPath.row];
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
