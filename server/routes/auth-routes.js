const authRouter = require('express').Router();
const User = require('../models/user_model');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

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
//VALIDATE TOKEN ROUTE
authRouter.post('/validateToken', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) {
            return res.status(500).json(false);
        }
        const verified = jwt.verify(token, process.env.JWT_SECRET_KEY);
        if (!verified) {
            return res.status(500).json(false);
        }
        const user = await User.findById(verified.id);
        if (!user) {
            res.status(500).json(false);
        }
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
//GET USER ROUTE
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});
module.exports = authRouter;
