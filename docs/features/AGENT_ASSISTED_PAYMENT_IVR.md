# Agent-Assisted Payment IVR

## Overview

C3 for Webex CC allows agents to collect payments over the phone securely using a secure **interactive voice response (IVR)** system. This feature is designed to help you achieve and maintain PCI DSS compliance while taking payments. When an agent determines that a customer needs to make a payment, they can transfer the call to the IVR system to collect the payment details securely. This keeps the agent from ever seeing or hearing the payment details. When the payment is complete, the customer is transferred back to the agent.

## Installation

### Define Global Variables

C3 for Webex CC requires a small number of global variables to be defined to pass data between the widget, contact, and the flow.

To add these in Webex Control Hub, navigate to the [_Global Variables_ subsection of _Flows_ in the Webex Contact Center settings](https://admin.webex.com/wxcc/customer-experience/routing-flows/global-variables).

The following global variables will need to be defined in your environment:

| Value             | Type    | Description                                                                                           |
| ----------------- | ------- | ----------------------------------------------------------------------------------------------------- |
| `C3AgentId`       | String  | The agent identifier entered by the agent in the C3 desktop widget.                                   |
| `C3ContactEmail`  | String  | The email address for the contact, as entered by the agent in the C3 desktop widget.                  |
| `C3PaymentAmount` | Decimal | The amount the customer has elected to pay, either entered by the agent (IVR) or customer (web link). |
| `C3SubjectId`     | String  | The subject identifier entered by the agent in the C3 desktop widget.                                 |
| `C3WebexAgentId`  | String  | The unique identifier for the Webex CC agent.                                                         |

For the default value of `C3PaymentAmount`, use the value `0.0`. Whether to make these variables reportable or viewable can be left to your discretion.

### Import Flow

To import the agent assist IVR flow into your Webex Contact Center environment, follow these steps:

1. Download the [`C3AgentAssistedPaymentIVR` flow](../../flows/C3AgentAssistedPaymentIVR.json) from the flows directory in this repository
2. Navigate to the [_Flows_ subsection of _Flows_ in the Webex Contact Center settings](https://admin.webex.com/wxcc/customer-experience/routing-flows/flows) of Control Hub
3. Under the _Manage Flows_ button, select _Import Flows_
4. Select the downloaded `C3AgentAssistedPaymentIVR.json` file and click _Import_

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

| Field                   | Value                                                                       |
| ----------------------- | --------------------------------------------------------------------------- |
| Service Level Threshold | Any number of seconds                                                       |
| Timezone                | Any applicable timezone                                                     |
| Routing Flow            | The `C3AgentAssistedPaymentIVR` flow you imported earlier                   |
| Version Label           | Latest                                                                      |
| Music on Hold           | Any hold music—the customer should not hear this under normal circumstances |

### Create Wrap-Up Code and Idle Code for Transfer

> [!NOTE]
> If you already have a wrap-up code and idle code you would like to use, you may skip this step.

When the customer is transferred away, the call will automatically be wrapped up on behalf of the agent and the agent will be placed in an idle state. The agent will stay in this state until the customer is transferred back to them, or the customer hangs up. This is done in order to prevent the agent from receiving any new calls while they wait for the customer. The C3 for Webex CC widget requires you to define a wrap-up code and idle code to use for this purpose.

Follow these steps to create the wrap-up code and idle code:

1. Navigate to the [_Idle/Wrap-up Codes_ section in the Webex Contact Center settings](https://admin.webex.com/wxcc/desktop-experience/status-codes) of Control Hub
2. Click the _Create Idle/Wrap-up Code_ button
3. Create the idle code/wrap-up code with the details below
4. Click on the newly created idle/wrap-up code and record the ID for use in the widget

#### Idle Code

| Field           | Value                                                                            |
| --------------- | -------------------------------------------------------------------------------- |
| Name            | Something identifiable to the agent, like "Waiting On Customer"                  |
| Description     | A description, like "Waiting on the customer to complete the process in an IVR." |
| Make it default | No                                                                               |
| Code type       | Default Idle Work Type                                                           |

#### Wrap-Up Code

| Field           | Value                                                                                                    |
| --------------- | -------------------------------------------------------------------------------------------------------- |
| Name            | Something identifiable, like "Transferred to IVR"                                                        |
| Description     | A description, like "The agent has transferred the customer to an IVR and will wait for them to return." |
| Make it default | No                                                                                                       |
| Code type       | Default Wrapup Work Type                                                                                 |
