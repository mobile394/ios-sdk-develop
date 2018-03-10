//
//  OCUser.h
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

#import <UIKit/UIKit.h>

@interface OCUser : NSObject <NSSecureCoding>
{
	UIImage *_avatar;
}

@property(strong) NSString *displayName; //!< Display name of the user (f.ex. "John Appleseed")

@property(strong) NSString *userName; //!< User name of the user (f.ex. "jappleseed")

@property(strong) NSString *emailAddress; //!< Email address of the user (f.ex. "jappleseed@owncloud.org")

@property(strong) NSData *avatarData; //!< Image data for the avatar of the user (or nil if none is available)

@property(readonly,nonatomic) UIImage *avatar; //!< Avatar for the user (or nil if none is available) - auto-generated from avatarData, not archived

@end
