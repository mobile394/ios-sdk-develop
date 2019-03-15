//
//  OCUser.m
//  ownCloudSDK
//
//  Created by Felix Schwarz on 22.02.18.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

/*
 * Copyright (C) 2018, ownCloud GmbH.
 *
 * This code is covered by the GNU Public License Version 3.
 *
 * For distribution utilizing Apple mechanisms please see https://owncloud.org/contribute/iOS-license-exception/
 * You should have received a copy of this license along with this program. If not, see <http://www.gnu.org/licenses/gpl-3.0.en.html>.
 *
 */

#import "OCUser.h"
#import "OCMacros.h"

@implementation OCUser

@synthesize userName = _userName;
@synthesize displayName = _displayName;
@synthesize avatarData = _avatarData;

@dynamic isRemote;
@dynamic remoteHost;
@dynamic remoteUserName;

+ (instancetype)userWithUserName:(nullable NSString *)userName displayName:(nullable NSString *)displayName
{
	OCUser *user = [OCUser new];

	user.userName = userName;
	user.displayName = displayName;

	return (user);
}

- (BOOL)isRemote
{
	NSRange atRange;

	atRange = [_userName rangeOfString:@"@"];

	return (atRange.location != NSNotFound);
}

- (NSString *)remoteUserName
{
	NSRange atRange;

	atRange = [_userName rangeOfString:@"@"];

	if (atRange.location != NSNotFound)
	{
		return ([_userName substringToIndex:atRange.location]);
	}

	return (nil);
}

- (NSString *)remoteHost
{
	NSRange atRange;

	atRange = [_userName rangeOfString:@"@"];

	if (atRange.location != NSNotFound)
	{
		return ([_userName substringFromIndex:atRange.location+1]);
	}

	return (nil);
}

- (UIImage *)avatar
{
	if ((_avatar == nil) && (_avatarData != nil))
	{
		_avatar = [UIImage imageWithData:self.avatarData];
	}
	
	return (_avatar);
}

#pragma mark - Comparison
- (NSUInteger)hash
{
	return ((_userName.hash << 1) ^ (_displayName.hash >> 1));
}

- (BOOL)isEqual:(id)object
{
	OCUser *otherUser = OCTypedCast(object, OCUser);

	if (otherUser != nil)
	{
		#define compareVar(var) ((otherUser->var == var) || [otherUser->var isEqual:var])

		return (compareVar(_userName) && compareVar(_displayName) && compareVar(_emailAddress) && compareVar(_avatarData));
	}

	return (NO);
}

#pragma mark - Copying
- (id)copyWithZone:(NSZone *)zone
{
	OCUser *user = [OCUser new];

	user->_userName = _userName;
	user->_displayName = _displayName;
	user->_emailAddress = _emailAddress;
	user->_avatarData = _avatarData;
	user->_avatar = _avatar;

	return (user);
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
		self.userName = [decoder decodeObjectOfClass:[NSString class] forKey:@"userName"];
		self.displayName = [decoder decodeObjectOfClass:[NSString class] forKey:@"displayName"];
		self.emailAddress = [decoder decodeObjectOfClass:[NSString class] forKey:@"emailAddress"];
		self.avatarData = [decoder decodeObjectOfClass:[NSData class] forKey:@"avatarData"];
	}
	
	return (self);
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.userName forKey:@"userName"];
	[coder encodeObject:self.displayName forKey:@"displayName"];
	[coder encodeObject:self.emailAddress forKey:@"emailAddress"];
	[coder encodeObject:self.avatarData forKey:@"avatarData"];
}

#pragma mark - Description
- (NSString *)description
{
	return ([NSString stringWithFormat:@"<%@: %p, userName: %@, displayName: %@%@%@>", NSStringFromClass(self.class), self, _userName, _displayName, ((_emailAddress!=nil) ? [NSString stringWithFormat:@", emailAddress: [%@]",_emailAddress] : @""), ((self.avatarData!=nil) ? @", avatarData" : @"")]);
}

@end
