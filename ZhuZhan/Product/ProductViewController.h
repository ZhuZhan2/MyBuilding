//
//  ProductViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-2.
//
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "TMQuiltView.h"

@interface ProductViewController : UIViewController{
//	//EGOHeader
//    EGORefreshTableHeaderView *_refreshHeaderView;
//    //EGOFoot
//    EGORefreshTableFooterView *_refreshFooterView;
//    //
//    BOOL _reloading;
    
    int startIndex;
    
    NSMutableArray *showArr;
    TMQuiltView *qtmquitView;
}

@end
