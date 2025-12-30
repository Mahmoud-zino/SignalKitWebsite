# Installation

Get SignalKit up and running in your Unity project in just a few minutes.

## Requirements

Before installing SignalKit, make sure your project meets the following requirements:

- **Unity Version**: 2021.3 LTS or later
- **Scripting Runtime**: .NET Standard 2.1 or .NET Framework 4.x
- **API Compatibility Level**: .NET Standard 2.1 (recommended)

## Installation Methods

> [!TIP]
> We recommend installing via the Unity Asset Store for automatic updates and easy package management.

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
using SignalKit.Runtime.Core.Channels;
using SignalKit.Runtime.Core.Listeners;
```

If there are no compilation errors, SignalKit is ready to use!

> [!NOTE]
> SignalKit uses organized namespaces like `SignalKit.Runtime.Core.Channels` and `SignalKit.Runtime.Core.Listeners` to keep code well-structured. See the [Quick Start](/docs/quick-start) guide for complete examples.

## Next Steps

Now that you have SignalKit installed, you're ready to start building decoupled systems:

- **[Basic Concepts](/docs/basics)** - Understand the three building blocks of SignalKit
- **[Quick Start](/docs/quick-start)** - Create your first signal in 5 minutes
- **[Core Concepts](/docs/core-concepts)** - Deep dive into architecture and advanced patterns
- **[Channels](/docs/channels)** - Learn about all signal channel types
- **[Listeners](/docs/listeners)** - Master the different ways to listen to signals

## Getting Help

Need help with installation? Here's how to get support:

- 📚 **[Documentation](/docs)** - Browse the full documentation
- 🔧 **[Troubleshooting](/docs/troubleshooting)** - Common issues and solutions
- 🐛 **[Report an Issue](https://github.com/Mahmoud-zino/SignalKitWebsite/issues/new?labels=bug)** - Found a bug or installation problem
- 💡 **[Request a Feature](https://github.com/Mahmoud-zino/SignalKitWebsite/issues/new?labels=enhancement)** - Suggest new features or improvements
- 🛒 **Unity Asset Store** - Leave a question in the Asset Store Q&A section
- ✉️ **Support Email** - Contact support for technical assistance
