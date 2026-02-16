//
// Copyright 2025 Element Creations Ltd.
// Copyright 2023-2025 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import SwiftUI

/// The app's logo styled to fit on various launch pages.
struct AuthenticationStartLogo: View {
    /// Set to `true` when using on top of `Asset.Images.launchBackground`
    let hideBrandChrome: Bool

    var body: some View {
        Image(asset: Asset.Images.appLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 160, height: 160)
            .foregroundColor(.white)
            .accessibilityHidden(true)
    }
}
