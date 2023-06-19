const bodyParser = require('body-parser');
const express = require('express');
const app = express();
const path = require('path');

app.use(bodyParser.json())

app.use(express.static(path.join(__dirname, '../frontend/build')));

// API endpoint for getting the message from the backend
app.get('/api/message', (req, res) => {
  res.json({ message: 'Hello, World!' });
});



// Serve index.html for all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/build', 'index.html'));
});



const port = 3001;
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
