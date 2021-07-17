require('dotenv').config();
const express = require('express');
const app = express();
const port = process.env.PORT || `Numéro de PORT`;

app.listen(port, _ => {
   console.log(`http://localhost:${port}`);
});