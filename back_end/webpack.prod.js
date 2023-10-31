const path = require('path')

module.exports = {
    entry:{
        main: './app.js'
    },
    output: {
        path: path.join(__dirname, 'dist'),
        publicPath: '/',
        filename: 'index.js',
        clean: true
    },
    mode: 'production',
    target: 'node',
    module:{
        rules:[
            {
                    test:/\.js$/,
                    exclude: /node_modules/,
                    loader: "babel-loader",
            }
        ]
    }
}