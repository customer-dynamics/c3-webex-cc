#!/bin/bash

# Removes all referenced flow variables. This should be run before committing updated flow files to the repository.

AGENT_ASSISTED_PAYMENT_IVR_FLOW_FILE="flows/C3AgentAssistedPaymentIVR.json"

# Replace the Zift information.
sed -i '' '/"name": "ZiftAccountId"/,/"value": /s/"value": "[^"]*"/"value": ""/' "$AGENT_ASSISTED_PAYMENT_IVR_FLOW_FILE"
sed -i '' '/"name": "ZiftUsername"/,/"value": /s/"value": "[^"]*"/"value": ""/' "$AGENT_ASSISTED_PAYMENT_IVR_FLOW_FILE"
sed -i '' '/"name": "ZiftPassword"/,/"value": /s/"value": "[^"]*"/"value": ""/' "$AGENT_ASSISTED_PAYMENT_IVR_FLOW_FILE"

# Replace the C3 API Key.
sed -i '' '/"name": "C3ApiKey"/,/"value": /s/"value": "[^"]*"/"value": ""/' "$AGENT_ASSISTED_PAYMENT_IVR_FLOW_FILE"

echo "✅ Placeholders inserted!"
