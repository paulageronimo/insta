//
//  FeedPostCell.m
//  insta
//
//  Created by Paula Leticia Geronimo on 7/8/21.
//

#import "FeedPostCell.h"
#import "Post.h"
#import "Parse/Parse.h"
//#import "UIImageView+AFNetworking.h"

@implementation FeedPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//- (void)refreshData {
//    self.likesLabel.text = [[NSString stringWithFormat:@"%@", self.post.likeCount] stringByAppendingString:@" likes"];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setPost:(Post *)post {
    NSLog(@"Got into post.");
    _post = post;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    PFUser *user = post[@"author"];
    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        self.usernameLabel.text =  user[@"username"];
    }];
    self.caption.text = post[@"caption"];
    // setup timestamp
    self.likesLabel.text = [[NSString stringWithFormat:@"%@", post.likeCount] stringByAppendingString:@" likes"];
        
    //self.timeLabel.text = [post.createdAt timeAgoSinceNow];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.timeLabel.text = [[formatter stringFromDate:self.post.createdAt] stringByReplacingOccurrencesOfString:@", " withString:@" \u2022 "];

    //PFFileObject *profilePic = (PFFileObject*)[UIImage imageNamed:@"Default_pfp.png"];
//    [profilePic getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error fetching profile pic: %@", error.localizedDescription);
//        } else {
//            UIImage *profilePic = [UIImage imageWithData:data];
//                [self.profilePic setImage:profilePic];
//        }
//    }];
    UIImage *profilePic = [UIImage imageNamed:@"Default_pfp.png"];
    [self.profilePic setImage:profilePic];
    
    PFFileObject *image = post[@"image"];
    [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            NSLog(@"Got image and posted");
            //NSURL * imageURL = [NSURL URLWithString:image.url];
            //[self.postImageView setImageWithURL:imageURL];
            UIImage *postImg = [UIImage imageWithData:data];
            [self.postImageView setImage:postImg];
            
//            - PFFileObject * image = user[@"profile_image"]; // set your column name from Parse here
//            - NSURL * imageURL = [NSURL URLWithString:profileImage.url];
//            - [self.profileImageView setImageWithURL:imageURL];
        }
    }];
    
    
}

//-(IBAction)onLike:(id)sender {
    // if (self.post.liked) { // unlike it
//        self.post.liked = false;
//        self.likeButton.selected = false;
//        self.post.likeCount = [NSNumber numberWithInt:[self.post.likeCount intValue]-1];
//        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            if (succeeded) {
//                NSLog(@"Unliked post");
//            } else {
//                NSLog(@"Error unliking post: %@", error.localizedDescription);
//            }
//        }];
//    } else { // like it
//        self.post.liked = true;
//        self.likeButton.selected = true;
//        self.post.likeCount = [NSNumber numberWithInt:[self.post.likeCount intValue]+1];
//        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            if (succeeded) {
//                NSLog(@"Liked post");
//            } else {
//                NSLog(@"Error liking post: %@", error.localizedDescription);
//            }
//        }];
//    }
//    [self refreshData];
//}


@end
