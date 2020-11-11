//
//  UIScrollView+MJ.m
//  BaseProject
//
//  Created by Luminous on 2020/11/11.
//

#import "UIScrollView+MJ.h"

@implementation UIScrollView (MJ)

-(void)beginRefreshing
{
    //#warning 自动刷新(一进入程序就下拉刷新)
    if (!self.mj_header) return;
    [self.mj_header beginRefreshing];
}
- (void)addHeaderWithRefreshingBlock:(void (^)(void))block{
      MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    // 设置文字
    [header setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];

    header.arrowView.image = [UIImage imageNamed:@"MJ_arrow"];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:14];
     header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}
- (void)addFooterWithRefreshingBlock:(void (^)(void))block{

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
     footer.stateLabel.font = [UIFont systemFontOfSize:14];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];

    self.mj_footer = footer;
}

- (void)hiddenFooter:(BOOL)hide  //隐藏footer
{
    self.mj_footer.hidden = hide;

}
- (void)hiddenHeader:(BOOL)hide  //隐藏footer
{
    self.mj_header.hidden = hide;

}
-(void)headerEndRefreshing //结束head
{
    [self.mj_header endRefreshing];
}
-(void)footerEndRefreshing //结束footer
{
    [self.mj_footer endRefreshing];

}

-(void)noticeNoMoreData{  //没有数据显示出啦u
    [self.mj_footer endRefreshingWithNoMoreData];
}
@end
