let express=require('express');

let app = express();

app.get('/',(req, res)=>{
    res.json({message: 'public'})
});

app.get('/secret',(req, res)=>{
    if (req && req.headers && req.headers.verified){
        res.json({message: 'secret'})
    } else {
        res.json({message: 'access-denied'})
    }
})

let port = 8080
app.listen(port);
console.log('Listening on port '+port)

module.exports = app
