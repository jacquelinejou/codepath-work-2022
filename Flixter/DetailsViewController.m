//
//  DetailsViewController.m
//  Flixter
//
//  Created by jacquelinejou on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

//@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// @property (strong, nonatomic) IBOutlet UIView *detailsView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // NSLog(@"%@", self.detailDict);
    NSLog(@"%@", self.detailDict);
    self.titleLabel.text = self.detailDict[@"title"];
    self.synopsisLabel.text = self.detailDict[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.detailDict[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    // NSLog(@"%@", posterURL);
    [self.largeImageView setImageWithURL:posterURL];
    [self.smallImageView setImageWithURL:posterURL];
    // [self.detailsView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
