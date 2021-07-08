//
//  LoginViewController.m
//  insta
//
//  Created by Paula Leticia Geronimo on 7/8/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tapLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            [self alert:@"Could not log in user"];
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}
-(void) onLogout {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}
-(void) alert: (NSString *)errorMessage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING"
    message:errorMessage
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
    

}
-(BOOL)validUserAndPassword {
    if ([self.usernameField.text isEqual:@""]||[self.passwordField.text isEqual:@""]) {
        [self alert:@"Invalid username and password."];
        return false;
    }
    return true;
    
}

- (IBAction)tapSignup:(id)sender {
    if ([self validUserAndPassword]) {
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        //newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING"
                message:@"Unable to sign up user."
                preferredStyle:(UIAlertControllerStyleAlert)];
                // create an OK action
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * _Nonnull action) {
                    // handle response here.
                }];
                // add the OK action to the alert controller
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                // manually segue to logged in view
            }
        }];
    }

//    // initialize a user object
//    PFUser *newUser = [PFUser user];
//
//    // set user properties
//    newUser.username = self.usernameField.text;
//    //newUser.email = self.emailField.text;
//    newUser.password = self.passwordField.text;
//
//    // call sign up function on the object
//    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
//        if (error != nil) {
//            NSLog(@"Error: %@", error.localizedDescription);
//        } else {
//            NSLog(@"User registered successfully");
//            // manually segue to logged in view
//        }
//    }];
}



//
//#pragma mark - Navigation
//
// //In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     //Get the new view controller using [segue destinationViewController].
//     //Pass the selected object to the new view controller.
//}


@end
