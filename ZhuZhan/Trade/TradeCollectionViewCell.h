//
//  TradeCollectionViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-6.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel* myLabel;
+(TradeCollectionViewCell*)dequeueReusableCellWithCollectionView:(UICollectionView*)collectionView reuseIdentifier:(NSString*)identifier forIndexPath:(NSIndexPath*)indexPath info:(NSDictionary*)dic;
@end
