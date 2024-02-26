const express = require('express');
const { Product } = require('../models/product_model');
const auth = require('../middleware/auth');
const User = require('../models/user_model');
const userRouter = express.Router();

userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        if (!product) {
            return res.status(404).json({ error: 'Product not found' });
        }
        let user = await User.findById(req.user);
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    //user.cart[i].quantity += 1;
                    isProductFound = true;
                    break;
                }
            }
            if (isProductFound) {
                let producttt = user.cart.find((item) =>
                    item.product._id.equals(product._id)
                );
                producttt.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
            user = await user.save();
            res.json(user);
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = userRouter;
