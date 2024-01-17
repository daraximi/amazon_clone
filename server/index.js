//IMPORTS AND DECLARATIONS
const PORT = 3000;
const express = require('express');
const app = express();

//CREATING API
app.get('/hello-world', (req, res) => {
    res.send('Hello World');
});

//SERVER LISTENER
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server started on Port ${PORT}`);
});
