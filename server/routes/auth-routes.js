const authRouter = require('express').Router();
const User = require('../models/user_model');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

//SIGN UP ROUTE
authRouter.post('/api/signup', async (req, res) => {
    try {
        console.log(req.body);
        //Get the data from the client
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400)
                .json({ message: 'User with the same email already exists' });
        }

        const hashedPassword = await bcrypt.hash(password, 8);

        let user = new User({
            name,
            email,
            password: hashedPassword,
        });

        //Post the data in database if valid and not existing
        user = await user.save();
        //Return the data to the user
        res.json({
            message: 'New user created',
            user,
        }).status(200);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//SIGN IN ROUTE
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        //Find user in database
        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400)
                .json({ message: 'Invalid email or password' });
        }
        //Compare password since user exists
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res
                .status(400)
                .json({ message: 'Invalid email or password' });
        }
        //Create token
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET_KEY);
        res.json({
            message: 'User signed in successfully',
            token,
            ...user._doc,
        });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = authRouter;
