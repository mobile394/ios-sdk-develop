//
//  OCEventTarget.m
//  ownCloudSDK
//
//  Created by Felix Schwarz on 07.02.18.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

#import "OCEventTarget.h"

@implementation OCEventTarget

@synthesize eventID = _eventID;
@synthesize eventHandlerIdentifier = _eventHandlerIdentifier;

#pragma mark - Init
+ (instancetype)eventTargetWithEventID:(OCEventID)eventID eventHandlerIdentifier:(OCEventHandlerIdentifier)eventHandlerIdentifier
{
	return ([[self alloc] initWithEventID:eventID eventHandlerIdentifier:eventHandlerIdentifier]);
}

- (instancetype)initWithEventID:(OCEventID)eventID eventHandlerIdentifier:(OCEventHandlerIdentifier)eventHandlerIdentifier
{
	if ((self = [super init]) != nil)
	{
		_eventID = eventID;
		_eventHandlerIdentifier = eventHandlerIdentifier;
	}
	
	return (self);
}

#pragma mark - Event handler
- (void)handleEvent:(OCEvent *)event sender:(id)sender
{
	[[OCEvent eventHandlerWithIdentifier:_eventHandlerIdentifier] handleEvent:event sender:sender];
}

#pragma mark - Secure Coding
+ (BOOL)supportsSecureCoding
{
	return (YES);
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
	if ((self = [super init]) != nil)
	{
		_eventID = [[decoder decodeObjectOfClass:[NSNumber class] forKey:@"eventID"] unsignedIntegerValue];
		_eventHandlerIdentifier = [decoder decodeObjectOfClass:[NSString class] forKey:@"eventHandlerIdentifier"];
	}

	return (self);
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:@(_eventID) forKey:@"eventID"];
	[coder encodeObject:_eventHandlerIdentifier forKey:@"eventHandlerIdentifier"];
}

@end
