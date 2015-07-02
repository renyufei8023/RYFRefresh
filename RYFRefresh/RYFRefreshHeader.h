//
//  RYFRefreshHeader.h
//  RYFRefresh
//
//  Created by dujinyue on 15/7/1.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);

@interface RYFRefreshHeader : NSObject
@property UIScrollView *scrollView;
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;

-(void)header;


-(void)endRefreshing;
-(void)beginRefreshing;
@end
