#!/bin/bash

# Creates the "AD B2C Import" tenant and a test user to mimic a post-migration
# state for the list-users.png screenshot.

API_KEY="bf69486b-4733-4470-a592-f1bfce7af580"
BASE_URL="http://localhost:9011"
TENANT_ID="11111111-1111-1111-1111-111111111111"
USER_ID="22222222-2222-2222-2222-222222222222"
APP_ID="85a03867-dccf-4882-adde-1a79aeec50df"

echo "Creating AD B2C Import tenant..."
curl -s -o /dev/null -w "%{http_code}" -X POST "$BASE_URL/api/tenant/$TENANT_ID" \
  -H "Authorization: $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "tenant": {
      "name": "AD B2C Import"
    }
  }'
echo ""

echo "Creating test user in AD B2C Import tenant..."
curl -s -o /dev/null -w "%{http_code}" -X POST "$BASE_URL/api/user/$USER_ID" \
  -H "Authorization: $API_KEY" \
  -H "X-FusionAuth-TenantId: $TENANT_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email": "test@example.com",
      "firstName": "Test",
      "username": "27d1c521-f935-4dc2-b27c-7672cb1c7f56@fusiontut.onmicrosoft.com",
      "password": "password"
    }
  }'
echo ""

echo "Done. Visit http://localhost:9011/admin, go to Users, search for 'test' to verify."
