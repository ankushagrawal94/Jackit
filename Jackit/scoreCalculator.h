

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>




@interface scoreCalculator : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *accelX;

@property (strong, nonatomic) IBOutlet UILabel *accX;
@property (strong, nonatomic) IBOutlet UILabel *accY;
@property (strong, nonatomic) IBOutlet UILabel *accZ;

@property (strong, nonatomic) IBOutlet UILabel *maxAccX;
@property (strong, nonatomic) IBOutlet UILabel *maxAccY;
@property (strong, nonatomic) IBOutlet UILabel *maxAccZ;

@property (strong, nonatomic) IBOutlet UILabel *rotX;
@property (strong, nonatomic) IBOutlet UILabel *rotY;
@property (strong, nonatomic) IBOutlet UILabel *rotZ;

@property (strong, nonatomic) IBOutlet UILabel *maxRotX;
@property (strong, nonatomic) IBOutlet UILabel *maxRotY;
@property (strong, nonatomic) IBOutlet UILabel *maxRotZ;
@property (nonatomic) NSInteger numIter;
@property id yourObject;




- (IBAction)resetMaxValues:(id)sender;
- (void)trigger:(NSTimer *)sender;
- (void)accelaScore:(NSInteger *) time;
- (void)viewDidLoad:(NSInteger *) time;
-(void)outputAccelertionData:(CMAcceleration)acceleration;
-(void)outputRotationData:(CMRotationRate)rotation;



@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;
@property double score;

@end
