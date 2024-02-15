const express = require('express');
const admin = require('../middleware/admin');
const Product = require('../models/product_model');
const adminRouter = express.Router();

//Creating an admin middleware.
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } =
            req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
//Get all products
adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find();
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//Delete a product
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const { _id } = req.body;
        const product = await Product.findByIdAndDelete(_id);
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = adminRouter;
