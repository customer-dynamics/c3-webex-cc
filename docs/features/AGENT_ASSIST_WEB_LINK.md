# Agent Assist Web Link

## Overview

C3 for Webex CC allows agents to collect payments securely over the phone by sending a secure web link to the customer. This feature is designed to help you achieve and maintain PCI DSS compliance while taking payments. When an agent determines that a customer needs to make a payment, they can send the customer a secure web link to collect the payment details. This keeps the agent from ever seeing or hearing the payment details, while allowing the agent to continue talking to the customer.

The following delivery methods are currently supported for sending the link:

- **SMS**: Send the link to the customer via SMS
- **Email**: Send the link to the customer via email
- **WhatsApp**: Send the link to the customer via WhatsApp

## Setup

### Prerequisites

Before getting started in this section, please ensure the following:

- You have a Webex Connect instance configured

### Configure Service

> [!NOTE]
> If you already have a service set up in Webex Connect that you would like to use, you may skip this section. Just be sure to record the **service key** for your service.

C3 for Webex CC utilizes the Webex Connect API to send the secure web link to the customer. This requires a service to be configured in Webex Connect. To set up this service, follow these steps:

1. Navigate to the _Services_ section in Webex Connect
2. Create the service by following the [Webex Connect documentation](https://help.webexconnect.io/docs/create-a-service-on-imiconnect)
3. Record the **service key** for use in the widget
   1. Click on your newly created service
   2. Click on the _API_ tab
   3. Change the _Auth Type_ toggle to _Service Key_
   4. Copy the service key

### Create Apps/Assets for Digital Channels

> [!NOTE]
> If you already have your apps for your digital channels configured, you may skip this step.

For each digital channel you would like to use to send the secure web link, you will need to create an app in Webex Connect. Reference the appropriate documentation for each channel:

- [SMS](./web-link-methods/SMS.md)
- [Email](./web-link-methods/EMAIL.md)
- [WhatsApp](./web-link-methods/WHATSAPP.md)
