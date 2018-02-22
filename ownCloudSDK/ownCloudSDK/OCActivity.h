//
//  OCActivity.h
//  ownCloudSDK
//
//  Created by Felix Schwarz on 05.02.18.
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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OCActivityType)
{
	OCActivityTypeNone,

	// File activities
	OCActivityTypeCreateFolder,
	OCActivityTypeCopy,
	OCActivityTypeMove,
	OCActivityTypeRename,
	OCActivityTypeDelete,
	OCActivityTypeDownload,
	OCActivityTypeUpload,

	// Metadata activities
	OCActivityTypeRetrieveThumbnail,
	OCActivityTypeRetrieveItemList
};

@interface OCActivity : NSObject

@property(readonly) OCActivityType activityType; //!< Identifies the type of activity
@property(readonly) NSProgress *progress; //!< An NSProgress object if progress tracking is available, nil if it is not available.

@property(readonly) BOOL cancelled; //!< YES, if the activity has been cancelled.

- (void)cancel; //!< Cancel the activity

@end
