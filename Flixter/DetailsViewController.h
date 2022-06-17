//
//  DetailsViewController.h
//  Flixter
//
//  Created by jacquelinejou on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController {
    NSDictionary *detailDict;
}
@property (strong, nonatomic) IBOutlet UIView *detailsView;

@property (nonatomic, strong) NSDictionary *detailDict;

@end

NS_ASSUME_NONNULL_END
