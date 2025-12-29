# Installation

Get SignalKit up and running in your Unity project in just a few minutes.

## Requirements

Before installing SignalKit, make sure your project meets the following requirements:

- **Unity Version**: 2021.3 LTS or later
- **Scripting Runtime**: .NET Standard 2.1 or .NET Framework 4.x
- **API Compatibility Level**: .NET Standard 2.1 (recommended)

## Installation Methods

### Unity Asset Store (Recommended)

The primary way to get SignalKit is through the Unity Asset Store.

1. Open the **Unity Asset Store** in your web browser or within Unity
2. Search for **"SignalKit"**
3. Click **Add to My Assets** (or **Purchase** if you haven't already)
4. Open the **Package Manager** in Unity (`Window > Package Manager`)
5. Select **My Assets** from the dropdown
6. Find **SignalKit** in the list and click **Download**
7. Once downloaded, click **Import**
8. Select all files and click **Import** to complete the installation

SignalKit is now installed and ready to use!

### Manual Installation

1. Locate the SignalKit package file (`.unitypackage`)
2. In Unity, navigate to `Assets > Import Package > Custom Package...`
3. Browse to and select the SignalKit `.unitypackage` file
4. Click **Open**
5. In the import dialog, ensure all files are selected
6. Click **Import**
7. Wait for Unity to import and compile the scripts

SignalKit is now installed in your project.

## Verify Installation

To verify that SignalKit was installed correctly:

1. In Unity, navigate to `Window > SignalKit > Debugger`
2. If the SignalKit Debugger window opens, installation was successful
3. You can also check for the **SignalKit** namespace in your scripts:

```csharp
using SignalKit;
```

If there are no compilation errors, SignalKit is ready to use!

## Next Steps

Now that you have SignalKit installed, you're ready to start building decoupled systems:

- **[Quick Start](/docs/quick-start)** - Create your first signal in 5 minutes
- **[Core Concepts](/docs/core-concepts)** - Understand how SignalKit works
- **[Channels](/docs/channels)** - Learn about signal channels
- **[Listeners](/docs/listeners)** - Discover how to listen to signals

## Troubleshooting

### Import Errors

If you encounter import errors after installation:

1. Navigate to `Assets > Reimport All`
2. Restart Unity
3. Check the Console for any compilation errors
4. Ensure your Unity version meets the minimum requirements

### Missing Menu Items

If you don't see SignalKit menu items under `Window > SignalKit`:

1. Ensure the package was imported completely
2. Check that all `.asmdef` files are present
3. Reimport the SignalKit folder from Package Manager

### Asset Store Download Issues

If you're having trouble downloading from the Asset Store:

1. Ensure you're logged into your Unity account
2. Check your internet connection
3. Try restarting Unity
4. Clear the Asset Store cache (`Edit > Preferences > Asset Store` and clear cache)

## Getting Help

Need help with installation? Here's how to get support:

- **[Documentation](/docs)** - Browse the full documentation
- **[Report an Issue](https://github.com/Mahmoud-zino/SignalKitWebsite/issues/new?labels=bug)** - Found a bug or installation problem
- **[Request a Feature](https://github.com/Mahmoud-zino/SignalKitWebsite/issues/new?labels=enhancement)** - Suggest new features or improvements
- **Unity Asset Store** - Leave a question in the Asset Store Q&A section
- **Support Email** - Contact support for technical assistance

If you encounter any issues during installation, please check the troubleshooting section above first.
