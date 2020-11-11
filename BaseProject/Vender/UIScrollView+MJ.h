//
//  UIScrollView+MJ.h
//  BaseProject
//
//  Created by Luminous on 2020/11/11.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJ)
- (void)beginRefreshing;  //一进来就开始刷新
- (void)addHeaderWithRefreshingBlock:(void (^)(void))block;
- (void)addFooterWithRefreshingBlock:(void (^)(void))block;
- (void)hiddenFooter:(BOOL)hide;  ////隐藏footer

-(void)headerEndRefreshing; //结束head
-(void)footerEndRefreshing; //结束footer

-(void)noticeNoMoreData;////没有数据显示出啦u
- (void)hiddenHeader:(BOOL)hide;
@end


NS_ASSUME_NONNULL_END
