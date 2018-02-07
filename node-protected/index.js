let express=require('express');

let app = express();

app.get('/',(req, res)=>{
    let ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    console.log('[GET] "/" from '+ip);
    res.json({message: 'public'})
});

app.get('/secret',(req, res)=>{
    let ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    console.log('[GET] "/secret" from '+ip);
    console.log(req.headers);
    if (req && req.headers && req.headers.verified && req.headers.verified=="true"){
        res.json({message: 'secret'})
    } else {
        res.json({message: 'access-denied'})
    }
})

let port = 8080
app.listen(port);
console.log('Listening on port '+port)

module.exports = app
