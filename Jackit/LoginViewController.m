//
//  LoginViewController.m
//  ParseExample
//
//  Created by Nick Barrowclough on 8/9/13.
//  Copyright (c) 2013 Nicholas Barrowclough. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        ViewController *myView = [[ViewController alloc] init];
        [self.navigationController pushViewController:myView animated:YES];
        return;

        //[self performSegueWithIdentifier:@"login" sender:self];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    [_usernameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    [self checkFieldsComplete];
}

- (void) checkFieldsComplete {
    if ([_usernameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

- (void) checkPasswordsMatch {
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}

- (void) registerNewUser {
    NSLog(@"registering....");
    PFUser *newUser = [PFUser user];
    newUser.username = _usernameField.text;
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            //[self performSegueWithIdentifier:@"login" sender:self];
            ViewController *myView = [[UIStoryboard storyboardWithName:@"Main"
                                                                bundle: nil] instantiateViewControllerWithIdentifier:@"ViewControllerID"];
            //UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:myView];
            [self.navigationController pushViewController:myView animated:YES];
        }
        else {
            NSLog(@"There was an error in registration");
        }
    }];
}

- (IBAction)registeredButton:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _loginOverlayView.frame = self.view.frame;
    }];
}

- (IBAction)loginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Login user!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            ViewController *myView = [[UIStoryboard storyboardWithName:@"Main"
                                                                bundle: nil] instantiateViewControllerWithIdentifier:@"ViewControllerID"];
            //UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:myView];
            [self.navigationController pushViewController:myView animated:YES];
        }
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ooops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
