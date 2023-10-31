const jwt = require("jsonwebtoken");

const aut = require('../models/Autorite')

verifyToken = (req, res, next) => {
    let token = req.headers["x-access-token"];
    // const bearer = token.split(" ")
    // const bearerToken = bearer[1]
    // console.log(token)
    if (!token) {
        return res.status(403).send({
            message: "Aucun token a été fourni"
        });
    }

    jwt.verify(token, process.env.JWT_SECRET,(err, decoded) => {
        if (err) {
            return res.status(401).send({
                message: "Utilisateur non requis",
            });
        }
        // console.log(decoded)
        req.child_id = decoded.data;
        // const isAutorite = aut.isAutorite(decoded.data.child_id)
        // const isAutorite = aut.isAutorite(15523)
        // if(isAutorite === false){
        //     console.log('false')
        //     return res.status(401).send({
        //         message: "Utilisateur non requis",
        //     });
        // }
        next();
    });
};

const authJwt  = {
    verifyToken: verifyToken
}

module.exports = authJwt