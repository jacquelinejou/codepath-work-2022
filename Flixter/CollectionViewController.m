//
//  CollectionViewController.m
//  Flixter
//
//  Created by jacquelinejou on 6/17/22.
//

#import "CollectionViewController.h"
#import "ColorCell.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *movieArray;
@end

@implementation CollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    
    [self fetchMovies];
}

-(void)fetchMovies {
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=21b8f81cdf1293cabefccd047ba0672a"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                  message:@"Movies failed to load. Check your connection."
                                                  preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction * action) {}];

                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", dataDictionary);
               self.movieArray = dataDictionary[@"results"];
               [self.collectionView reloadData];
               
//               MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
//               NSDictionary *movie = movieArray[indexPath.row];
//               NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
//               NSString *posterURLString = movie[@"poster_path"];
//               NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
//               NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
               NSLog(@"%@", self.movieArray);
               // [cell.posterImage setImageWithURL:posterURL];
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
           }
       }];
    [task resume];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
//    NSDictionary *movie = movieArray[indexPath.row];
//    NSLog([NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section]);
//    // cell.textLabel.text = [NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section];
//   // cell.textLabel.text = movie[@"title"];
//    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
//    NSString *posterURLString = movie[@"poster_path"];
//    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
//    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
//    NSLog(@"%@", posterURL);
//    [cell.posterImage setImageWithURL:posterURL];
//}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}

//- (UIColor*)colorForIndexPath:(NSIndexPath *) indexPath{
//    if(indexPath.row >= 100){
//        return UIColor.blackColor;    // return black if we get an unexpected row index
//    }
//
//    CGFloat hueValue = (CGFloat)(indexPath.row)/(CGFloat)(100);
//    return [UIColor colorWithHue:hueValue saturation:1.0 brightness:1.0 alpha:1.0];
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCollectionCell" forIndexPath:indexPath];
   NSDictionary *movie = self.movieArray[indexPath.row];
   NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
   NSString *posterURLString = movie[@"poster_path"];
   NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
   NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
   NSLog(@"%@", posterURL);
    [cell.posterImage setImageWithURL:posterURL];
    
    return cell;
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
