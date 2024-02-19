const productRouter = require('express').Router();
const auth = require('../middleware/auth');
const Product = require('../models/product_model');

// /api/products?category=Essentials
productRouter.get('/api/products', auth, async (req, res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({ category: req.query.category });
        res.json(products);
    } catch (e) {
        res.status(500).json({ message: e.message });
    }
});

module.exports = productRouter;
