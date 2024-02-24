const mongoose = require('mongoose');
const ratingSchema = require('./ratings_model');

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    description: {
        required: true,
        type: String,
        trim: true,
    },
    images: [
        {
            type: String,
            required: true,
        },
    ],

    quantity: {
        type: Number,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    category: {
        type: String,
        required: true,
    },
    ratings:[
        ratingSchema
    ]
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
