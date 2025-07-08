# UIExtension Example

iOS 26 enables ExtensionKit for third party apps. This repo provides an example utilizing the ExtensionKit to host custom UIs from the bundled extension.

This can be useful if the app need to offload code into a separate process, like running untrusted code, or prefers stronger runtime isolation.

## BaseExample

This contains the basic setup for a UI Extension and have the host app consume the vended view from the extension. This can be the typical setup for apps that want to offload certain implementation to an extension it bundles.

~~## PluginExample~~

~~This contains two separate apps, `AppA` and `AppB`. In this example, `AppA` defines the `AppExtensionPoint` and expects other apps to provide extensions it can consume. `AppB` contains an example implementation of the extension for `AppA`.~~

~~As of iOS 26 beta 1, the `AppA` will need to use `EXAppExtensionBrowserViewController` to enable extensions provided by other apps.~~

iOS 26 beta 3 no longer allow third-party apps to observe unscoped extension points without a private entitlement.

~~## SDKExample~~

~~This contains two separate apps, `AppA` and `AppB`. In this example, `AppA` defines the `AppExtensionPoint` and provides an extension for other apps to consume. This setup can typically be used for apps that want to offer SDK to other developers. `AppB` contains an example of consuming the extension provided by App A.~~

~~As of iOS 26 beta 1, the extension will be enabled automatically if it's defined and bundled by the same app.~~

iOS 26 beta 3 no longer allow third-party apps to observe unscoped extension points without a private entitlement.
