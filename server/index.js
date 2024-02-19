//IMPORTS AND DECLARATIONS
require('dotenv').config();

const DB_CONNECTION_STRING = process.env.MONGO_DB;
const PORT = 3000;
const express = require('express');
const mongoose = require('mongoose');
//IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth-routes');
const adminRouter = require('./routes/admin-routes');
const productRouter = require('./routes/product-routes');
//INITS
const app = express();

//MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

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
