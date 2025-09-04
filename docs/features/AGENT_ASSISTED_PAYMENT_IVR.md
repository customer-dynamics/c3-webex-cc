# Agent-Assisted Payment IVR

## Overview

C3 for Webex CC allows agents to collect payments over the phone securely using a secure **interactive voice response (IVR)** system. This feature is designed to help you achieve and maintain PCI DSS compliance while taking payments. When an agent determines that a customer needs to make a payment, they can transfer the call to the IVR system to collect the payment details securely. This keeps the agent from ever seeing or hearing the payment details. When the payment is complete, the customer is transferred back to the agent.

## Setup

### Define Global Variables

C3 for Webex CC requires a small number of global variables to be defined to pass data between the widget, contact, and the flow.

To add these in Webex Control Hub, navigate to the [_Global Variables_ subsection of _Flows_ in the Webex Contact Center settings](https://admin.webex.com/wxcc/customer-experience/routing-flows/global-variables).

The following global variables will need to be defined in your environment:

| Value                  | Type    | Sensitive | Description                                                                                                                    |
| ---------------------- | ------- | --------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `C3Env`                | String  | No        | The C3 environment to use in the flow (`dev`, `staging`, or `prod`). Unless otherwise specified for your tenant, use **prod**. |
| `C3PaymentRequestInfo` | String  | No        | The information for the C3 payment request, represented as JSON.                                                               |
| `C3CciAgentId`         | String  | No        | The ID of the Webex agent to transfer back to.                                                                                 |
| `C3ContactEmail`       | String  | No        | The email address of the contact to use for a receipt.                                                                         |
| `C3ContactFirstName`   | String  | No        | The first name of the contact.                                                                                                 |
| `C3ContactLastName`    | String  | No        | The last name of the contact.                                                                                                  |
| `C3PaymentAmount`      | Decimal | No        | The amount to charge for the payment.                                                                                          |
| `C3PaymentRequestId`   | String  | No        | The ID of the payment request in C3.                                                                                           |

### Import Flow

To import the agent assist IVR flow into your Webex Contact Center environment, follow these steps:

1. Download the [`C3AgentAssistedPaymentIVR` flow](../../flows/C3AgentAssistedPaymentIVR.json) from the flows directory in this repository
2. Navigate to the [_Flows_ subsection of _Flows_ in the Webex Contact Center settings](https://admin.webex.com/wxcc/customer-experience/routing-flows/flows) of Control Hub
3. Under the _Manage Flows_ button, select _Import Flows_
4. Select the downloaded `C3AgentAssistedPaymentIVR.json` file and click _Import_

### Set Values in the IVR Flow

After importing the flow, you'll need to set some values within your flow. Follow these steps to set the values:

While on the list of flows in Control Hub, find the `C3AgentAssistedPaymentIVR` flow and click on the arrow button at the end to view the flow in Flow Designer. At the top of Flow Designer, click the _Edit_ toggle to enable editing.

!["An image of Webex Flow Designer, highlighting the edit toggle"](../images/flow-designer-editing.png 'Flow Designer editing toggle')

Open the _properties_ panel on the right side of the screen, if not already open.

!["An image of Webex Flow Designer, highlighting the button to open the properties panel"](../images/flow-designer-properties-panel.png 'Flow Designer properties panel button')

With the properties panel open, scroll down to the _Flow Variables_ section. Set the following variables by clicking on the variable and setting the _Default Value_:

| Variable Name   | Default Value                           |
| --------------- | --------------------------------------- |
| `C3ApiKey`      | The API key assigned to your C3 vendor. |
| `ZiftAccountId` | The account ID for the                  |
| `ZiftUserName`  | The Zift username for your C3 vendor.   |
| `ZiftPassword`  | The Zift password for your C3 vendor.   |

!["An image of Webex Flow Designer, highlighting four variables in the properties panel"](../images/flow-designer-flow-variables.png 'Flow Designer flow variables')

Publish the flow by enabling the _Validation_ switch and then clicking the _Publish Flow_ button once validation is successful.

!["An image of Webex Flow Designer, highlighting the validation switch and publish button"](../images/flow-designer-publish.png 'Flow Designer publish')

### Define Variables on Routing Flows

To use C3 during an _outbound_ call, you will need to update the routing flow associated with your Inbound Telephony Channel (otherwise known as an outdial entry point). Likewise, for using C3 with _inbound_ calls, you will need to update the routing flow associated with your Inbound Telephony Channel (otherwise known as an inbound entry point).

For your specific use case, update the flow(s) above to add the following previously defined global variables:

- `C3CciAgentId`
- `C3ContactEmail`
- `C3ContactFirstName`
- `C3ContactLastName`
- `C3PaymentAmount`
- `C3PaymentRequestId`

Validate and publish the flow(s).

### Add a Channel for the IVR

Next, we'll need to add a channel (also known as an entry point) to use for the IVR. This channel will be used to transfer the call to the IVR system.

Follow these steps to add the channel:

1. Navigate to the [_Channels_ section in the Webex Contact Center settings](https://admin.webex.com/wxcc/customer-experience/channels) of Control Hub
2. Click the _Create Channel_ button
3. Provide the details below for the channel
4. Click _Create_
5. Click on the newly created channel and record the ID for use in the widget

#### Channel Details

##### Entry Point

| Field        | Value                                                        |
| ------------ | ------------------------------------------------------------ |
| Name         | Something identifiable, like `C3_Agent_Assisted_Payment_IVR` |
| Channel Type | Inbound Telephony                                            |

##### Entry Point Settings

| Field                   | Value                                                                      |
| ----------------------- | -------------------------------------------------------------------------- |
| Service Level Threshold | Any number of seconds                                                      |
| Timezone                | Any applicable timezone                                                    |
| Routing Flow            | The `C3AgentAssistedPaymentIVR` flow you imported earlier                  |
| Version Label           | Latest                                                                     |
| Music on Hold           | Any hold music—the contact should not hear this under normal circumstances |

### Create Wrap-Up Code and Idle Code for Transfer

> [!NOTE]
> If you already have a wrap-up code and idle code you would like to use, you may skip this step.

When the contact is transferred away, the call will automatically be wrapped up on behalf of the agent and the agent will be placed in an idle state. The agent will stay in this state until the contact is transferred back to them, or the contact hangs up. This is done in order to prevent the agent from receiving any new calls while they wait for the contact. The C3 for Webex CC widget requires you to define a wrap-up code and idle code to use for this purpose.

Follow these steps to create the wrap-up code and idle code:

1. Navigate to the [_Idle/Wrap-up Codes_ section in the Webex Contact Center settings](https://admin.webex.com/wxcc/desktop-experience/status-codes) of Control Hub
2. Click the _Create Idle/Wrap-up Code_ button
3. Create the idle code/wrap-up code with the details below
4. Click on the newly created idle/wrap-up code and record the ID for use in the widget

#### Idle Code

| Field           | Value                                                                           |
| --------------- | ------------------------------------------------------------------------------- |
| Name            | Something identifiable to the agent, like "Waiting On Contact"                  |
| Description     | A description, like "Waiting on the contact to complete the process in an IVR." |
| Make it default | No                                                                              |
| Code type       | Default Idle Work Type                                                          |

#### Wrap-Up Code

| Field           | Value                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------- |
| Name            | Something identifiable, like "Transferred to IVR"                                                       |
| Description     | A description, like "The agent has transferred the contact to an IVR and will wait for them to return." |
| Make it default | No                                                                                                      |
| Code type       | Default Wrapup Work Type                                                                                |

### Check Desktop Profile

To ensure these idle and wrap-up codes are available to the agent, you'll need to double check that they are available as part of the agent's desktop profile. You can check this by navigating to the [_Desktop Profiles_ section in the Webex Contact Center settings](https://admin.webex.com/wxcc/desktop-experience/desktop-profiles) of Control Hub:

1. Select the profile you want to use, or the one you have assigned to your agents already
2. Select the _Idle/Wrap-up Codes_ tab
3. Check that the _Wrap-up Codes_ and _Idle Codes_ options are either set to _All_, or that the idle/wrap-up codes you created are selected
4. [Check your agents](https://admin.webex.com/wxcc/user-mgmt/users) to make sure that this desktop profile is assigned to them
