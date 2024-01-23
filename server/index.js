//IMPORTS AND DECLARATIONS
const DB_CONNECTION_STRING =
    'mongodb+srv://admin:ZZ1EQqZh68ozAU3z@cluster0.zk4d2xj.mongodb.net/?retryWrites=true&w=majority';
const PORT = 3000;
const express = require('express');
const mongoose = require('mongoose');
//IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth-routes');
//INITS
const app = express();

//MIDDLEWARE
app.use(express.json());
app.use(authRouter, require('./routes/auth-routes'));

//DATABASE CONNECTION
mongoose
    .connect(DB_CONNECTION_STRING)
    .then(() => {
        console.log('Connected to database');
    })
    .catch((err) => {
        console.log(err);
    });
//SERVER LISTENER
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server started on Port ${PORT}`);
});
