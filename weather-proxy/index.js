const express = require('express');
const app = express();
const port = 3001;

app.get('/weather', (req, res) => {
  // Mock weather data
  res.json({
    location: 'Stockholm',
    temperature: 20,
    condition: 'Sunny'
  });
});

app.listen(port, () => {
  console.log(`Weather proxy listening on port ${port}`);
});
