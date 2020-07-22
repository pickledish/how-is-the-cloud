function getClient() {
  return new AWS.DynamoDB.DocumentClient({
    // replaced with actual keys at build time via the rollup-replace
    region: 'us-east-2',
    accessKeyId: '__dynamoAccessKey__',
    secretAccessKey: '__dynamoSecretKey__',
  });
}

export async function getService(serviceName) {

  let client = getClient();

  let keyFilter = ['ServiceId = :serviceName'];
  let keyValues = {':serviceName': serviceName};

  let params = {
    'TableName': 'History',
    'KeyConditionExpression': keyFilter,
    'ExpressionAttributeValues': keyValues,
    'ScanIndexForward': false,
    'Limit': 1,
  };

  console.log(params);

  try {
    // current user-facing page size is set to "50ish"
    let data = await client.query(params).promise();
    console.log(data);
    if (data.Items.length > 1) {
      throw "Too many items returned from query"
    } else if (data.Items.length < 1) {
      throw "No items returned from query"
    }
    return data.Items[0];
  } catch (err) {
    console.log(err);
    return err;
  }
}
