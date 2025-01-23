# Email

## Overview

C3 for Webex CC allows agents to send a secure web link to customers via email to collect payments securely over the phone. This leverages your existing email details in Webex Connect to send the link to the customer.

## Setup

### Prerequisites

Before getting started in this section, please ensure the following:

- An email SMTP server is configured
- An email address is provisioned within your email SMTP server

### Create App

An app is required to send emails through Webex Connect. To create an app, follow the steps in the [Webex Connect documentation](https://help.webexconnect.io/docs/email-cce).

> [!IMPORTANT]
> Register this app with the Webex Connect service that you created earlier.

### Create Template

Templates allow you to define the content of your email messages that are sent for payments.

Create a template by following the following steps:

1. Navigate to the _Templates_ section in Webex Connect, under the _Tools_ menu
2. Click the _Add New Template_ button
3. Give your template a recognizable name, such as "c3_payment_link_email"
4. Select the Email channel
5. Enter a unique reference ID for the template, such as "c3_payment_link_email"
6. For Template Type, select _Full template_
7. Enter your text to be used as the subject line of the email
8. Click the _Save_ button
9. Configure your message template as desired, referencing the [Webex Connect documentation for Email Composer](https://help.webexconnect.io/docs/email-composer)
10. Save your template

> [!IMPORTANT]
> Include a `https://$(paymentRequestUrl)` inside of a link on your page. This variable will be replaced with the secure web link to collect the payment details.
