//
//  RYFRefreshFooter.h
//  RYFRefresh
//
//  Created by dujinyue on 15/7/1.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);

@interface RYFRefreshFooter : NSObject
@property UIScrollView *scrollView;
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;


-(void)footer;

-(void)endRefreshing;
-(void)beginRefreshing;
@end
