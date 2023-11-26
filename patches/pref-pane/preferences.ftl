## Cachy preferences

# Sidebar
pane-cachy-browser-title = Cachy
category-cachy-browser =
    .tooltiptext = about:config changes, logically grouped and easily accessible

# Main content
cachy-browser-header = Cachy Preferences
cachy-browser-warning-title = Heads up!
cachy-browser-warning-description = We carefully choose default settings to focus on privacy and security. When changing these settings, read the descriptions to understand the implications of those changes.

# Page Layout
cachy-browser-general-heading = Browser Behavior
cachy-browser-extension-update-checkbox =
    .label = Update add-ons automatically
cachy-browser-sync-checkbox =
    .label = Enable Firefox Sync
cachy-browser-autocopy-checkbox =
    .label = Enable middle click paste
cachy-browser-styling-checkbox = 
    .label = Allow userChrome.css customization

cachy-browser-network-heading = Networking
cachy-browser-ipv6-checkbox =
    .label = Enable IPv6

cachy-browser-privacy-heading = Privacy
cachy-browser-xorigin-ref-checkbox =
    .label = Limit cross-origin referrers

cachy-browser-broken-heading = Fingerprinting
cachy-browser-webgl-checkbox =
    .label = Enable WebGL
cachy-browser-rfp-checkbox =
    .label = Enable ResistFingerprinting
cachy-browser-auto-decline-canvas-checkbox =
    .label = Silently block canvas access requests
cachy-browser-letterboxing-checkbox =
    .label = Enable letterboxing

cachy-browser-security-heading = Security
cachy-browser-ocsp-checkbox =
    .label = Enforce OCSP hard-fail
cachy-browser-goog-safe-checkbox =
    .label = Enable Google Safe Browsing
cachy-browser-goog-safe-download-checkbox =
    .label = Scan downloads

# In-depth descriptions
cachy-browser-extension-update-description = Keep extensions up to date without manual intervention. A good choice for your security.
cachy-browser-extension-update-warning1 = If you don't review the code of your extensions before every update, you should enable this option.

cachy-browser-ipv6-description = Allow { -brand-short-name } to connect using IPv6.
cachy-browser-ipv6-warning1 = Instead of blocking IPv6 in the browser, we suggest enabling the IPv6 privacy extension in your OS.
cachy-browser-ocsp-description = Prevent connecting to a website if the OCSP check cannot be performed.
cachy-browser-ocsp-warning1 = This increases security, but it will cause breakage when an OCSP server is down.
cachy-browser-sync-description = Sync your data with other browsers. Requires restart.
cachy-browser-sync-warning1 = Firefox Sync encrypts data locally before transmitting it to the server.

cachy-browser-autocopy-description = Select some text to copy it, then paste it with a middle-mouse click.

cachy-browser-styling-description = Enable this if you want to customize the UI with a manually loaded theme.
cachy-browser-styling-warning1 = Make sure you trust the provider of the theme.

cachy-browser-xorigin-ref-description = Send a referrer only on same-origin.
cachy-browser-xorigin-ref-warning1 = This causes breakage. Additionally, even when sent referrers will still be trimmed.

cachy-browser-webgl-description = WebGL is a strong fingerprinting vector.
cachy-browser-webgl-warning1 = If you need to enable it, consider using an extension like Canvas Blocker.

cachy-browser-rfp-description = ResistFingerprinting is the best in class anti-fingerprinting tool.
cachy-browser-rfp-warning1 = If you need to disable it, consider using an extension like Canvas Blocker.

cachy-browser-auto-decline-canvas-description = Automatically deny canvas access to websites, without prompting the user.
cachy-browser-auto-decline-canvas-warning1 = It is still possible to allow canvas access from the urlbar.

cachy-browser-letterboxing-description = Letterboxing applies margins around your windows, in order to return a limited set of rounded resolutions.

cachy-browser-goog-safe-description = If you are worried about malware and phishing, consider enabling it.
cachy-browser-goog-safe-warning1 = Disabled over censorship concerns but recommended for less advanced users. All the checks happen locally.

cachy-browser-goog-safe-download-description = Allow Safe Browsing to scan your downloads to identify suspicious files.
cachy-browser-goog-safe-download-warning1 = All the checks happen locally.

# Footer
cachy-browser-footer = Useful links
cachy-browser-config-link = All advanced settings (about:config)
cachy-browser-open-profile = Open user profile directory
