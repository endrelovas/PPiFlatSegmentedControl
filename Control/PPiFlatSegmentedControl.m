//
//  PPiFlatSwitch.m
//  PPiFlatSwitch
//
//  Created by Pedro Piñera Buendía on 12/08/13.
//  Copyright (c) 2013 PPinera. All rights reserved.
//

#import "PPiFlatSegmentedControl.h"
#import "UIAwesomeButton.h"
#define segment_corner 5.0

@interface PPiFlatSegmentedControl()
@property (nonatomic,strong) NSMutableArray *segments;
@property (nonatomic) NSUInteger currentSelected;
@property (nonatomic,strong) NSMutableArray *separators;
@property (nonatomic,copy) selectionBlock selBlock;
@property (nonatomic) CGFloat iconSeparation;
@property (nonatomic,strong) UIView* viewRounded;
@end

@implementation PPiFlatSegmentedControl

- (id)initWithFrame:(CGRect)frame
              items:(NSArray*)items
  andSelectionBlock:(selectionBlock)block
     iconSeparation:(CGFloat)separation
{
    self = [super initWithFrame:frame];
    if (self) {
        //Selection block
        _selBlock=block;
        
        //Icon separation
        self.iconSeparation = separation;
                
        //Adding items
        [self addItems:items withFrame:frame];
        
        //Background Color
        self.backgroundColor=[UIColor clearColor];
        
        //Applying corners
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=segment_corner;
        
        //Default selected 0
        _currentSelected=0;
    }
    return self;
}

- (void)addItems:(NSArray*)items withFrame:(CGRect)frame
{
    if (_viewRounded == nil)
    {
        _viewRounded = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_viewRounded];
    }
    // Removing segments and separators
    for (UIView *separator in self.separators) {
        [separator removeFromSuperview];
    }
    [self.separators removeAllObjects];
    for (UIView *segment in self.segments) {
        [segment removeFromSuperview];
    }
    [self.segments removeAllObjects];
    
    //Generating segments
    float buttonWith=ceil(frame.size.width / items.count);
    int i=0;
    for(PPiFlatSegmentItem *item in items){
        NSString *text=item.title;
        NSObject *icon=item.icon;
        
        UIAwesomeButton  *button;
        if([icon isKindOfClass:[UIImage class]]) {
            button = [[UIAwesomeButton alloc] initWithFrame:CGRectMake(buttonWith*i, 0, buttonWith, frame.size.height) text:text iconImage:(UIImage *)icon attributes:@{} andIconPosition:item.iconPosition];
        }
        else {
            button = [[UIAwesomeButton alloc] initWithFrame:CGRectMake(buttonWith*i, 0, buttonWith, frame.size.height) text:text icon:(NSString *)icon attributes:@{} andIconPosition:item.iconPosition];
        }
        
        UIAwesomeButton __weak *wbutton = button;
        [button setActionBlock:^(UIAwesomeButton *button) {
            [self segmentSelected:wbutton];
        }];
        
        //Adding to self view
        [self.segments addObject:button];
        [self addSubview:button];
        
        //Adding separator
        if(i!=0){
            UIView *separatorView=[[UIView alloc] initWithFrame:CGRectMake(i*buttonWith, 0, self.borderWidth, frame.size.height)];
            [self addSubview:separatorView];
            [self.separators addObject:separatorView];
        }
        i++;
    }
    
    // Bringins separators to the front
    for (UIView* separator in self.separators) {
        [self bringSubviewToFront:separator];
    }
}

- (void) setForceTapGestureRecogniser:(bool)ForceTapGestureRecogniser {
    _ForceTapGestureRecogniser = ForceTapGestureRecogniser;
    for(UIAwesomeButton *item in self.segments) {
        [item setForceTapGestureRecogniser:ForceTapGestureRecogniser];
    }
}


#pragma mark - Lazy instantiations

-(NSMutableArray*)segments
{
    if(!_segments)_segments=[[NSMutableArray alloc] init];
    return _segments;
}
-(NSMutableArray*)separators
{
    if(!_separators)_separators=[[NSMutableArray alloc] init];
    return _separators;
}


#pragma mark - Actions

-(void)segmentSelected:(id)sender
{
    if(sender) {
        NSUInteger selectedIndex=[self.segments indexOfObject:sender];
        [self setSelected:YES segmentAtIndex:selectedIndex];
        if(self.selBlock) {
            self.selBlock(selectedIndex);
        }
    }
}


#pragma mark - Getters

-(BOOL)isSelectedSegmentAtIndex:(NSUInteger)index
{
    return (index==self.currentSelected);
}

- (NSUInteger)numberOfSegments
{
    return self.segments.count;
}


#pragma mark - Setters

- (void)setIconPosition:(IconPosition)iconPosition forSegment:(NSUInteger)index {
    UIAwesomeButton *segment = [self.segments objectAtIndex:index];
    [segment setIconPosition:iconPosition];
}

- (void)setSegmentAtIndex:(NSUInteger)index enabled:(BOOL)enabled
{
    if (index >= self.segments.count) return;
    UIButton *button = self.segments[index];
    [button setEnabled:enabled];
    [button setUserInteractionEnabled:enabled];
}

-(void)updateSegmentsFormat
{
    //Setting border color
/*    if (self.borderColor) {
        self.layer.borderWidth=self.borderWidth;
        self.layer.borderColor=self.borderColor.CGColor;
    }
    else {
        self.layer.borderWidth=0;
    }*/
    
    //Updating segments color
    [_viewRounded setBackgroundColor:[UIColor clearColor]];
    [_viewRounded.layer setCornerRadius:segment_corner];
    [_viewRounded.layer setBorderColor:self.borderColor.CGColor];
    [_viewRounded.layer setBorderWidth:self.borderWidth];

    for (UIView *separator in self.separators) {
        if (self.separatorColor)
            separator.backgroundColor = self.separatorColor;
        else
            separator.backgroundColor=self.borderColor;
        separator.frame=CGRectMake(separator.frame.origin.x , separator.frame.origin.y,self.borderWidth , separator.frame.size.height);
    }
    
    //Modifying buttons with current State
    for (UIAwesomeButton *segment in self.segments)
    {
        //Set text aligment
        [segment setTextAlignment:NSTextAlignmentCenter];
        
        //Setting icon separation
        [segment setSeparation:self.iconSeparation];
        
        //Setting format depending on if it's selected or not
        if([self.segments indexOfObject:segment]==self.currentSelected){
            //Selected-one
            if(self.selectedColor){
                [segment setBackgroundColor:self.selectedColor forUIControlState:UIControlStateNormal];
                
            }
            if(self.selectedTextAttributes)
                [segment setAttributes:self.selectedTextAttributes forUIControlState:UIControlStateNormal];
        }
        else{
            //Non selected
            if(self.color)
                [segment setBackgroundColor:self.color forUIControlState:UIControlStateNormal];
            
            if(self.textAttributes)
                [segment setAttributes:self.textAttributes forUIControlState:UIControlStateNormal];
        }
    }
}

- (void)setItems:(NSArray*)items
{
    [self addItems:items withFrame:self.frame];
    [self updateSegmentsFormat];
}

-(void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor=selectedColor;
    [self updateSegmentsFormat];
}

-(void)setColor:(UIColor *)color
{
    _color=color;
    [self updateSegmentsFormat];
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth=borderWidth;
    [self updateSegmentsFormat];
}

-(void)setIconPosition:(IconPosition)iconPosition
{
    _iconPosition=iconPosition;
    for (UIAwesomeButton *segment in self.segments)
        [segment setIconPosition:iconPosition];
}

-(void)setTitle:(id)title forSegmentAtIndex:(NSUInteger)index
{
    //Getting the Segment
    if(index<self.segments.count) {
        UIAwesomeButton *segment=self.segments[index];
        if([title isKindOfClass:[NSString class]]){
            [segment setButtonText:title];
        }
    }
}
-(void)setBorderColor:(UIColor *)borderColor{
    //Setting boerder color to all view
    _borderColor=borderColor;
    [self updateSegmentsFormat];
}

-(void)setSelected:(BOOL)selected segmentAtIndex:(NSUInteger)segment{
    if (selected) {
        self.currentSelected=segment;
        [self updateSegmentsFormat];
    }
}

-(void)setTextAttributes:(NSDictionary *)textAttributes
{
    _textAttributes=textAttributes;
    [self updateSegmentsFormat];
}

-(void)setSelectedTextAttributes:(NSDictionary *)selectedTextAttributes
{
    _selectedTextAttributes=selectedTextAttributes;
    [self updateSegmentsFormat];
}

@end

