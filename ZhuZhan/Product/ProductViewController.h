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
@interface ProductViewController : UIViewController<EGORefreshTableDelegate>{
	//EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
    
    int startIndex;
}

@end
