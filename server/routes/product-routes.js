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

// /api/products/
productRouter.get(
    '/api/products/search/:searchQuery',
    auth,
    async (req, res) => {
        try {
            const products = await Product.find({
                name: { $regex: req.params.searchQuery, $options: 'i' },
            });
            res.json(products);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
    }
);

//Create a post request to rate the product.
productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        const product = await Product.findById(id);
        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId === req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.user,
            rating: rating,
        };
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = productRouter;
