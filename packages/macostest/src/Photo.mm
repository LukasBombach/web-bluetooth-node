#import "Photo.h"

@implementation Photo

- (id) init
{
    if ( self = [super init] )
    {
        [self setCaption:@"Default Caption"];
        [self setPhotographer:@"Default Photographer"];
    }
    return self;
}
    
- (NSString*) caption {
    return caption;
}

- (NSString*) photographer {
    return photographer;
}

- (void) setCaption: (NSString*)input
{
    [caption autorelease];
    caption = [input retain];
}

- (void) setPhotographer: (NSString*)input
{
    [photographer autorelease];
    photographer = [input retain];
}

@end
