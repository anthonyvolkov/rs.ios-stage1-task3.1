#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) UILabel *labelResultColor;
@property (weak, nonatomic) UIView *viewResultColor;

@property (weak, nonatomic) UILabel *labelRed;
@property (weak, nonatomic) UILabel *labelGreen;
@property (weak, nonatomic) UILabel *labelBlue;

@property (weak, nonatomic) UITextField *textFieldRed;
@property (weak, nonatomic) UITextField *textFieldGreen;
@property (weak, nonatomic) UITextField *textFieldBlue;

@property (weak, nonatomic) UIButton *buttonProcess;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.textFieldRed.delegate = self;
    self.textFieldGreen.delegate = self;
    self.textFieldBlue.delegate = self;
    
}

- (void)buttonProcessTapped:(UIButton *)sender {
    //  check isEmpty
    if (self.textFieldRed.text.length == 0 ||
        self.textFieldGreen.text.length == 0 ||
        self.textFieldBlue.text.length == 0) {
        
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
        self.textFieldRed.text = self.textFieldGreen.text = self.textFieldBlue.text = @"";
        [self.view endEditing:YES];
        return;
    }
    //  check isNumber
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([self.textFieldRed.text rangeOfCharacterFromSet:notDigits].location != NSNotFound ||
        [self.textFieldGreen.text rangeOfCharacterFromSet:notDigits].location != NSNotFound ||
        [self.textFieldBlue.text rangeOfCharacterFromSet:notDigits].location != NSNotFound) {
        
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
        self.textFieldRed.text = self.textFieldGreen.text = self.textFieldBlue.text = @"";
        [self.view endEditing:YES];
        return;
    }
    int red = self.textFieldRed.text.intValue;
    int green = self.textFieldGreen.text.intValue;
    int blue = self.textFieldBlue.text.intValue;
    
    // check range
    if (red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255) {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
        self.textFieldRed.text = self.textFieldGreen.text = self.textFieldBlue.text = @"";
        [self.view endEditing:YES];
        return;
    }
    
    NSMutableString *colorHex = [[[NSMutableString alloc] init] autorelease];
    
    
    red < 16 ? [colorHex appendFormat:@"0x0%X", red] : [colorHex appendFormat:@"0x%X", red];
    green < 16 ? [colorHex appendFormat:@"0%X", green] : [colorHex appendFormat:@"%X", green];
    blue < 16 ? [colorHex appendFormat:@"0%X", blue] : [colorHex appendFormat:@"%X", blue];
    
    self.labelResultColor.text = colorHex;
    self.viewResultColor.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    self.textFieldRed.text = self.textFieldGreen.text = self.textFieldBlue.text = @"";
    [self.view endEditing:YES];
}


// MARK: - Setup UI

- (void)setupUI {
    self.labelResultColor = [[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 40)] autorelease];
    self.labelResultColor.text = @"Color";
    
    self.viewResultColor = [[[UIView alloc]
                             initWithFrame:CGRectMake(self.labelResultColor.frame.origin.x + self.labelResultColor.bounds.size.width + 20,
                                                      self.labelResultColor.frame.origin.y,
                                                      200,
                                                      self.labelResultColor.bounds.size.height)] autorelease];
    self.viewResultColor.backgroundColor = [UIColor grayColor];
    
    self.labelRed = [[[UILabel alloc] initWithFrame:CGRectMake(self.labelResultColor.frame.origin.x,
                                                               self.labelResultColor.frame.origin.y + self.labelResultColor.bounds.size.height + 20,
                                                               70,
                                                               30)] autorelease];
    self.labelRed.text = @"RED";
    
    self.textFieldRed = [[[UITextField alloc] initWithFrame:CGRectMake(self.labelRed.frame.origin.x + self.labelRed.bounds.size.width + 20,
                                                                       self.labelRed.frame.origin.y,
                                                                       230,
                                                                       self.labelRed.bounds.size.height)] autorelease];
    self.textFieldRed.placeholder = @"0..255";
    self.textFieldRed.layer.borderWidth = 1.0;
    self.textFieldRed.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.textFieldRed.layer.cornerRadius = 5.0;
    self.textFieldRed.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.labelRed.bounds.size.height)] autorelease];
    self.textFieldRed.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.labelGreen = [[[UILabel alloc] initWithFrame:CGRectMake(self.labelRed.frame.origin.x,
                                                                 self.labelRed.frame.origin.y + self.labelRed.bounds.size.height + 20,
                                                                 self.labelRed.bounds.size.width,
                                                                 self.labelRed.bounds.size.height)] autorelease];
    self.labelGreen.text = @"GREEN";
    
    self.textFieldGreen = [[[UITextField alloc] initWithFrame:CGRectMake(self.labelGreen.frame.origin.x + self.labelGreen.bounds.size.width + 20,
                                                                         self.labelGreen.frame.origin.y,
                                                                         self.textFieldRed.bounds.size.width,
                                                                         self.labelGreen.bounds.size.height)] autorelease];
    self.textFieldGreen.placeholder = @"0..255";
    self.textFieldGreen.layer.borderWidth = 1.0;
    self.textFieldGreen.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.textFieldGreen.layer.cornerRadius = 5.0;
    self.textFieldGreen.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.labelGreen.bounds.size.height)] autorelease];
    self.textFieldGreen.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.labelBlue = [[[UILabel alloc] initWithFrame:CGRectMake(self.labelGreen.frame.origin.x,
                                                                self.labelGreen.frame.origin.y + self.labelGreen.bounds.size.height + 20,
                                                                self.labelGreen.bounds.size.width,
                                                                self.labelGreen.bounds.size.height)] autorelease];
    self.labelBlue.text = @"BLUE";
    
    self.textFieldBlue = [[[UITextField alloc] initWithFrame:CGRectMake(self.labelBlue.frame.origin.x + self.labelGreen.bounds.size.width + 20,
                                                                        self.labelBlue.frame.origin.y,
                                                                        self.textFieldRed.bounds.size.width,
                                                                        self.labelBlue.bounds.size.height)] autorelease];
    self.textFieldBlue.placeholder = @"0..255";
    self.textFieldBlue.layer.borderWidth = 1.0;
    self.textFieldBlue.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.textFieldBlue.layer.cornerRadius = 5.0;
    self.textFieldBlue.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.labelBlue.bounds.size.height)] autorelease];
    self.textFieldBlue.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.buttonProcess = [[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 50,
                                                                     self.labelBlue.frame.origin.y + self.labelBlue.bounds.size.height + 40,
                                                                     100,
                                                                     30)] autorelease];
    //  setuo buttonProcess
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor: UIColor.blueColor forState: UIControlStateNormal];
    [self.buttonProcess setTitleColor: UIColor.grayColor forState: UIControlStateHighlighted];
    //  add tarrget and selection for event
    [self.buttonProcess addTarget:self
                           action:@selector(buttonProcessTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    //  accessibilityIdentifiers
    self.view.accessibilityIdentifier = @"mainView";
    
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    
    //  addSubviews
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.viewResultColor];
    
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.textFieldRed];
    
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.textFieldGreen];
    
    [self.view addSubview:self.labelBlue];
    [self.view addSubview:self.textFieldBlue];
    
    [self.view addSubview:self.buttonProcess];
}

// MARK: - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.labelResultColor.text = @"Color";
    
}

@end
