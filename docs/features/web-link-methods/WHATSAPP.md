# WhatsApp

## Overview

C3 for Webex CC allows agents to send a secure web link to customers via WhatsApp to collect payments securely over the phone. This leverages your existing WhatsApp details in Webex Connect to send the link to the customer.

## Setup

### Prerequisites

Before getting started in this section, please ensure the following:

- You have an existing WhatsApp Business account

### Create App

An app is required to send WhatsApp messages through Webex Connect. To create an app, follow the steps in the [Webex Connect documentation](https://help.webexconnect.io/docs/whatsapp-cce#configure-whatsapp-app-asset-on-webex-connect).

> [!IMPORTANT]
> Register this app with the Webex Connect service that you created earlier.

### Create Template

Templates allow you to define the content of your WhatsApp messages that are sent for payments. Your WhatsApp template will also need to be approved by WhatsApp so that you can send outbound messages to your customers.

Create a template by following the following steps:

1. Navigate to the _Templates_ section in Webex Connect, under the _Tools_ menu
2. Click the _Add New Template_ button
3. Give your template a recognizable name, such as "c3_payment_link_whatsapp"
4. Select the WhatsApp channel
5. Select _UTILITY_ as the category
6. If more than one WhatsApp app is configured, select the correct app ID
7. Select a language for the content of this template
8. Configure your message template as desired, referencing the [Webex Connect documentation](https://portal-v2.wxcc-us1.cisco.com/ccone-help-new/t_create-a-site.html#!webexcc_t_add-template-whatsapp.html)
9. Configure sample content for the template
   1. Use `jx9yga288k3r` as the content for $(paymentRequestId)
10. Save your template
11. **Wait for approval** from WhatsApp before use

> [!IMPORTANT]
> Include the text `https://{{Your Vendor ID}}.call2action.link/$(paymentRequestId)` inside of a link in your template. Be sure the `{{Your Vendor ID}}` part is **replaced with your own vendor ID**. The `$(paymentRequestId)` variable will be replaced dynamically when you generate a link.
>
> We recommend adding this as a dynamic _call-to-action button_ in your message, but it can also be included as a link in the message body.
