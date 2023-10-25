const jwt = require("jsonwebtoken");

verifyToken = (req, res, next) => {
    let token = req.headers["x-access-token"];

    if (!token) {
        return res.status(403).send({
            message: "Aucun token a été fourni"
        });
    }

    jwt.verify(token, process.env.JWT_SECRET,
                (err, decoded) => {
                if (err) {
                    return res.status(401).send({
                        message: "Unauthorized!",
                    });
                }
                // console.log(decoded)
                req.child_id = decoded.data;
                next();
                });
};

const authJwt  = {
    verifyToken: verifyToken
}

module.exports = authJwt