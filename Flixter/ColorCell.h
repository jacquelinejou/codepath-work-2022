//
//  ColorCell.h
//  Flixter
//
//  Created by jacquelinejou on 6/17/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;


@end

NS_ASSUME_NONNULL_END
