// server.js
const express = require('express');
const { exec } = require('child_process');
const path = require('path');

const app = express();
const port = 4005;

// Root endpoint for testing
app.get('/', (req, res) => {
  res.send('Hello World from your Node.js server!');
});

// Endpoint to execute the bash script
app.get('/run-script', (req, res) => {
  // Build the absolute path to your script
  const scriptPath = path.join(__dirname, 'scripts', 'bash-script.sh');

  // Execute the bash script using 'exec'
  exec(`bash ${scriptPath}`, (error, stdout, stderr) => {
    if (error) {
      console.error(`Execution error: ${error}`);
      return res.status(500).send(`Error: ${error.message}`);
    }
    // Send the output (stdout or stderr) as a response
    res.send(`Script output: ${stdout || stderr}`);
  });
});

// Start the server on port 5000
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
