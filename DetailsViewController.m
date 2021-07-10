//
//  DetailsViewController.m
//  insta
//
//  Created by Paula Leticia Geronimo on 7/9/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface DetailsViewController ()
@property (weak, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    //self.navBar.title = [@"Post by @" stringByAppendingString:self.post.author.username];
    
    // config buttons
    UIImageSymbolConfiguration *defaultConfig = [UIImageSymbolConfiguration configurationWithScale:UIImageSymbolScaleLarge];
    [self.likeButton setImage:[UIImage systemImageNamed:@"heart" withConfiguration:defaultConfig] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage systemImageNamed:@"heart.fill" withConfiguration:defaultConfig] forState:UIControlStateSelected];
    
    //self.likeButton.selected = [self.post.likedBy containsObject:[PFUser currentUser].username];
    //self.likeCountLabel.text = [[NSString stringWithFormat:@"%@", self.post.likeCount] stringByAppendingString:@" likes"];
    self.caption.text = _post[@"caption"];
    
    // setup timestamp
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.timeLabel.text = [[formatter stringFromDate:self.post.createdAt] stringByReplacingOccurrencesOfString:@", " withString:@" \u2022 "];
    
    // setup image
    PFFileObject *img = self.post.image;
    [img getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            UIImage *postImg = [UIImage imageWithData:data];
            [self.postImageView setImage:postImg];
        }
    }];
}

//- (void)refreshData {
//    self.likeCountLabel.text = [[NSString stringWithFormat:@"%@", self.post.likeCount] stringByAppendingString:@" likes"];
//}


@end
