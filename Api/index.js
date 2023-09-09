const express = require("express");
const cors = require("cors");
const mymod = require('./config/config');
const RequestDatabase = mymod.RequestDatabase;
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const apiport = 8080;

try {

  app.post("/add", (req, res) => {
    try {
      if (!req.body) {
        return res.status(400).send("Request body is missing");
      } else {
        console.log(req.body.time)
        console.log(req.body.user)
        console.log(req.body.qr)
        for (let i = 0; i < req.body.time?.length ?? 0; i++) {
          for (let j = 0; j < req.body.user?.length ?? 0; j++) {
            console.log(req.body.time[i])
            console.log(req.body.user[j])
            console.log(req.body.qr[j])
            RequestDatabase.query(
              "INSERT INTO Sympo (TeamId, StudentName, Qrcode, Date, Time,Getting) VALUES ('" + req.body.teamid + "','" + req.body.user[j] + "','" + req.body.qr[j] + "','" + req.body.date + "','" + req.body.time[i] + "','NotGetting')",
              (err, result) => {
                if (err) {
                  console.log(err);
                   res.status(500).send("Error");
                } else {
                 console.log("OK");
                }
              }
            );
          }
  
        }
        res.send("success");
      }
    } catch (error) {
      res.send(error.message);
    }
 
   
  });

  app.get('/Get', (req, res) => {
    RequestDatabase.query("select * from Sympo").then(function (recordset) {
      res.send(recordset)
    })
  });

  app.listen(apiport, () => {
    console.log("Backend server is running" + " " + apiport);
  });
} catch (error) {
  console.log("Throw Error:" + error);
}
process.on("uncaughtException", (err, origin) => {
  //code to log the errors
  console.log(`Caught exception: ${err}\n` + `Exception origin: ${origin}`);
});
