//
//  PDRefreshControll.m
//  PDStrategy
//
//  Created by Pavel Deminov on 22/10/2017.
//

#import "PDRefreshControll.h"

@implementation PDRefreshControll

- (void)endRefreshing {
    self.loading = false;
}

- (void)beginRefreshing {
    self.loading = true;
}

- (void)setDrag:(BOOL)drag {
    _drag = drag;
    [self updateUI];
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
    [self updateUI];
}

- (void)updateUI {
    if (self.loading) {
        if (!self.isRefreshing) {
            [super beginRefreshing];
        }
    } else {
        if (self.isRefreshing) {
            if (!self.drag) {
                [super endRefreshing];
            }
        } else {
            
        }
    }
    
}

@end
