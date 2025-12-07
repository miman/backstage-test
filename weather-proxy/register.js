const fs = require('fs');
const path = require('path');
const http = require('http');

const catalogInfoPath = path.resolve(__dirname, 'catalog-info.yaml');

// In a real scenario, we might want to POST the content or a URL.
// For this local Docker setup, we are mounting the file, so we register the *file location*
// which Backstage sees inside the container.
// The container mount is: ./weather-proxy:/app/weather-proxy-source
// So the file inside container is: /app/weather-proxy-source/catalog-info.yaml

const backstageUrl = 'http://localhost:7007/api/catalog/locations';

console.log('Registering catalog-info.yaml to Backstage at ' + backstageUrl);

const postData = JSON.stringify({
  type: 'file',
  target: 'file:///app/weather-proxy-source/catalog-info.yaml'
});

const options = {
  hostname: 'localhost',
  port: 7007,
  path: '/api/catalog/locations',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(postData)
  }
};

const req = http.request(options, (res) => {
  console.log(`STATUS: ${res.statusCode}`);
  res.setEncoding('utf8');
  res.on('data', (chunk) => {
    console.log(`BODY: ${chunk}`);
  });
  res.on('end', () => {
    console.log('No more data in response.');
  });
});

req.on('error', (e) => {
  console.error(`problem with request: ${e.message}`);
});

// Write data to request body
req.write(postData);
req.end();
