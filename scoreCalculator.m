

#import "scoreCalculator.h"



@implementation scoreCalculator
double currentMaxAccelX;
double currentMaxAccelY;
double currentMaxAccelZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;
id yourObject;

double fkingX;
double fkingY;
double fkingZ;
int stopShit = 0;
double totalShit = 0.0;
double score;

- (void)trigger:(NSTimer *)sender{
 
    if(stopShit == self.numIter)
    {
        [sender invalidate];
        if(totalShit < 0)
        {
            totalShit = totalShit*(-1);
        }
        if(totalShit > 15000)
        {
            totalShit = 15000;
           
        }
        NSLog(@"SEE THIS ");
        NSLog(@"x = %f, y = %f, z = %f.", fkingX, fkingY, fkingZ);
        totalShit = (fkingX) + (fkingY*5) - ((1/3) * fkingZ);
        NSLog(@"Final Score: %f ", totalShit);
        self.score = fabs(totalShit);
        NSLog(@"%f", self.score);
        stopShit = 0;
        
    }
    //yourObject = sender.userInfo;
    
    CMAccelerometerData* data = [self.motionManager accelerometerData];
    
    NSLog(@"x = %f, y = %f, z = %f.", data.acceleration.x, data.acceleration.y, data.acceleration.z);
    
    fkingX += fabs(data.acceleration.x);
    fkingY += fabs(data.acceleration.y);
    fkingZ += fabs(data.acceleration.z);
    
    stopShit++;
    
    
    
}
- (void)accelaScore:(NSInteger *) time{
    NSLog(@"This is the load that I want");
    //[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    self.numIter = *(time);
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    self.motionManager = [[CMMotionManager alloc] init];
   
    [self.motionManager startAccelerometerUpdates];
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(trigger:) userInfo:yourObject repeats:YES];
 
}

- (void)viewDidLoad:(NSInteger *) time
{
    NSLog(@"This is the load that I want");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    self.numIter = *(time);
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    [self.motionManager startAccelerometerUpdates];
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(trigger:) userInfo:yourObject repeats:YES];
    
    
    
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    
    
    self.accX.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    if(fabs(acceleration.x) > fabs(currentMaxAccelX))
    {
        currentMaxAccelX = acceleration.x;
    }
    self.accY.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    if(fabs(acceleration.y) > fabs(currentMaxAccelY))
    {
        currentMaxAccelY = acceleration.y;
    }
    self.accZ.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    if(fabs(acceleration.z) > fabs(currentMaxAccelZ))
    {
        currentMaxAccelZ = acceleration.z;
    }
    
    self.maxAccX.text = [NSString stringWithFormat:@" %.2f",totalShit];
    self.maxAccY.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelY];
    self.maxAccZ.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelZ];
    
    
}
-(void)outputRotationData:(CMRotationRate)rotation
{
    
    self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
    if(fabs(rotation.x)> fabs(currentMaxRotX))
    {
        currentMaxRotX = rotation.x;
    }
    self.rotY.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
    if(fabs(rotation.y) > fabs(currentMaxRotY))
    {
        currentMaxRotY = rotation.y;
    }
    self.rotZ.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
    if(fabs(rotation.z) > fabs(currentMaxRotZ))
    {
        currentMaxRotZ = rotation.z;
    }
    
    self.maxRotX.text = [NSString stringWithFormat:@" %.2f",currentMaxRotX];
    self.maxRotY.text = [NSString stringWithFormat:@" %.2f",currentMaxRotY];
    self.maxRotZ.text = [NSString stringWithFormat:@" %.2f",currentMaxRotZ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetMaxValues:(id)sender {
    
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
}
@end
