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
    if (!req.body) {
      return res.status(400).send("Request body is missing");
    } else {
      console.log(req.body.time)
      console.log(req.body.user)
      console.log(req.body.qr)
      for (let i = 0; i < req.body.time[0]?.length ?? 0; i++) {
        for (let i = 0; i < req.body.user[0]?.length ?? 0; i++) {
          RequestDatabase.query(
            "INSERT INTO Sympo (TeamId, StudentName, Qrcode, Date, Time, Getting,DateTime) VALUES ('" + req.body.teamid + "','" + req.body.user[i] + "','" + req.body.qr[i] + "','" + req.body.date + "','" + req.body.time + "','" + req.body.getting + "',GetDate())",
            (err, result) => {
              if (err) {
                console.log(err);
                return res.status(500).send("Error");
              } else {
                res.send("success");
              }
            }
          );
        }

      }


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
