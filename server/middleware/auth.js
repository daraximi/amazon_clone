const jwt = require('jsonwebtoken');

//AUTH MIDDLEWARE
const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) {
            return res
                .status(401)
                .json({
                    message: 'No authentication token, authorization denied',
                });
        }
        const verified = jwt.verify(token, process.env.JWT_SECRET_KEY);
        if (!verified) {
            return res
                .status(401)
                .json({
                    message: 'Token verification failed, authorization denied',
                });
        }
        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = auth;