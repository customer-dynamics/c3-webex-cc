# Getting Started

## Prerequisites

Before getting started with C3 for Webex CC, please ensure the following:

- You have a current C3 vendor account
- You have admin access and are able to configure items in Webex Contact Center

## Setup

### Configure Payment Request Methods

C3 for Webex CC supports several methods for securely collecting payments. Each method requires a different configuration, so follow the instructions below for the method(s) you plan to use before proceeding to the next section.

#### Agent-Assisted Payment IVR

Choose this option if you want to enable your agents to collect payments over the phone. Customers will be transferred to an IVR system to enter their payment details using their phone's keypad. They will be transferred back to the agent when the payment is complete.

[Configure agent-assisted payment IVR](./features/AGENT_ASSISTED_PAYMENT_IVR.md)

#### Agent-Assisted Web Link

Choose this option if you want to enable your agents to send customers a secure web link to make a payment. Customers will click the link and enter their payment details on a secure payment page using their web browser.

[Configure agent-assisted web links](./features/AGENT_ASSIST_WEB_LINK.md)

#### Self-Service Payment IVR

Choose this option if you want to enable customers to make payments on their own, without agent assistance. Customers will dial a phone number and enter their payment details using their phone's keypad.

> [!NOTE]
> Details for this method are coming soon.

### Add Widget to Desktop Layout

> [!NOTE]
> Ensure that you have configured each of the above methods that you plan to use before proceeding.

The C3 Payment Request widget is a full page widget that agents use in the Webex CC Desktop interface. This widget will need to be added to the desktop layout that your agents use. To find the desktop layouts currently in use, or to create a new one, navigate to the [_Desktop Layouts_ section in the Webex Contact Center settings](https://admin.webex.com/wxcc/desktop-experience/desktop-layouts) in Control Hub.

To add the widget, add the following to your desktop layout JSON file, in the `agent > area > navigation > page > widgets` section:

```json
"c3-payment-request": {
  "comp": "c3-payment-request",
  "script": "",
  "attributes": {
    "dark": "$STORE.app.darkMode"
  },
  "properties": {
    "agent": "$STORE.agent",
    "config": {
      "contactCenter": "webex",
      "noLink": false,
      "noIvr": false
    },
    "c3": {
      "vendorId": "",
      "apiKey": "",
      "logoUrl": "",
      "supportPhone": "",
      "supportEmail": "",
      "paymentRequestWebLinkConfig": {
        "ttl": 3600,
        "header1": "",
        "header2": "",
        "primaryColor": "",
        "secondaryColor": ""
      }
    },
    "webex": {
      "transferredWrapUpCodeId": "",
      "waitingIdleCodeId": "",
      "paymentEntryPointId": "",
      "connect": {
        "region": "",
        "serviceKey": "",
        "channels": {
          "sms": {
            "templateId": ""
          },
          "email": {
            "templateId": "",
            "fromAddress": "",
            "fromName": ""
          },
          "whatsApp": {
            "templateId": "",
            "appId": ""
          }
        }
      }
    }
  }
}
```

### Define Widget Properties

Provide the appropriate values in the JSON above, using the following descriptions to guide you.

#### Script

The `script` to use for the widget depends on the environment used. For this value, use the URL that corresponds to your environment:

| Environment | Script URL                                                        |
| ----------- | ----------------------------------------------------------------- |
| Development | `https://{{Your C3 Vendor ID}}.dev.c2a.link/widget/widget.js`     |
| Staging     | `https://{{Your C3 Vendor ID}}.staging.c2a.link/widget/widget.js` |
| Production  | `https://{{Your C3 Vendor ID}}.call2action.link/widget/widget.js` |

> [!NOTE]
> Unless otherwise specified for your vendor, use the production script.

#### General Configuration

| Value           | Description                                      |
| --------------- | ------------------------------------------------ |
| `contactCenter` | Keep this value as `webex`.                      |
| `noLink`        | Whether to disable web links for your agents.    |
| `noIvr`         | Whether to disable IVR payments for your agents. |

#### C3 Properties

| Value                         | Description                                                                                                                |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `vendorId`                    | The ID of your C3 vendor.                                                                                                  |
| `apiKey`                      | The API key for your C3 vendor.                                                                                            |
| `logoUrl`                     | The URL of the logo to display on receipts. For web link payments, this will also be displayed on the payment page.        |
| `supportPhone`                | The phone number for customer support to be displayed on receipts.                                                         |
| `supportEmail`                | The email address for customer support to be displayed on receipts.                                                        |
| `paymentRequestWebLinkConfig` | Configuration for the payment request web link. **Optional**: This config is only required if you plan on using web links. |

##### Payment Request Web Link Configuration

**Optional**: This config is only required if you plan on using web links.

| Value            | Description                                                                            |
| ---------------- | -------------------------------------------------------------------------------------- |
| `ttl`            | The number of seconds until the payment link expires.                                  |
| `header1`        | The header text to display on the payment page.                                        |
| `header2`        | The subheader text to display on the payment page.                                     |
| `primaryColor`   | The primary color to use on the payment page. Should be a hex value, like `#0777BD`.   |
| `secondaryColor` | The secondary color to use on the payment page. Should be a hex value, like `#0777BD`. |

#### Webex Properties

| Value                     | Description                                                                                                                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `transferredWrapUpCodeId` | The ID of the wrap up code to use when a call has been transferred to an IVR. **Optional** Only required if you plan on using IVR payments.                                          |
| `waitingIdleCodeId`       | The ID of the idle code to place the agent in when waiting for a customer to return after being transferred to an IVR. **Optional** Only required if you plan on using IVR payments. |
| `paymentEntryPointId`     | The ID of the entry point to transfer the call to collect payment through IVR. **Optional** Only required if you plan on using IVR payments.                                         |
| `connect`                 | Configuration for using Webex Connect digital channels. **Optional** Only required if you plan on using web links.                                                                   |

##### Webex Connect Configuration

**Optional**: This config is only required if you plan on using web links.

| Value        | Description                                                                                                                                          |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `region`     | The region to use for Webex Connect. This can be seen in the URL of your Connect portal. For example, `tenantname.us.webexconnect.io` would be `us`. |
| `serviceKey` | The service key used for authenticating with your Webex Connect instance.                                                                            |
| `channels`   | Configuration for each digital channel.                                                                                                              |

##### Digital Channels Configuration

**Optional**: This config is only required if you plan on using web links.

At least one of the following channels must be configured:

| Value      | Description                          |
| ---------- | ------------------------------------ |
| `sms`      | Configuration for SMS messages.      |
| `email`    | Configuration for email messages.    |
| `whatsApp` | Configuration for WhatsApp messages. |

###### SMS Configuration

| Value        | Description                                                                   |
| ------------ | ----------------------------------------------------------------------------- |
| `templateId` | The ID of the SMS template in Webex Connect to use for sending payment links. |

###### Email Configuration

| Value         | Description                                                                     |
| ------------- | ------------------------------------------------------------------------------- |
| `templateId`  | The ID of the email template in Webex Connect to use for sending payment links. |
| `fromAddress` | The email address to use as the sender of the email.                            |
| `fromName`    | The name to use as the sender of the email.                                     |

###### WhatsApp Configuration

| Value        | Description                                                                        |
| ------------ | ---------------------------------------------------------------------------------- |
| `templateId` | The ID of the WhatsApp template in Webex Connect to use for sending payment links. |
| `appId`      | The ID of the WhatsApp app in Webex Connect to use for sending messages.           |

### Upload Updated Desktop Layout

Back in the the [_Desktop Layouts_ section in the Webex Contact Center settings](https://admin.webex.com/wxcc/desktop-experience/desktop-layouts) in Control Hub:

1. Ensure that you have your desired teams selected in the _Teams_ section. This widget will only be available to agents in the selected teams.
2. Click the _Replace file_ button and select your updated desktop layout JSON file
3. Click _Save_
